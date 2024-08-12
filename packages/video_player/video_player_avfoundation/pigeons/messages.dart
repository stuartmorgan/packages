// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.g.dart',
  dartTestOut: 'test/test_api.g.dart',
  objcHeaderOut:
      'darwin/video_player_avfoundation/Sources/video_player_avfoundation/include/video_player_avfoundation/messages.g.h',
  objcSourceOut:
      'darwin/video_player_avfoundation/Sources/video_player_avfoundation/messages.g.m',
  objcOptions: ObjcOptions(
    prefix: 'FVP',
    headerIncludePath: './include/video_player_avfoundation/messages.g.h',
  ),
  copyrightHeader: 'pigeons/copyright.txt',
))
class CreationOptions {
  CreationOptions({required this.httpHeaders});
  String? asset;
  String? uri;
  String? packageName;
  String? formatHint;
  Map<String?, String?> httpHeaders;
}

class MixWithOthersMessage {
  MixWithOthersMessage(this.mixWithOthers);
  bool mixWithOthers;
}

/// The information needed by the Dart side of the implementation when a new
/// player instance is created.
class VideoPlayerNativeDetails {
  VideoPlayerNativeDetails(
      {required this.textureId, required this.nativePlayerPointer});

  /// The ID for the texture that this player instance renders to.
  final int textureId;

  /// The raw pointer to the native player object, for use with FFI. This is
  /// guaranteed to be valid until AVFoundationVideoPlayerApi.dipose is called
  /// with the corresponding texture ID, but should never be used after that
  /// call.
  final int nativePlayerPointer;
}

@HostApi(dartHostTestHandler: 'TestHostVideoPlayerApi')
abstract class AVFoundationVideoPlayerApi {
  @ObjCSelector('initialize')
  void initialize();
  @ObjCSelector('createWithOptions:')
  // Creates a new player and returns its details.
  VideoPlayerNativeDetails create(CreationOptions creationOptions);
  @ObjCSelector('disposePlayer:')
  void dispose(int textureId);
  @ObjCSelector('setMixWithOthers:')
  void setMixWithOthers(bool mixWithOthers);
}
