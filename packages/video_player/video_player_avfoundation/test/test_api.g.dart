// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v18.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, unnecessary_import, no_leading_underscores_for_local_identifiers
// ignore_for_file: avoid_relative_lib_imports
import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;
import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:video_player_avfoundation/src/messages.g.dart';

abstract class TestHostVideoPlayerApi {
  static TestDefaultBinaryMessengerBinding? get _testBinaryMessengerBinding =>
      TestDefaultBinaryMessengerBinding.instance;
  static const MessageCodec<Object?> pigeonChannelCodec =
      StandardMessageCodec();

  /// Returns the raw pointer to the plugin API proxy.
  ///
  /// The implementation is responsible for ensuring that this pointer remains
  /// valid for the lifetime of the plugin.
  int getPluginApiProxyPointer();

  /// Configures the given player for display, and returns its texture ID.
  int configurePlayerPointer(int playerPointer);

  static void setUp(
    TestHostVideoPlayerApi? api, {
    BinaryMessenger? binaryMessenger,
    String messageChannelSuffix = '',
  }) {
    messageChannelSuffix =
        messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
    {
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.getPluginApiProxyPointer$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(__pigeon_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(__pigeon_channel,
                (Object? message) async {
          try {
            final int output = api.getPluginApiProxyPointer();
            return <Object?>[output];
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.configurePlayerPointer$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(__pigeon_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(__pigeon_channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.configurePlayerPointer was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_playerPointer = (args[0] as int?);
          assert(arg_playerPointer != null,
              'Argument for dev.flutter.pigeon.video_player_avfoundation.AVFoundationVideoPlayerApi.configurePlayerPointer was null, expected non-null int.');
          try {
            final int output = api.configurePlayerPointer(arg_playerPointer!);
            return <Object?>[output];
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
  }
}
