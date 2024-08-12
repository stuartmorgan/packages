// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v18.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#import <Foundation/Foundation.h>

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

@class FVPCreationOptions;
@class FVPVideoPlayerNativeDetails;

@interface FVPCreationOptions : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithAsset:(nullable NSString *)asset
                          uri:(nullable NSString *)uri
                  packageName:(nullable NSString *)packageName
                   formatHint:(nullable NSString *)formatHint
                  httpHeaders:(NSDictionary<NSString *, NSString *> *)httpHeaders;
@property(nonatomic, copy, nullable) NSString *asset;
@property(nonatomic, copy, nullable) NSString *uri;
@property(nonatomic, copy, nullable) NSString *packageName;
@property(nonatomic, copy, nullable) NSString *formatHint;
@property(nonatomic, copy) NSDictionary<NSString *, NSString *> *httpHeaders;
@end

/// The information needed by the Dart side of the implementation when a new
/// player instance is created.
@interface FVPVideoPlayerNativeDetails : NSObject
/// `init` unavailable to enforce nonnull fields, see the `make` class method.
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)makeWithTextureId:(NSInteger)textureId
              nativePlayerPointer:(NSInteger)nativePlayerPointer;
/// The ID for the texture that this player instance renders to.
@property(nonatomic, assign) NSInteger textureId;
/// The raw pointer to the native player object, for use with FFI. This is
/// guaranteed to be valid until AVFoundationVideoPlayerApi.dipose is called
/// with the corresponding texture ID, but should never be used after that
/// call.
@property(nonatomic, assign) NSInteger nativePlayerPointer;
@end

/// The codec used by FVPAVFoundationVideoPlayerApi.
NSObject<FlutterMessageCodec> *FVPAVFoundationVideoPlayerApiGetCodec(void);

@protocol FVPAVFoundationVideoPlayerApi
- (void)initialize:(FlutterError *_Nullable *_Nonnull)error;
/// @return `nil` only when `error != nil`.
- (nullable FVPVideoPlayerNativeDetails *)createWithOptions:(FVPCreationOptions *)creationOptions
                                                      error:
                                                          (FlutterError *_Nullable *_Nonnull)error;
- (void)disposePlayer:(NSInteger)textureId error:(FlutterError *_Nullable *_Nonnull)error;
- (void)setMixWithOthers:(BOOL)mixWithOthers error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void SetUpFVPAVFoundationVideoPlayerApi(
    id<FlutterBinaryMessenger> binaryMessenger,
    NSObject<FVPAVFoundationVideoPlayerApi> *_Nullable api);

extern void SetUpFVPAVFoundationVideoPlayerApiWithSuffix(
    id<FlutterBinaryMessenger> binaryMessenger,
    NSObject<FVPAVFoundationVideoPlayerApi> *_Nullable api, NSString *messageChannelSuffix);

NS_ASSUME_NONNULL_END
