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
@HostApi(dartHostTestHandler: 'TestHostVideoPlayerApi')
abstract class AVFoundationVideoPlayerApi {
  @ObjCSelector('initialize')
  void initialize();

  /// Configures the given player for display, and returns its texture ID.
  @ObjCSelector('configurePlayerPointer:')
  int configurePlayerPointer(int playerPointer);

  /// Disposes of the given player.
  @ObjCSelector('disposePlayerPointer:')
  void disposePlayerPointer(int playerPointer);

  /// Wraps registrar-based asset lookup, as that's not currently accessible via
  /// FFI.
  @ObjCSelector('pathForAssetWithName:package:')
  String? pathForAsset(String assetName, String? packageName);
}
