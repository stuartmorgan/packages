// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

import 'ffi_bindings.dart';
import 'messages.g.dart';

/// An iOS implementation of [VideoPlayerPlatform] that uses the
/// Pigeon-generated [VideoPlayerApi].
class AVFoundationVideoPlayer extends VideoPlayerPlatform {
  final AVFoundationVideoPlayerApi _api = AVFoundationVideoPlayerApi();

  /// A mapping of texture IDs to the corresponding FVPVideoPlayer raw pointer.
  ///
  /// Values *must* be removed from this before calling `_api.dispose` with the
  /// corresponding texture ID, as the pointers become invalid after that point.
  // TODO(stuartmorgan): Investigate using Dart-driven lifetimes for these to
  // replace the dispose API call.
  final Map<int, int> _playerPointersByTextureId = <int, int>{};

  /// Registers this class as the default instance of [VideoPlayerPlatform].
  static void registerWith() {
    VideoPlayerPlatform.instance = AVFoundationVideoPlayer();
  }

  @override
  Future<void> init() {
    return _api.initialize();
  }

  @override
  Future<void> dispose(int textureId) {
    _playerPointersByTextureId.remove(textureId);
    return _api.dispose(textureId);
  }

  @override
  Future<int?> create(DataSource dataSource) async {
    String? asset;
    String? packageName;
    String? uri;
    String? formatHint;
    Map<String, String> httpHeaders = <String, String>{};
    switch (dataSource.sourceType) {
      case DataSourceType.asset:
        asset = dataSource.asset;
        packageName = dataSource.package;
      case DataSourceType.network:
        uri = dataSource.uri;
        formatHint = _videoFormatStringMap[dataSource.formatHint];
        httpHeaders = dataSource.httpHeaders;
      case DataSourceType.file:
        uri = dataSource.uri;
      case DataSourceType.contentUri:
        uri = dataSource.uri;
    }
    final CreationOptions options = CreationOptions(
      asset: asset,
      packageName: packageName,
      uri: uri,
      httpHeaders: httpHeaders,
      formatHint: formatHint,
    );

    final VideoPlayerNativeDetails playerDetails = await _api.create(options);
    _playerPointersByTextureId[playerDetails.textureId] =
        playerDetails.nativePlayerPointer;
    return playerDetails.textureId;
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
              _lib, (bool succeeded) => seekFinished.complete()));
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
  Future<void> setMixWithOthers(bool mixWithOthers) {
    return _api.setMixWithOthers(mixWithOthers);
  }

  int _pointerForTexture(int textureId) {
    final int? pointer = _playerPointersByTextureId[textureId];
    if (pointer == null) {
      throw StateError('methods must not be called on a disposed player');
    }
    return pointer;
  }

  FVPVideoPlayer _playerFromPointer(int pointer) {
    return FVPVideoPlayer.castFromPointer(
        _lib, ffi.Pointer<ObjCObject>.fromAddress(pointer));
  }

  EventChannel _eventChannelFor(int textureId) {
    return EventChannel('flutter.io/videoPlayer/videoEvents$textureId');
  }

  static const Map<VideoFormat, String> _videoFormatStringMap =
      <VideoFormat, String>{
    VideoFormat.ss: 'ss',
    VideoFormat.hls: 'hls',
    VideoFormat.dash: 'dash',
    VideoFormat.other: 'other',
  };

  DurationRange _toDurationRange(dynamic value) {
    final List<dynamic> pair = value as List<dynamic>;
    return DurationRange(
      Duration(milliseconds: pair[0] as int),
      Duration(milliseconds: pair[1] as int),
    );
  }
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
