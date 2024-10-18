// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jni/jni.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

import 'ffi_bindings.dart' hide BinaryMessenger, EventChannel;
import 'ffi_bindings.dart' as jnigen show BinaryMessenger, EventChannel;
import 'messages.g.dart';

/// An Android implementation of [VideoPlayerPlatform] that uses the
/// Pigeon-generated [VideoPlayerApi].
class AndroidVideoPlayer extends VideoPlayerPlatform {
  final AndroidVideoPlayerApi _api = AndroidVideoPlayerApi();

  final Completer<void> _initialized = Completer<void>();
  late final FlutterState_Wrapper _pluginState;
  final Map<int, _PlayerInstance> _playersByTextureId =
      <int, _PlayerInstance>{};
  bool _mixWithOthers = false;

  /// Registers this class as the default instance of [PathProviderPlatform].
  static void registerWith() {
    VideoPlayerPlatform.instance = AndroidVideoPlayer();
  }

  void _onAttachedToEngine(FlutterPlugin_FlutterPluginBinding binding) {
    // TODO(stuartmorgan): Remove this; presumably it will never be called.
    debugPrint('stuartmorgan: _onAttachedToEngine');
  }

  void _onDetachedFromEngine(FlutterPlugin_FlutterPluginBinding binding) {
    debugPrint('stuartmorgan: _onDetachedFromEngine');
    _disposeAllPlayers();
  }

  // TODO(stuartmorgan): Unwind all of this after ensuring player disposal;
  // it doesn't look like any of this is ever called. Need to make sure
  // surfaceProducer.release is actually being called somewhere though.
  void _disposeAllPlayers() {
    for (final _PlayerInstance player in _playersByTextureId.values) {
      debugPrint('stuartmorgan: Actually disposing something');
      player.dispose();
    }
    _playersByTextureId.clear();
  }

  @override
  Future<void> init() async {
    // TODO(stuartmorgan): Test hot reload/restart to see if this is needed now
    // that ownership is on the Dart side. We may need to keep tracking of all
    // the surfaces on the native side just so we have a hook point to
    // unregister them for hot reload.
    _disposeAllPlayers();
    // This is in theory racy, but fine for a temporary workaround in the
    // prototype.
    final String transferId = '${DateTime.now().microsecondsSinceEpoch}';
    await _api.initialize(transferId);
    _pluginState = VideoPlayerGlobalTransfer.getInstance()
        .state
        .remove(JString.fromString(transferId))!;
    _pluginState.state.engineListener = FlutterEngineListener.implement(
        $FlutterEngineListener(
            onAttachedToEngine: _onAttachedToEngine,
            onDetachedFromEngine: _onDetachedFromEngine));
    _initialized.complete();
  }

  @override
  Future<void> dispose(int textureId) => _playerFor(textureId).dispose();

  @override
  Future<int?> create(DataSource dataSource) async {
    await _initialized.future;

    final _PlayerInstance player = _PlayerInstance(
        dataSource,
        _pluginState.state.textureRegistry,
        _pluginState.state.binaryMessenger,
        _pluginState.state.applicationContext,
        mixWithOthers: _mixWithOthers,
        assetLookup: (String asset, String? package) => (package == null
                ? _pluginState.state.keyForAsset.get(JString.fromString(asset))
                : _pluginState.state.keyForAssetAndPackageName.get(
                    JString.fromString(asset), JString.fromString(package)))
            .toDartString());
    _playersByTextureId[player.textureId] = player;
    return player.textureId;
  }

  @override
  Future<void> setLooping(int textureId, bool looping) {
    return _playerFor(textureId).setLooping(looping);
  }

  @override
  Future<void> play(int textureId) async {
    return _playerFor(textureId).play();
  }

  @override
  Future<void> pause(int textureId) async {
    return _playerFor(textureId).pause();
  }

  @override
  Future<void> setVolume(int textureId, double volume) async {
    return _playerFor(textureId).setVolume(volume);
  }

  @override
  Future<void> setPlaybackSpeed(int textureId, double speed) async {
    return _playerFor(textureId).setPlaybackSpeed(speed);
  }

  @override
  Future<void> seekTo(int textureId, Duration position) async {
    return _playerFor(textureId).seekTo(position);
  }

  @override
  Future<Duration> getPosition(int textureId) async {
    return _playerFor(textureId).getPosition();
  }

  @override
  Stream<VideoEvent> videoEventsFor(int textureId) {
    return _playerFor(textureId).videoEvents();
  }

  @override
  Widget buildView(int textureId) {
    return Texture(textureId: textureId);
  }

  @override
  Future<void> setMixWithOthers(bool mixWithOthers) async {
    _mixWithOthers = mixWithOthers;
  }

  _PlayerInstance _playerFor(int textureId) {
    return _playersByTextureId[textureId]!;
  }
}

/// A single player instance, corresponding to a single texture ID in the main
/// plugin class.
class _PlayerInstance {
  _PlayerInstance(
    DataSource dataSource,
    TextureRegistry textureRegistry,
    jnigen.BinaryMessenger binaryMessenger,
    Context applicationContext, {
    required bool mixWithOthers,
    required String Function(String asset, String? package) assetLookup,
  }) {
    final VideoAsset videoAsset;
    switch (dataSource.sourceType) {
      case DataSourceType.asset:
        final String? asset = dataSource.asset;
        if (asset == null) {
          throw ArgumentError('asset must not be null for asset data source');
        }
        final String assetKey = assetLookup(asset, dataSource.package);
        videoAsset =
            VideoAsset.fromAssetUrl(JString.fromString('asset:///$assetKey'));
      case DataSourceType.network:
      case DataSourceType.file:
      case DataSourceType.contentUri:
        final String? uri = dataSource.uri;
        if (uri == null) {
          throw ArgumentError(
              'uri must not be null for data source ${dataSource.sourceType.name}');
        }
        if (uri.startsWith('rtsp://')) {
          videoAsset = VideoAsset.fromRtspUrl(JString.fromString(uri));
        } else {
          final VideoAsset_StreamingFormat streamingFormat =
              _streamingFormatForVideoFormat(dataSource.formatHint);
          videoAsset = VideoAsset.fromRemoteUrl(JString.fromString(uri),
              streamingFormat, _convertStringMap(dataSource.httpHeaders));
        }
    }

    final TextureRegistry_SurfaceProducer handle =
        textureRegistry.createSurfaceProducer();
    // Cast is workaround for https://github.com/dart-lang/native/issues/1653.
    textureId = handle.as(TextureRegistry_TextureEntry.type).id();

    final String channelName = 'flutter.io/videoPlayer/videoEvents$textureId';
    final jnigen.EventChannel nativeEventChannel =
        jnigen.EventChannel(binaryMessenger, JString.fromString(channelName));

    _nativePlayer = VideoPlayer.create(
        applicationContext,
        VideoPlayerEventCallbacks.bindTo(nativeEventChannel),
        handle,
        VideoPlayer_SurfaceProducerDelegate.implement(
            $VideoPlayer_SurfaceProducerDelegate(
          onSurfaceAvailable: _onSurfaceAvailable,
          onSurfaceDestroyed: _onSurfaceDestroyed,
        )),
        videoAsset,
        mixWithOthers);

    eventChannel = EventChannel(channelName);
    _eventSubscription = eventChannel
        .receiveBroadcastStream()
        .listen(_onStreamEvent, onError: (Object e) {
      _eventStreamController.addError(e);
    });
  }

  late final int textureId;
  late final VideoPlayer _nativePlayer;
  late final EventChannel eventChannel;
  final StreamController<VideoEvent> _eventStreamController =
      StreamController<VideoEvent>.broadcast();
  late final StreamSubscription<dynamic> _eventSubscription;

  ExoPlayer get _exoplayer => _nativePlayer.exoPlayer;

  // Workaround for https://github.com/dart-lang/native/issues/1653
  Player get _player => _exoplayer.as(Player.type);

  Future<void> setLooping(bool looping) async {
    _player.setRepeatMode(
        looping ? Player.REPEAT_MODE_ALL : Player.REPEAT_MODE_OFF);
  }

  Future<void> play() async {
    _player.play();
  }

  Future<void> pause() async {
    _player.pause();
  }

  Future<void> setVolume(double volume) async {
    final double limited = math.max(0, math.min(1, volume));
    _player.setVolume(limited);
  }

  Future<void> setPlaybackSpeed(double speed) async {
    assert(speed > 0);

    // Pitch and skipSilence are not currently exposed via the plugin's API, so
    // always just use the default values.
    final PlaybackParameters playbackParameters = PlaybackParameters(speed);
    _player.setPlaybackParameters(playbackParameters);
  }

  Future<void> seekTo(Duration position) async {
    _player.seekTo(position.inMilliseconds);
  }

  Future<Duration> getPosition() async {
    final int position = _player.getCurrentPosition();
    // TODO(stuartmorgan): Find a better place to trigger this; this is a hack
    // that relies on the fact that `getPosition` is polled to drive buffering
    // updates as a side-effect. If nothing else, this could be its own timer.
    final int bufferPosition = _player.getBufferedPosition();
    unawaited(() async {
      _synthesizeBufferUpdate(bufferPosition);
    }());
    return Duration(milliseconds: position);
  }

  Stream<VideoEvent> videoEvents() {
    return _eventStreamController.stream;
  }

  Future<void> dispose() async {
    await _eventSubscription.cancel();
    _nativePlayer.dispose();
  }

  void _onSurfaceAvailable() {
    debugPrint('stuartmorgan - Got onSurfaceAvailable');
  }

  void _onSurfaceDestroyed() {
    debugPrint('stuartmorgan - Got onSurfaceDestroyed');
  }

  void _onStreamEvent(dynamic event) {
    final Map<dynamic, dynamic> map = event as Map<dynamic, dynamic>;
    switch (map['event']) {
      case 'initialized':
        _eventStreamController.add(VideoEvent(
          eventType: VideoEventType.initialized,
          duration: Duration(milliseconds: map['duration'] as int),
          size: Size((map['width'] as num?)?.toDouble() ?? 0.0,
              (map['height'] as num?)?.toDouble() ?? 0.0),
          rotationCorrection: map['rotationCorrection'] as int? ?? 0,
        ));
      case 'completed':
        _eventStreamController.add(VideoEvent(
          eventType: VideoEventType.completed,
        ));
      case 'bufferingUpdate':
        final List<Object> values = map['values'] as List<Object>;

        _eventStreamController.add(VideoEvent(
          buffered: values.map<DurationRange>(_toDurationRange).toList(),
          eventType: VideoEventType.bufferingUpdate,
        ));
      case 'bufferingStart':
        _eventStreamController
            .add(VideoEvent(eventType: VideoEventType.bufferingStart));
      case 'bufferingEnd':
        _eventStreamController
            .add(VideoEvent(eventType: VideoEventType.bufferingEnd));
      case 'isPlayingStateUpdate':
        _eventStreamController.add(VideoEvent(
          eventType: VideoEventType.isPlayingStateUpdate,
          isPlaying: map['isPlaying'] as bool,
        ));
      default:
        _eventStreamController
            .add(VideoEvent(eventType: VideoEventType.unknown));
    }
  }

  void _synthesizeBufferUpdate(int bufferPosition) {
    _eventStreamController.add(VideoEvent(
      buffered: <DurationRange>[
        DurationRange(
          Duration.zero,
          Duration(milliseconds: bufferPosition),
        )
      ],
      eventType: VideoEventType.bufferingUpdate,
    ));
  }
}

JMap<JString, JString> _convertStringMap(Map<String, String> map) {
  return map
      .map((String key, String value) => MapEntry<JString, JString>(
          JString.fromString(key), JString.fromString(value)))
      .toJMap(JString.type, JString.type);
}

DurationRange _toDurationRange(Object value) {
  final List<Object> pair = value as List<Object>;
  return DurationRange(
    Duration(milliseconds: pair[0] as int),
    Duration(milliseconds: pair[1] as int),
  );
}

VideoAsset_StreamingFormat _streamingFormatForVideoFormat(VideoFormat? format) {
  return switch (format) {
    VideoFormat.dash => VideoAsset_StreamingFormat.DYNAMIC_ADAPTIVE,
    VideoFormat.hls => VideoAsset_StreamingFormat.HTTP_LIVE,
    VideoFormat.ss => VideoAsset_StreamingFormat.SMOOTH,
    VideoFormat.other => VideoAsset_StreamingFormat.UNKNOWN,
    null => VideoAsset_StreamingFormat.UNKNOWN,
  };
  // The enum comes from a different package, which could get a new value at
  // any time, so provide a fallback that ensures this won't break when used
  // with a version that contains new values. This is deliberately outside
  // the switch rather than a `default` so that the linter will flag the
  // switch as needing an update.
  // ignore: dead_code
  return VideoAsset_StreamingFormat.UNKNOWN;
}
