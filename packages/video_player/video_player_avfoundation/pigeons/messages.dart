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
  /// Returns the raw pointer to the plugin API proxy.
  ///
  /// The implementation is responsible for ensuring that this pointer remains
  /// valid for the lifetime of the plugin.
  @ObjCSelector('pluginAPIProxyPointer')
  int getPluginApiProxyPointer();

  /// Configures the given player for display, and returns its texture ID.
  @ObjCSelector('configurePlayerPointer:')
  int configurePlayerPointer(int playerPointer);
}
