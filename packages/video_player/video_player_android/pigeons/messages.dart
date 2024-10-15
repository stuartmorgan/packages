// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.g.dart',
  dartTestOut: 'test/test_api.g.dart',
  javaOut: 'android/src/main/java/io/flutter/plugins/videoplayer/Messages.java',
  javaOptions: JavaOptions(
    package: 'io.flutter.plugins.videoplayer',
  ),
  copyrightHeader: 'pigeons/copyright.txt',
))
@HostApi(dartHostTestHandler: 'TestHostVideoPlayerApi')
abstract class AndroidVideoPlayerApi {
  void initialize(String key);
  int create(String uri, Map<String, String> httpHeaders, String? formatHint,
      String transferKey);
  void setMixWithOthers(bool mixWithOthers);
}
