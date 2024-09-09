// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:io';
import 'dart:math' as math;

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:objective_c/objective_c.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

import 'ffi_bindings.dart';
import 'messages.g.dart';

// Key paths observed via KVO.
// AVPlayerItem
const String _observerKeyPathStatus = 'status';
const String _observerKeyPathLoadedTimeRanges = 'loadedTimeRanges';
const String _observerKeyPathPresentationSize = 'presentationSize';
const String _observerKeyPathDuration = 'duration';
const String _observerKeyPathPlaybackLikelyToKeepUp = 'playbackLikelyToKeepUp';
// AVPlayer
const String _observerKeyPathRate = 'rate';

/// An iOS implementation of [VideoPlayerPlatform] that uses the
/// Pigeon-generated [VideoPlayerApi].
class AVFoundationVideoPlayer extends VideoPlayerPlatform {
  final AVFoundationVideoPlayerApi _api = AVFoundationVideoPlayerApi();

  /// A mapping of texture IDs to the corresponding player instances.
  final Map<int, _VideoPlayer> _playersByTextureId = <int, _VideoPlayer>{};

  /// Registers this class as the default instance of [VideoPlayerPlatform].
  static void registerWith() {
    VideoPlayerPlatform.instance = AVFoundationVideoPlayer();
  }

  @override
  Future<void> init() async {
    if (!Platform.isMacOS) {
      // Allow audio playback when the Ring/Silent switch is set to silent.
      AVAudioSession.sharedInstance()
          .setCategory_error_(_lib.AVAudioSessionCategoryPlayback, ffi.nullptr);
    }
  }

  @override
  Future<void> dispose(int textureId) async {
    _playersByTextureId.remove(textureId)?.dispose();
    debugPrint('Top-level dispose');
  }

  @override
  Future<int?> create(DataSource dataSource) async {
    final AVURLAsset asset = await _assetForDataSource(dataSource);
    final int nativeViewProviderPointer = await _api.getViewProviderPointer();
    final NSObject nativeViewProvider = NSObject.castFromPointer(
        ffi.Pointer<ObjCObject>.fromAddress(nativeViewProviderPointer));
    final _VideoPlayer player = _VideoPlayer(asset, nativeViewProvider);

    final int textureId =
        await _api.configurePlayerPointer(player.nativePlayer.pointer.address);
    _playersByTextureId[textureId] = player;

    // Ensure that the first frame is drawn once available, even if the video
    // isn't played.
    player.expectFrame();

    // This must be done after the player is configured, since it can trigger
    // drawing.
    player.registerObservers();

    return textureId;
  }

  @override
  Future<void> setLooping(int textureId, bool looping) async {
    _playerForTexture(textureId).looping = looping;
  }

  @override
  Future<void> play(int textureId) async {
    _playerForTexture(textureId).play();
  }

  @override
  Future<void> pause(int textureId) async {
    _playerForTexture(textureId).pause();
  }

  @override
  Future<void> setVolume(int textureId, double volume) async {
    final double clamped = math.min(1.0, math.max(0.0, volume));
    _playerForTexture(textureId).volume = clamped;
  }

  @override
  Future<void> setPlaybackSpeed(int textureId, double speed) async {
    assert(speed > 0);
    _playerForTexture(textureId).setPlaybackSpeed(speed);
  }

  @override
  Future<void> seekTo(int textureId, Duration position) {
    return _playerForTexture(textureId).seekTo(position);
  }

  @override
  Future<Duration> getPosition(int textureId) async {
    return _playerForTexture(textureId).position;
  }

  @override
  Stream<VideoEvent> videoEventsFor(int textureId) {
    return _playerForTexture(textureId).stream;
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
      if (mixWithOthers) {
        AVAudioSession.sharedInstance().setCategory_withOptions_error_(
            _lib.AVAudioSessionCategoryPlayback,
            AVAudioSessionCategoryOptions
                .AVAudioSessionCategoryOptionMixWithOthers,
            ffi.nullptr);
      } else {
        AVAudioSession.sharedInstance().setCategory_error_(
            _lib.AVAudioSessionCategoryPlayback, ffi.nullptr);
      }
    }
  }

  Future<AVURLAsset> _assetForDataSource(DataSource source) async {
    String? uri;
    Map<String, String> httpHeaders = <String, String>{};
    switch (source.sourceType) {
      case DataSourceType.asset:
        final String? asset = source.asset;
        if (asset == null) {
          throw ArgumentError('"asset" must be set for DataSourceType.asset');
        }
        final String? assetPath =
            await _api.pathForAsset(asset, source.package);
        if (assetPath == null) {
          throw ArgumentError(
              'Unable to load "$asset" from package "${source.package}"');
        }
        uri = Uri.file(assetPath).toString();
      case DataSourceType.network:
        uri = source.uri;
        httpHeaders = source.httpHeaders;
      case DataSourceType.file:
        uri = source.uri;
      case DataSourceType.contentUri:
        throw UnsupportedError(
            'Content URIs are not supported on this platform');
    }
    if (uri == null) {
      throw UnimplementedError('Unsupported source type: ${source.sourceType}');
    }

    final NSURL? nsurl = NSURL.URLWithString_(NSString(uri));
    if (nsurl == null) {
      throw PlatformException(
          code: 'player initialization', message: 'Failed to create NSURL');
    }
    NSDictionary? options;
    if (httpHeaders.isNotEmpty) {
      options = _convertMap(
          <String?, Object>{'AVURLAssetHTTPHeaderFieldsKey': httpHeaders});
    }
    return AVURLAsset.URLAssetWithURL_options_(nsurl, options);
  }

  _VideoPlayer _playerForTexture(int textureId) {
    final _VideoPlayer? player = _playersByTextureId[textureId];
    if (player == null) {
      throw StateError('Methods must not be called on a disposed player');
    }
    return player;
  }
}

typedef _RegistrationState = ({
  ObjCObjectBase notificationCenterToken,
  AVPlayer observedPlayer,
  AVPlayerItem observedPlayerItem,
  FVPBlockKeyValueObserver playerObserver,
  FVPBlockKeyValueObserver itemObserver,
});

/// An instance of a video player.
class _VideoPlayer {
  _VideoPlayer(AVAsset asset, NSObject nativeViewProvider) {
    final AVPlayerItem avItem = AVPlayerItem.playerItemWithAsset_(asset);
    final FVPDefaultAVFactory avFactory = FVPDefaultAVFactory.alloc().init();
    // TODO(stuartmorgan): Eliminate this completely? Or at least convert it to
    // Dart.
    final FVPFrameUpdater frameUpdater = FVPFrameUpdater.alloc().init();
    _displayLink = FVPDisplayLink.alloc().initWithViewProvider_callback_(
        nativeViewProvider,
        ObjCBlock_ffiVoid.listener(() => frameUpdater.displayLinkFired()));
    final WeakReference<_VideoPlayer> weakSelf =
        WeakReference<_VideoPlayer>(this);
    nativePlayer = FVPVideoPlayer.alloc()
        .initWithPlayerItem_viewProvider_frameUpdater_AVFactory_frameCallback_(
            avItem,
            nativeViewProvider,
            frameUpdater,
            avFactory,
            ObjCBlock_ffiVoid.listener(
                () => weakSelf.target?._onFrameProvided()));
    _eventAdapter = _DelegateEventAdapter();

    // TODO(stuartmorgan): Remove this once the final version has been verified
    // to be retain-loop-free.
    _xxxFinalizer.attach(this, null);
  }

  static final Finalizer<_RegistrationState> _unregistrationFinalizer =
      Finalizer<_RegistrationState>((_RegistrationState state) {
    NSNotificationCenter.getDefaultCenter()
        .removeObserver_(state.notificationCenterToken);
    _unregisterPlayerObserver(state.observedPlayer, state.playerObserver);
    _unregisterItemObserver(state.observedPlayerItem, state.itemObserver);
  });

  static final Finalizer<void> _xxxFinalizer = Finalizer<void>((_) {
    debugPrint('Finalized!');
  });

  late final FVPVideoPlayer nativePlayer;
  bool _initialized = false;
  // Wether the player play if possible. This can temporarily be out of sync
  // with the actual AVPlayer play state in some cases, such as while waiting
  // for the player item to finish loading.
  bool _shouldBePlaying = false;
  // True if a new frame is expected while the player is not playing (e.g.,
  // when seeking while paused). When true, the display link should continue to
  // run until the next frame is successfully provided.
  bool _waitingForFrame = false;
  FVPDisplayLink? _displayLink;
  _DelegateEventAdapter? _eventAdapter;
  ObjCObjectBase? _observerRegistrationToken;
  FVPBlockKeyValueObserver? _playerKvoBridge;
  FVPBlockKeyValueObserver? _itemKvoBridge;

  static const List<String> _playerItemKeyPaths = <String>[
    _observerKeyPathStatus,
    _observerKeyPathLoadedTimeRanges,
    _observerKeyPathPresentationSize,
    _observerKeyPathDuration,
    _observerKeyPathPlaybackLikelyToKeepUp,
  ];

  Stream<VideoEvent> get stream {
    final _DelegateEventAdapter? adapter = _eventAdapter;
    if (adapter == null) {
      throw StateError('Attempting to get stream for disposed player');
    }
    return adapter.stream;
  }

  bool looping = false;

  void dispose() {
    debugPrint('disposed!');
    _unregisterObservers();
    _displayLink = null;
    nativePlayer.dispose();
  }

  void registerObservers() {
    final AVPlayerItem avItem = nativePlayer.player.currentItem!;
    final WeakReference<_VideoPlayer> weakSelf =
        WeakReference<_VideoPlayer>(this);

    final FVPBlockKeyValueObserver playerKvoBridge =
        FVPBlockKeyValueObserver.observerWithCallback_(
            ObjCBlock_ffiVoid_objcObjCObject_NSString.listener(
                (ObjCObjectBase object, NSString keyPath) {
      final _VideoPlayer? self = weakSelf.target;
      final _DelegateEventAdapter? adapter = self?._eventAdapter;
      if (self == null || adapter == null) {
        return;
      }
      // No need to check keyPath because only one key path is observed.
      adapter.onPlayStateChanged(self.nativePlayer.player.rate > 0);
    }));
    _registerPlayerObserver(nativePlayer.player, playerKvoBridge);
    _playerKvoBridge = playerKvoBridge;

    final FVPBlockKeyValueObserver itemKvoBridge =
        FVPBlockKeyValueObserver.observerWithCallback_(
            ObjCBlock_ffiVoid_objcObjCObject_NSString.listener(
                (ObjCObjectBase object, NSString keyPath) {
      final _VideoPlayer? self = weakSelf.target;
      final _DelegateEventAdapter? adapter = self?._eventAdapter;
      if (self == null || adapter == null) {
        return;
      }
      switch (keyPath.toString()) {
        case _observerKeyPathLoadedTimeRanges:
          adapter.onBufferingUpdated(avItem);
        case _observerKeyPathStatus:
          switch (avItem.status) {
            case AVPlayerItemStatus.AVPlayerItemStatusFailed:
              _reportError(
                  'Failed to load video: ${avItem.error?.localizedDescription}');
            case AVPlayerItemStatus.AVPlayerItemStatusReadyToPlay:
              avItem.addOutput_(self.nativePlayer.videoOutput!);
              self._checkInitializationStatus();
            case AVPlayerItemStatus.AVPlayerItemStatusUnknown:
              // No-op; wait for a known status.
              break;
          }
        case _observerKeyPathPresentationSize:
        case _observerKeyPathDuration:
          if (avItem.status ==
              AVPlayerItemStatus.AVPlayerItemStatusReadyToPlay) {
            // Due to an apparent bug, when the player item is ready, it
            // still may not have determined its presentation size or
            // duration. When these properties are finally set, re-check
            // whether the player is ready.
            self._checkInitializationStatus();
          }
        case _observerKeyPathPlaybackLikelyToKeepUp:
          self._updatePlayingState();
          if (avItem.playbackLikelyToKeepUp) {
            adapter.onBufferingEnded();
          } else {
            adapter.onBufferingStarted();
          }
      }
    }));
    _registerItemObserver(avItem, itemKvoBridge);
    _itemKvoBridge = itemKvoBridge;

    final ObjCObjectBase registrationToken =
        NSNotificationCenter.getDefaultCenter()
            .addObserverForName_object_queue_usingBlock_(
                _lib.AVPlayerItemDidPlayToEndTimeNotification, avItem, null,
                ObjCBlock_ffiVoid_NSNotification.listener(
                    (NSNotification notification) {
      weakSelf.target?._onPlaybackCompleted();
    }));
    _unregistrationFinalizer.attach(
        this,
        (
          notificationCenterToken: registrationToken,
          observedPlayer: nativePlayer.player,
          observedPlayerItem: avItem,
          playerObserver: playerKvoBridge,
          itemObserver: itemKvoBridge,
        ),
        detach: this);
    _observerRegistrationToken = registrationToken;
  }

  void _unregisterObservers() {
    if (_playerKvoBridge != null) {
      final AVPlayer player = nativePlayer.player;
      _unregisterPlayerObserver(player, _playerKvoBridge!);
      _playerKvoBridge = null;
    }
    if (_itemKvoBridge != null) {
      final AVPlayerItem? item = nativePlayer.player.currentItem;
      if (item != null) {
        _unregisterItemObserver(item, _itemKvoBridge!);
      }
      _itemKvoBridge = null;
    }

    if (_observerRegistrationToken != null) {
      NSNotificationCenter.getDefaultCenter()
          .removeObserver_(_observerRegistrationToken!);
      _unregistrationFinalizer.detach(this);
      _observerRegistrationToken = null;
    }
  }

  static void _registerItemObserver(
      AVPlayerItem item, FVPBlockKeyValueObserver observer) {
    for (final String keyPath in _playerItemKeyPaths) {
      item.addObserver_forKeyPath_options_context_(
          observer,
          NSString(keyPath),
          NSKeyValueObservingOptions.NSKeyValueObservingOptionInitial,
          ffi.nullptr);
    }
  }

  static void _unregisterItemObserver(
      AVPlayerItem item, FVPBlockKeyValueObserver observer) {
    for (final String keyPath in _playerItemKeyPaths) {
      item.removeObserver_forKeyPath_(observer, NSString(keyPath));
    }
  }

  static void _registerPlayerObserver(
      AVPlayer player, FVPBlockKeyValueObserver observer) {
    player.addObserver_forKeyPath_options_context_(
        observer,
        NSString(_observerKeyPathRate),
        NSKeyValueObservingOptions.NSKeyValueObservingOptionInitial,
        ffi.nullptr);
  }

  static void _unregisterPlayerObserver(
      AVPlayer player, FVPBlockKeyValueObserver observer) {
    player.removeObserver_forKeyPath_(observer, NSString(_observerKeyPathRate));
  }

  void play() {
    _shouldBePlaying = true;
    _updatePlayingState();
  }

  void pause() {
    _shouldBePlaying = false;
    _updatePlayingState();
  }

  void _updatePlayingState() {
    final FVPDisplayLink? displayLink = _displayLink;
    if (!_initialized || displayLink == null) {
      return;
    }
    if (_shouldBePlaying) {
      nativePlayer.player.play();
    } else {
      nativePlayer.player.pause();
    }
    displayLink.running = _shouldBePlaying || _waitingForFrame;
  }

  set volume(double volume) {
    nativePlayer.player.volume = volume;
  }

  double get volume => nativePlayer.player.volume;

  void setPlaybackSpeed(double speed) {
    // See https://developer.apple.com/library/archive/qa/qa1772/_index.html for an explanation of
    // these checks.
    const double maxAlwaysSupportedSpeed = 2.0;
    const double minAlwaysSupportedSpeed = 1.0;
    double clamped = speed;
    if (speed > maxAlwaysSupportedSpeed &&
        !(nativePlayer.player.currentItem?.canPlayFastForward ?? false)) {
      clamped = maxAlwaysSupportedSpeed;
    }
    if (speed < 1.0 &&
        !(nativePlayer.player.currentItem?.canPlaySlowForward ?? false)) {
      clamped = minAlwaysSupportedSpeed;
    }

    nativePlayer.player.rate = clamped;
  }

  Future<void> seekTo(Duration targetPosition) {
    // Work around https://github.com/dart-lang/native/issues/1480 by using
    // position instead of the raw CMTime from player.currentTime.
    final Duration previousPosition = position;
    final CMTime targetCMTime =
        _lib.CMTimeMake(targetPosition.inMilliseconds, 1000);
    // Without adding tolerance when seeking to duration,
    // seekToTime will never complete, and this call will hang.
    // see issue https://github.com/flutter/flutter/issues/124475.
    final CMTime tolerance = targetPosition == duration
        ? _lib.CMTimeMake(1, 1000)
        : _lib.kCMTimeZero;
    final Completer<void> seekFinished = Completer<void>();
    nativePlayer.player
        .seekToTime_toleranceBefore_toleranceAfter_completionHandler_(
            targetCMTime, tolerance, tolerance,
            ObjCBlock_ffiVoid_bool.listener((bool completed) {
      if (position != previousPosition) {
        // Ensure that a frame is drawn once available, even if currently
        // paused. In theory a race is possible here where the new frame has
        // already drawn by the time this code runs, and the display link stays
        // on indefinitely, but that should be relatively harmless. This must
        // use the display link rather than just informing the engine that a new
        // frame is available because the seek completing doesn't guarantee that
        // the pixel buffer is already available.
        expectFrame();
      }
      seekFinished.complete();
    }));
    return seekFinished.future;
  }

  Duration get position {
    // Work around https://github.com/dart-lang/native/issues/1480
    final ffi.Pointer<CMTime> currentTimePtr = calloc<CMTime>();
    nativePlayer.player.currentTime(currentTimePtr);
    final int milliseconds = _millisecondsFromCMTime(currentTimePtr.ref);
    calloc.free(currentTimePtr);
    return Duration(milliseconds: milliseconds);
  }

  Duration get duration {
    // Note: https://openradar.appspot.com/radar?id=4968600712511488
    // `[AVPlayerItem duration]` can be `kCMTimeIndefinite`,
    // use `[[AVPlayerItem asset] duration]` instead.
    final AVPlayerItem? currentItem = nativePlayer.player.currentItem;
    if (currentItem == null) {
      return Duration.zero;
    }
    // Work around https://github.com/dart-lang/native/issues/1480
    final ffi.Pointer<CMTime> currentTimePtr = calloc<CMTime>();
    currentItem.asset.getDuration(currentTimePtr);
    final int milliseconds = _millisecondsFromCMTime(currentTimePtr.ref);
    calloc.free(currentTimePtr);
    return Duration(milliseconds: milliseconds);
  }

  void _onFrameProvided() {
    if (_waitingForFrame) {
      _waitingForFrame = false;
      // If the display link was only running temporarily to pick up a new frame
      // while the video was paused, stop it again.
      if (!_shouldBePlaying) {
        _displayLink?.running = false;
      }
    }
  }

  void _checkInitializationStatus() {
    if (_initialized) {
      return;
    }
    final AVPlayerItem? currentItem = nativePlayer.player.currentItem;
    if (currentItem == null) {
      return;
    }
    // Work around https://github.com/dart-lang/native/issues/1480
    final ffi.Pointer<CGSize> sizePtr = calloc<CGSize>();
    currentItem.getPresentationSize(sizePtr);
    final Size size = Size(sizePtr.ref.width, sizePtr.ref.height);
    calloc.free(sizePtr);

    // Wait until tracks are loaded to check duration or if there are any videos.
    final AVAsset asset = currentItem.asset;
    if (asset.statusOfValueForKey_error_(NSString('tracks'), ffi.nullptr) !=
        AVKeyValueStatus.AVKeyValueStatusLoaded) {
      asset.loadValuesAsynchronouslyForKeys_completionHandler_(
          _convertList(<String>['tracks']), ObjCBlock_ffiVoid.listener(() {
        if (asset.statusOfValueForKey_error_(NSString('tracks'), ffi.nullptr) !=
            AVKeyValueStatus.AVKeyValueStatusLoaded) {
          // Cancelled, or something failed.
          return;
        }
        _checkInitializationStatus();
      }));
      return;
    }

    final bool hasVideoTracks =
        asset.tracksWithMediaType_(_lib.AVMediaTypeVideo).count != 0;
    final bool hasTracks = asset.tracks.count != 0;

    // The player has not yet initialized when it has no size, unless it is an audio-only track.
    // HLS m3u8 video files never load any tracks, and are also not yet initialized until they have
    // a size.
    if ((hasVideoTracks || !hasTracks) && size.height == 0 && size.width == 0) {
      return;
    }
    // The player may be initialized but still needs to determine the duration.
    final Duration duration = this.duration;
    if (duration == Duration.zero) {
      return;
    }

    _initialized = true;
    _eventAdapter?.streamController.add(VideoEvent(
      eventType: VideoEventType.initialized,
      duration: duration,
      size: size,
    ));
    // If the player had a pending play state, start playing.
    if (_shouldBePlaying) {
      play();
    }
  }

  void expectFrame() {
    final FVPDisplayLink? displayLink = _displayLink;
    if (displayLink == null) {
      return;
    }
    _waitingForFrame = true;
    displayLink.running = true;
  }

  void _onPlaybackCompleted() {
    if (looping) {
      seekTo(Duration.zero);
    } else {
      _eventAdapter?.streamController.add(VideoEvent(
        eventType: VideoEventType.completed,
      ));
    }
  }
}

class _DelegateEventAdapter {
  final StreamController<VideoEvent> streamController =
      StreamController<VideoEvent>.broadcast();

  Stream<VideoEvent> get stream => streamController.stream;

  void onBufferingStarted() {
    streamController.add(VideoEvent(eventType: VideoEventType.bufferingStart));
  }

  void onBufferingUpdated(AVPlayerItem playerItem) {
    streamController.add(VideoEvent(
      buffered: _listFromArray(playerItem.loadedTimeRanges)
          .map((ObjCObjectBase o) => NSValue.castFrom(o))
          .map((NSValue e) => e.CMTimeRangeValue)
          .map(_durationRangeFromTimeRange)
          .toList(),
      eventType: VideoEventType.bufferingUpdate,
    ));
  }

  void onBufferingEnded() {
    streamController.add(VideoEvent(eventType: VideoEventType.bufferingEnd));
  }

  void onPlayStateChanged(bool playing) {
    streamController.add(VideoEvent(
      eventType: VideoEventType.isPlayingStateUpdate,
      isPlaying: playing,
    ));
  }

  DurationRange _durationRangeFromTimeRange(CMTimeRange range) {
    final int startMilliseconds = _millisecondsFromCMTime(range.start);
    return DurationRange(
      Duration(milliseconds: startMilliseconds),
      Duration(
          milliseconds:
              startMilliseconds + _millisecondsFromCMTime(range.duration)),
    );
  }
}

void _reportError(String message) {
  // TODO(stuartmorgan): Handle errors. Previously they were just turned into
  // 'unknown' events with no details :| For now, print them for my own
  // debugging.
  debugPrint(message);
}

//const String _libName = 'video_player_avfoundation';

/// The dynamic library in which the symbols for [FVPVideo] can be found.
final ffi.DynamicLibrary _dylib = () {
  // TODO(stuartmorgan): Make this work both ways.
  //return ffi.DynamicLibrary.open('$_libName.framework/$_libName');
  return ffi.DynamicLibrary.executable();
}();

/// The bindings to the native functions in [_dylib].
final FVPVideo _lib = () {
  return FVPVideo(_dylib);
}();

List<ObjCObjectBase> _listFromArray(NSArray array) {
  final List<ObjCObjectBase> list = <ObjCObjectBase>[];
  for (int i = 0; i < array.count; i++) {
    list.add(array.objectAtIndex_(i));
  }
  return list;
}

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

// From CMTIME_IS_VALID definition in CMTime.h.
bool _cmTimeIsValid(CMTime time) {
  return time.flags & CMTimeFlags.kCMTimeFlags_Valid.value != 0;
}

// From CMTIME_IS_INDEFINITE definition in CMTime.h.
bool _cmTimeIsIndefinite(CMTime time) {
  return _cmTimeIsValid(time) &&
      (time.flags & CMTimeFlags.kCMTimeFlags_Indefinite.value != 0);
}

int _millisecondsFromCMTime(CMTime time) {
  // When CMTIME_IS_INDEFINITE return a value that matches TIME_UNSET from
  // ExoPlayer2 on Android.
  // Fixes https://github.com/flutter/flutter/issues/48670
  const int timeUnset = -9223372036854775807;
  if (_cmTimeIsIndefinite(time)) {
    return timeUnset;
  }
  if (time.timescale == 0) {
    return 0;
  }
  return (time.value * 1000 / time.timescale).truncate();
}

// https://github.com/dart-lang/native/issues/1478
final ffi.Pointer<ObjCSelector> _selCMTimeRangeValue =
    registerName('CMTimeRangeValue');
// ignore: always_specify_types
final _objcMsgSendCMTimeRangeValue = msgSendPointer
    .cast<
        ffi.NativeFunction<
            CMTimeRange Function(
                ffi.Pointer<ObjCObject>, ffi.Pointer<ObjCSelector>)>>()
    .asFunction<
        CMTimeRange Function(
            ffi.Pointer<ObjCObject>, ffi.Pointer<ObjCSelector>)>();

extension _NSValueAVFoundationExtensions on NSValue {
  // ignore: non_constant_identifier_names
  CMTimeRange get CMTimeRangeValue {
    return _objcMsgSendCMTimeRangeValue(pointer, _selCMTimeRangeValue);
  }
}

// https://github.com/dart-lang/native/issues/1487
final ffi.Pointer<ObjCSelector> _selStatusOfValueForKeyError =
    registerName('statusOfValueForKey:error:');
// ignore: always_specify_types
final _objcMsgSendStatusOfValueForKeyError = msgSendPointer
    .cast<
        ffi.NativeFunction<
            ffi.UnsignedLong Function(
                ffi.Pointer<ObjCObject>,
                ffi.Pointer<ObjCSelector>,
                ffi.Pointer<ObjCObject>,
                ffi.Pointer<ffi.Pointer<ObjCObject>>)>>()
    .asFunction<
        int Function(ffi.Pointer<ObjCObject>, ffi.Pointer<ObjCSelector>,
            ffi.Pointer<ObjCObject>, ffi.Pointer<ffi.Pointer<ObjCObject>>)>();
final ffi.Pointer<ObjCSelector>
    _selLoadValuesAsynchronouslyForKeysCompletionHandler =
    registerName('loadValuesAsynchronouslyForKeys:completionHandler:');
// ignore: always_specify_types
final _objcMsgSendLoadValuesAsynchronouslyForKeysCompletionHandler =
    msgSendPointer
        .cast<
            ffi.NativeFunction<
                ffi.Void Function(
                    ffi.Pointer<ObjCObject>,
                    ffi.Pointer<ObjCSelector>,
                    ffi.Pointer<ObjCObject>,
                    ffi.Pointer<ObjCBlockImpl>)>>()
        .asFunction<
            void Function(ffi.Pointer<ObjCObject>, ffi.Pointer<ObjCSelector>,
                ffi.Pointer<ObjCObject>, ffi.Pointer<ObjCBlockImpl>)>();

extension _AVAsynchronousKeyValueLoading on AVAsset {
  // ignore: non_constant_identifier_names
  AVKeyValueStatus statusOfValueForKey_error_(
      NSString key, ffi.Pointer<ffi.Pointer<ObjCObject>> outError) {
    // ignore: always_specify_types
    final ret = _objcMsgSendStatusOfValueForKeyError(
        pointer, _selStatusOfValueForKeyError, key.pointer, outError);
    return AVKeyValueStatus.fromValue(ret);
  }

  // ignore: non_constant_identifier_names
  void loadValuesAsynchronouslyForKeys_completionHandler_(
      NSArray keys, ObjCBlock<ffi.Void Function()>? handler) {
    _objcMsgSendLoadValuesAsynchronouslyForKeysCompletionHandler(
        pointer,
        _selLoadValuesAsynchronouslyForKeysCompletionHandler,
        keys.pointer,
        handler?.pointer ?? ffi.nullptr);
  }
}
