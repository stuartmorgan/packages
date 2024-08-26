// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:objective_c/objective_c.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

import 'ffi_bindings.dart';
import 'messages.g.dart';

/// Maps from raw pointers to player instances. This is intended to be populated
/// and used only from within runOnPlatformThread, to ensure that owning
/// references--and thus deallocations--are restricted to that thread.
final Map<int, FVPVideoPlayer> _playersByPointer = <int, FVPVideoPlayer>{};

/// An iOS implementation of [VideoPlayerPlatform] that uses the
/// Pigeon-generated [VideoPlayerApi].
class AVFoundationVideoPlayer extends VideoPlayerPlatform {
  final AVFoundationVideoPlayerApi _api = AVFoundationVideoPlayerApi();

  /// A mapping of texture IDs to the corresponding FVPVideoPlayer pointer.
  final Map<int, int> _playerPointersByTextureId = <int, int>{};

  /// Registers this class as the default instance of [VideoPlayerPlatform].
  static void registerWith() {
    VideoPlayerPlatform.instance = AVFoundationVideoPlayer();
  }

  @override
  Future<void> init() async {
    if (!Platform.isMacOS) {
      // Allow audio playback when the Ring/Silent switch is set to silent.
      await runOnPlatformThread<void>(() {
        // https://github.com/dart-lang/native/issues/1418
        final NSString categoryPlayback =
            NSString.castFromPointer(_lib.AVAudioSessionCategoryPlayback);
        AVAudioSession.sharedInstance()
            .setCategory_error_(categoryPlayback, ffi.nullptr);
      });
    }
    await _api.initialize();
    // TODO(stuartmorgan): See if this is actually necessary, or if hot reload
    // and restart already do the right thing.
    await runOnPlatformThread<void>(() {
      _playersByPointer.clear();
    });
  }

  @override
  Future<void> dispose(int textureId) async {
    final int? pointer = _playerPointersByTextureId.remove(textureId);
    if (pointer != null) {
      await _api.dispose(pointer);
      // Remove the owning reference to the player on the platform thread.
      await runOnPlatformThread<void>(() {
        _playersByPointer.remove(pointer);
      });
    }
  }

  @override
  Future<int?> create(DataSource dataSource) async {
    String? uri;
    Map<String, String> httpHeaders = <String, String>{};
    switch (dataSource.sourceType) {
      case DataSourceType.asset:
        final String? asset = dataSource.asset;
        if (asset == null) {
          throw ArgumentError('"asset" must be set for DataSourceType.asset');
        }
        final String? assetPath =
            await _api.pathForAsset(asset, dataSource.package);
        if (assetPath == null) {
          throw ArgumentError(
              'Unable to load "$asset" from package "${dataSource.package}"');
        }
        uri = Uri.file(assetPath).toString();
      case DataSourceType.network:
        uri = dataSource.uri;
        httpHeaders = dataSource.httpHeaders;
      case DataSourceType.file:
        uri = dataSource.uri;
      case DataSourceType.contentUri:
        throw UnsupportedError(
            'Content URIs are not supported on this platform');
    }
    if (uri == null) {
      throw UnimplementedError(
          'Unsupported source type: ${dataSource.sourceType}');
    }

    final ffi.Pointer<ObjCObject> rawPointer =
        await runOnPlatformThread<ffi.Pointer<ObjCObject>>(() {
      final NSURL? nsurl = NSURL.URLWithString_(NSString(uri!));
      if (nsurl == null) {
        return ffi.nullptr;
      }
      NSDictionary? options;
      if (httpHeaders.isNotEmpty) {
        options = _convertMap(
            <String?, Object>{'AVURLAssetHTTPHeaderFieldsKey': httpHeaders});
      }
      final AVURLAsset asset =
          AVURLAsset.URLAssetWithURL_options_(nsurl, options);
      final AVPlayerItem avItem = AVPlayerItem.playerItemWithAsset_(asset);
      // TODO(stuartmorgan): Check if this does the right thing.
      final FVPDefaultAVFactory avFactory = FVPDefaultAVFactory.alloc().init();
      final FVPVideoPlayer player = FVPVideoPlayer.alloc()
          .initWithPlayerItem_AVFactory_(avItem, avFactory);
      _playersByPointer[player.pointer.address] = player;
      return player.pointer;
    });
    if (rawPointer == ffi.nullptr) {
      throw PlatformException(
          code: 'player initialization',
          message: 'Failed to create native player');
    }

    final int nativePlayerPointer = rawPointer.address;
    final int textureId =
        await _api.configurePlayerPointer(nativePlayerPointer);
    _playerPointersByTextureId[textureId] = nativePlayerPointer;
    return textureId;
  }

  @override
  Future<void> setLooping(int textureId, bool looping) {
    final int pointer = _pointerForTexture(textureId);
    return runOnPlatformThread<void>(
        () => _playerFromPointer(pointer).isLooping = looping);
  }

  @override
  Future<void> play(int textureId) {
    final int pointer = _pointerForTexture(textureId);
    return runOnPlatformThread<void>(() => _playerFromPointer(pointer).play());
  }

  @override
  Future<void> pause(int textureId) {
    final int pointer = _pointerForTexture(textureId);
    return runOnPlatformThread<void>(() => _playerFromPointer(pointer).pause());
  }

  @override
  Future<void> setVolume(int textureId, double volume) {
    final int pointer = _pointerForTexture(textureId);
    return runOnPlatformThread<void>(
        () => _playerFromPointer(pointer).setVolume_(volume));
  }

  @override
  Future<void> setPlaybackSpeed(int textureId, double speed) {
    assert(speed > 0);

    final int pointer = _pointerForTexture(textureId);
    return runOnPlatformThread<void>(
        () => _playerFromPointer(pointer).setPlaybackSpeed_(speed));
  }

  @override
  Future<void> seekTo(int textureId, Duration position) {
    final int pointer = _pointerForTexture(textureId);
    return runOnPlatformThread<void>(() {
      final Completer<void> seekFinished = Completer<void>();
      _playerFromPointer(pointer).seekTo_completionHandler_(
          position.inMilliseconds,
          ObjCBlock_ffiVoid_bool.listener(
              (bool succeeded) => seekFinished.complete()));
      return seekFinished.future;
    });
  }

  @override
  Future<Duration> getPosition(int textureId) async {
    final int pointer = _pointerForTexture(textureId);
    final int position = await runOnPlatformThread<int>(
        () => _playerFromPointer(pointer).position);
    return Duration(milliseconds: position);
  }

  @override
  Stream<VideoEvent> videoEventsFor(int textureId) {
    return _eventChannelFor(textureId)
        .receiveBroadcastStream()
        .map((dynamic event) {
      final Map<dynamic, dynamic> map = event as Map<dynamic, dynamic>;
      switch (map['event']) {
        case 'initialized':
          return VideoEvent(
            eventType: VideoEventType.initialized,
            duration: Duration(milliseconds: map['duration'] as int),
            size: Size((map['width'] as num?)?.toDouble() ?? 0.0,
                (map['height'] as num?)?.toDouble() ?? 0.0),
          );
        case 'completed':
          return VideoEvent(
            eventType: VideoEventType.completed,
          );
        case 'bufferingUpdate':
          final List<dynamic> values = map['values'] as List<dynamic>;

          return VideoEvent(
            buffered: values.map<DurationRange>(_toDurationRange).toList(),
            eventType: VideoEventType.bufferingUpdate,
          );
        case 'bufferingStart':
          return VideoEvent(eventType: VideoEventType.bufferingStart);
        case 'bufferingEnd':
          return VideoEvent(eventType: VideoEventType.bufferingEnd);
        case 'isPlayingStateUpdate':
          return VideoEvent(
            eventType: VideoEventType.isPlayingStateUpdate,
            isPlaying: map['isPlaying'] as bool,
          );
        default:
          return VideoEvent(eventType: VideoEventType.unknown);
      }
    });
  }

  @override
  Widget buildView(int textureId) {
    return Texture(textureId: textureId);
  }

  @override
  Future<void> setMixWithOthers(bool mixWithOthers) async {
    // AVAudioSession doesn't exist on macOS, and audio always mixes, so just
    // no-op there.
    if (!Platform.isMacOS) {
      await runOnPlatformThread<void>(() {
        // https://github.com/dart-lang/native/issues/1418
        final NSString categoryPlayback =
            NSString.castFromPointer(_lib.AVAudioSessionCategoryPlayback);
        if (mixWithOthers) {
          AVAudioSession.sharedInstance().setCategory_withOptions_error_(
              categoryPlayback,
              AVAudioSessionCategoryOptions
                  .AVAudioSessionCategoryOptionMixWithOthers,
              ffi.nullptr);
        } else {
          AVAudioSession.sharedInstance()
              .setCategory_error_(categoryPlayback, ffi.nullptr);
        }
      });
    }
  }

  int _pointerForTexture(int textureId) {
    final int? pointer = _playerPointersByTextureId[textureId];
    if (pointer == null) {
      throw StateError('methods must not be called on a disposed player');
    }
    return pointer;
  }

  EventChannel _eventChannelFor(int textureId) {
    return EventChannel('flutter.io/videoPlayer/videoEvents$textureId');
  }

  DurationRange _toDurationRange(dynamic value) {
    final List<dynamic> pair = value as List<dynamic>;
    return DurationRange(
      Duration(milliseconds: pair[0] as int),
      Duration(milliseconds: pair[1] as int),
    );
  }
}

FVPVideoPlayer _playerFromPointer(int pointer) {
  final FVPVideoPlayer? player = _playersByPointer[pointer];
  if (player == null) {
    throw StateError('Attempting to use a disposed pointer');
  }
  return player;
}

//const String _libName = 'video_player_avfoundation';

/// The dynamic library in which the symbols for [FVPVideo] can be found.
final ffi.DynamicLibrary _dylib = () {
  //return ffi.DynamicLibrary.open('$_libName.framework/$_libName');
  return ffi.DynamicLibrary.executable();
}();

/// The bindings to the native functions in [_dylib].
final FVPVideo _lib = () {
  return FVPVideo(_dylib);
}();

NSDictionary _convertMap(Map<Object?, Object?> map) {
  final NSMutableDictionary dict =
      NSMutableDictionary.dictionaryWithCapacity_(map.length);
  for (final MapEntry<Object?, Object?> entry in map.entries) {
    dict.setObject_forKey_(_covertKnownTypeWithNSNull(entry.value),
        _covertKnownTypeWithNSNull(entry.key));
  }
  return dict;
}

NSArray _convertList(List<Object?> list) {
  final NSMutableArray array = NSMutableArray.arrayWithCapacity_(list.length);
  for (final Object? o in list) {
    array.addObject_(_covertKnownTypeWithNSNull(o));
  }
  return array;
}

NSObject? _convertKnownType(Object? o) {
  return switch (o) {
    null => null,
    final String s => NSString(s),
    final List<Object?> l => _convertList(l),
    final Map<Object?, Object?> m => _convertMap(m),
    final int i => NSNumber.numberWithInt_(i),
    final double d => NSNumber.numberWithDouble_(d),
    _ => throw UnimplementedError('No conversion for $o'),
  };
}

NSObject _covertKnownTypeWithNSNull(Object? o) {
  return _convertKnownType(o) ?? NSNull.null1();
}
