// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/method_channel_shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final SharedPreferencesStorePlatform initialImplementation =
      SharedPreferencesStorePlatform.instance;

  group(SharedPreferencesStorePlatform, () {
    test('defaults to method channel for backwards compatibility', () {
      expect(initialImplementation, isA<MethodChannelSharedPreferencesStore>());
    });
  });
}
