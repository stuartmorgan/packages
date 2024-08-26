// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v18.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import "messages.g.h"

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSArray *wrapResult(id result, FlutterError *error) {
  if (error) {
    return @[
      error.code ?: [NSNull null], error.message ?: [NSNull null], error.details ?: [NSNull null]
    ];
  }
  return @[ result ?: [NSNull null] ];
}

static id GetNullableObjectAtIndex(NSArray *array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}

NSObject<FlutterMessageCodec> *FVPAVFoundationVideoPlayerApiGetCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  sSharedObject = [FlutterStandardMessageCodec sharedInstance];
  return sSharedObject;
}

void SetUpFVPAVFoundationVideoPlayerApi(id<FlutterBinaryMessenger> binaryMessenger,
                                        NSObject<FVPAVFoundationVideoPlayerApi> *api) {
  SetUpFVPAVFoundationVideoPlayerApiWithSuffix(binaryMessenger, api, @"");
}

void SetUpFVPAVFoundationVideoPlayerApiWithSuffix(id<FlutterBinaryMessenger> binaryMessenger,
                                                  NSObject<FVPAVFoundationVideoPlayerApi> *api,
                                                  NSString *messageChannelSuffix) {
  messageChannelSuffix = messageChannelSuffix.length > 0
                             ? [NSString stringWithFormat:@".%@", messageChannelSuffix]
                             : @"";
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:[NSString stringWithFormat:@"%@%@",
                                                   @"dev.flutter.pigeon.video_player_avfoundation."
                                                   @"AVFoundationVideoPlayerApi.initialize",
                                                   messageChannelSuffix]
        binaryMessenger:binaryMessenger
                  codec:FVPAVFoundationVideoPlayerApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(initialize:)],
                @"FVPAVFoundationVideoPlayerApi api (%@) doesn't respond to @selector(initialize:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        FlutterError *error;
        [api initialize:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  /// Configures the given player for display, and returns its texture ID.
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:[NSString
                            stringWithFormat:@"%@%@",
                                             @"dev.flutter.pigeon.video_player_avfoundation."
                                             @"AVFoundationVideoPlayerApi.configurePlayerPointer",
                                             messageChannelSuffix]
        binaryMessenger:binaryMessenger
                  codec:FVPAVFoundationVideoPlayerApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(configurePlayerPointer:error:)],
                @"FVPAVFoundationVideoPlayerApi api (%@) doesn't respond to "
                @"@selector(configurePlayerPointer:error:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSInteger arg_playerPointer = [GetNullableObjectAtIndex(args, 0) integerValue];
        FlutterError *error;
        NSNumber *output = [api configurePlayerPointer:arg_playerPointer error:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  /// Disposes of the given player.
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:[NSString stringWithFormat:@"%@%@",
                                                   @"dev.flutter.pigeon.video_player_avfoundation."
                                                   @"AVFoundationVideoPlayerApi.dispose",
                                                   messageChannelSuffix]
        binaryMessenger:binaryMessenger
                  codec:FVPAVFoundationVideoPlayerApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(disposePlayerPointer:error:)],
                @"FVPAVFoundationVideoPlayerApi api (%@) doesn't respond to "
                @"@selector(disposePlayerPointer:error:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSInteger arg_playerPointer = [GetNullableObjectAtIndex(args, 0) integerValue];
        FlutterError *error;
        [api disposePlayerPointer:arg_playerPointer error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  /// Wraps registrar-based asset lookup, as that's not currently accessible via
  /// FFI.
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:[NSString stringWithFormat:@"%@%@",
                                                   @"dev.flutter.pigeon.video_player_avfoundation."
                                                   @"AVFoundationVideoPlayerApi.pathForAsset",
                                                   messageChannelSuffix]
        binaryMessenger:binaryMessenger
                  codec:FVPAVFoundationVideoPlayerApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(pathForAssetWithName:package:error:)],
                @"FVPAVFoundationVideoPlayerApi api (%@) doesn't respond to "
                @"@selector(pathForAssetWithName:package:error:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSString *arg_assetName = GetNullableObjectAtIndex(args, 0);
        NSString *arg_packageName = GetNullableObjectAtIndex(args, 1);
        FlutterError *error;
        NSString *output = [api pathForAssetWithName:arg_assetName
                                             package:arg_packageName
                                               error:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
