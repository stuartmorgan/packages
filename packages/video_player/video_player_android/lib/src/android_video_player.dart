// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jni/jni.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

import 'ffi_bindings.dart';
import 'messages.g.dart';

/// An Android implementation of [VideoPlayerPlatform] that uses the
/// Pigeon-generated [VideoPlayerApi].
class AndroidVideoPlayer extends VideoPlayerPlatform {
  final AndroidVideoPlayerApi _api = AndroidVideoPlayerApi();

  final Map<int, VideoPlayer> _playersByTextureId = <int, VideoPlayer>{};

  /// Registers this class as the default instance of [PathProviderPlatform].
  static void registerWith() {
    VideoPlayerPlatform.instance = AndroidVideoPlayer();
  }

  @override
  Future<void> init() {
    return _api.initialize();
  }

  @override
  Future<void> dispose(int textureId) async {
    await _eventSubscription?.cancel();
    // TODO(stuartmorgan): Figure out how to unwind disposeAllPlayers so dispose
    // doesn't have to be native.
    return _api.dispose(TextureMessage(textureId: textureId));
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
        httpHeaders = dataSource.httpHeaders;
      case DataSourceType.contentUri:
        uri = dataSource.uri;
    }
    final CreateMessage message = CreateMessage(
      asset: asset,
      packageName: packageName,
      uri: uri,
      httpHeaders: httpHeaders,
      formatHint: formatHint,
    );

    final TextureMessage response = await _api.create(message);
    await _transferPlayer(response.textureId);
    return response.textureId;
  }

  // Workaround to get a native-side-created object over to Dart.
  Future<void> _transferPlayer(int textureId) async {
    // This is in theory racy, but fine for a temporary workaround in the
    // prototype.
    final String transferId =
        '$textureId-${DateTime.now().microsecondsSinceEpoch}';
    await _api.cacheInstance(transferId, textureId);
    _playersByTextureId[textureId] = VideoPlayerGlobalTransfer.getInstance()
        .players
        .remove(JString.fromString(transferId))!;
  }

  @override
  Future<void> setLooping(int textureId, bool looping) async {
    _exoplayerAsPlayerFor(textureId).setRepeatMode(
        looping ? Player.REPEAT_MODE_ALL : Player.REPEAT_MODE_OFF);
  }

  @override
  Future<void> play(int textureId) async {
    _exoplayerAsPlayerFor(textureId).play();
  }

  @override
  Future<void> pause(int textureId) async {
    _exoplayerAsPlayerFor(textureId).pause();
  }

  @override
  Future<void> setVolume(int textureId, double volume) async {
    final double limited = math.max(0, math.min(1, volume));
    _exoplayerAsPlayerFor(textureId).setVolume(limited);
  }

  @override
  Future<void> setPlaybackSpeed(int textureId, double speed) async {
    assert(speed > 0);

    // Pitch and skipSilence are not currently exposed via the plugin's API, so
    // always just use the default values.
    final PlaybackParameters playbackParameters = PlaybackParameters(speed);
    _exoplayerAsPlayerFor(textureId).setPlaybackParameters(playbackParameters);
  }

  @override
  Future<void> seekTo(int textureId, Duration position) async {
    _exoplayerAsPlayerFor(textureId).seekTo(position.inMilliseconds);
  }

  @override
  Future<Duration> getPosition(int textureId) async {
    final Player player = _exoplayerAsPlayerFor(textureId);
    final int position = player.getCurrentPosition();
    // TODO(stuartmorgan): Find a better place to trigger this; this is a hack
    // that relies on the fact that `getPosition` is polled to drive buffering
    // updates as a side-effect. If nothing else, this could be its own timer.
    final int bufferPosition = player.getBufferedPosition();
    unawaited(() async {
      _synthesizeBufferUpdate(bufferPosition);
    }());
    return Duration(milliseconds: position);
  }

  final StreamController<VideoEvent> _eventStreamController =
      StreamController<VideoEvent>.broadcast();
  StreamSubscription<dynamic>? _eventSubscription;

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

  @override
  Stream<VideoEvent> videoEventsFor(int textureId) {
    _eventSubscription = _eventChannelFor(textureId)
        .receiveBroadcastStream()
        .listen((dynamic event) {
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
          final List<dynamic> values = map['values'] as List<dynamic>;

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
    }, onError: (Object e) {
      _eventStreamController.addError(e);
    });
    return _eventStreamController.stream;
  }

  @override
  Widget buildView(int textureId) {
    return Texture(textureId: textureId);
  }

  @override
  Future<void> setMixWithOthers(bool mixWithOthers) {
    return _api
        .setMixWithOthers(MixWithOthersMessage(mixWithOthers: mixWithOthers));
  }

  VideoPlayer _playerFor(int textureId) {
    return _playersByTextureId[textureId]!;
  }

  ExoPlayer _exoplayerFor(int textureId) {
    return _playersByTextureId[textureId]!.exoPlayer;
  }

  // Workaround for https://github.com/dart-lang/native/issues/1653
  Player _exoplayerAsPlayerFor(int textureId) {
    return _playersByTextureId[textureId]!.exoPlayer.as(Player.type);
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
