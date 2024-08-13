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

@interface FVPCreationOptions ()
+ (FVPCreationOptions *)fromList:(NSArray *)list;
+ (nullable FVPCreationOptions *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@interface FVPVideoPlayerNativeDetails ()
+ (FVPVideoPlayerNativeDetails *)fromList:(NSArray *)list;
+ (nullable FVPVideoPlayerNativeDetails *)nullableFromList:(NSArray *)list;
- (NSArray *)toList;
@end

@implementation FVPCreationOptions
+ (instancetype)makeWithAsset:(nullable NSString *)asset
                          uri:(nullable NSString *)uri
                  packageName:(nullable NSString *)packageName
                  httpHeaders:(NSDictionary<NSString *, NSString *> *)httpHeaders {
  FVPCreationOptions *pigeonResult = [[FVPCreationOptions alloc] init];
  pigeonResult.asset = asset;
  pigeonResult.uri = uri;
  pigeonResult.packageName = packageName;
  pigeonResult.httpHeaders = httpHeaders;
  return pigeonResult;
}
+ (FVPCreationOptions *)fromList:(NSArray *)list {
  FVPCreationOptions *pigeonResult = [[FVPCreationOptions alloc] init];
  pigeonResult.asset = GetNullableObjectAtIndex(list, 0);
  pigeonResult.uri = GetNullableObjectAtIndex(list, 1);
  pigeonResult.packageName = GetNullableObjectAtIndex(list, 2);
  pigeonResult.httpHeaders = GetNullableObjectAtIndex(list, 3);
  return pigeonResult;
}
+ (nullable FVPCreationOptions *)nullableFromList:(NSArray *)list {
  return (list) ? [FVPCreationOptions fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    self.asset ?: [NSNull null],
    self.uri ?: [NSNull null],
    self.packageName ?: [NSNull null],
    self.httpHeaders ?: [NSNull null],
  ];
}
@end

@implementation FVPVideoPlayerNativeDetails
+ (instancetype)makeWithTextureId:(NSInteger)textureId
              nativePlayerPointer:(NSInteger)nativePlayerPointer {
  FVPVideoPlayerNativeDetails *pigeonResult = [[FVPVideoPlayerNativeDetails alloc] init];
  pigeonResult.textureId = textureId;
  pigeonResult.nativePlayerPointer = nativePlayerPointer;
  return pigeonResult;
}
+ (FVPVideoPlayerNativeDetails *)fromList:(NSArray *)list {
  FVPVideoPlayerNativeDetails *pigeonResult = [[FVPVideoPlayerNativeDetails alloc] init];
  pigeonResult.textureId = [GetNullableObjectAtIndex(list, 0) integerValue];
  pigeonResult.nativePlayerPointer = [GetNullableObjectAtIndex(list, 1) integerValue];
  return pigeonResult;
}
+ (nullable FVPVideoPlayerNativeDetails *)nullableFromList:(NSArray *)list {
  return (list) ? [FVPVideoPlayerNativeDetails fromList:list] : nil;
}
- (NSArray *)toList {
  return @[
    @(self.textureId),
    @(self.nativePlayerPointer),
  ];
}
@end

@interface FVPAVFoundationVideoPlayerApiCodecReader : FlutterStandardReader
@end
@implementation FVPAVFoundationVideoPlayerApiCodecReader
- (nullable id)readValueOfType:(UInt8)type {
  switch (type) {
    case 128:
      return [FVPCreationOptions fromList:[self readValue]];
    case 129:
      return [FVPVideoPlayerNativeDetails fromList:[self readValue]];
    default:
      return [super readValueOfType:type];
  }
}
@end

@interface FVPAVFoundationVideoPlayerApiCodecWriter : FlutterStandardWriter
@end
@implementation FVPAVFoundationVideoPlayerApiCodecWriter
- (void)writeValue:(id)value {
  if ([value isKindOfClass:[FVPCreationOptions class]]) {
    [self writeByte:128];
    [self writeValue:[value toList]];
  } else if ([value isKindOfClass:[FVPVideoPlayerNativeDetails class]]) {
    [self writeByte:129];
    [self writeValue:[value toList]];
  } else {
    [super writeValue:value];
  }
}
@end

@interface FVPAVFoundationVideoPlayerApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation FVPAVFoundationVideoPlayerApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[FVPAVFoundationVideoPlayerApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[FVPAVFoundationVideoPlayerApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *FVPAVFoundationVideoPlayerApiGetCodec(void) {
  static FlutterStandardMessageCodec *sSharedObject = nil;
  static dispatch_once_t sPred = 0;
  dispatch_once(&sPred, ^{
    FVPAVFoundationVideoPlayerApiCodecReaderWriter *readerWriter =
        [[FVPAVFoundationVideoPlayerApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
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
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:[NSString stringWithFormat:@"%@%@",
                                                   @"dev.flutter.pigeon.video_player_avfoundation."
                                                   @"AVFoundationVideoPlayerApi.create",
                                                   messageChannelSuffix]
        binaryMessenger:binaryMessenger
                  codec:FVPAVFoundationVideoPlayerApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(createWithOptions:error:)],
                @"FVPAVFoundationVideoPlayerApi api (%@) doesn't respond to "
                @"@selector(createWithOptions:error:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        FVPCreationOptions *arg_creationOptions = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        FVPVideoPlayerNativeDetails *output = [api createWithOptions:arg_creationOptions
                                                               error:&error];
        callback(wrapResult(output, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel = [[FlutterBasicMessageChannel alloc]
           initWithName:[NSString stringWithFormat:@"%@%@",
                                                   @"dev.flutter.pigeon.video_player_avfoundation."
                                                   @"AVFoundationVideoPlayerApi.dispose",
                                                   messageChannelSuffix]
        binaryMessenger:binaryMessenger
                  codec:FVPAVFoundationVideoPlayerApiGetCodec()];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(disposePlayer:error:)],
                @"FVPAVFoundationVideoPlayerApi api (%@) doesn't respond to "
                @"@selector(disposePlayer:error:)",
                api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSInteger arg_textureId = [GetNullableObjectAtIndex(args, 0) integerValue];
        FlutterError *error;
        [api disposePlayer:arg_textureId error:&error];
        callback(wrapResult(nil, error));
      }];
    } else {
      [channel setMessageHandler:nil];
    }
  }
}
