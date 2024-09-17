// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "FVPVideoPlayerPlugin.h"
#import "FVPVideoPlayerPlugin_Test.h"

#import <AVFoundation/AVFoundation.h>

#import "./include/video_player_avfoundation/AVAssetTrackUtils.h"
#import "./include/video_player_avfoundation/FVPDisplayLink.h"
#import "./include/video_player_avfoundation/FVPFrameUpdater.h"
#import "./include/video_player_avfoundation/FVPPluginAPIProxy.h"
#import "./include/video_player_avfoundation/FVPPluginAPIProxy_Internal.h"
#import "./include/video_player_avfoundation/FVPVideoPlayer.h"
#import "./include/video_player_avfoundation/messages.g.h"
#import "FVPVideoPlayer_Private.h"

#if !__has_feature(objc_arc)
#error Code Requires ARC.
#endif

@interface FVPVideoPlayerPlugin ()
@property(readonly, strong, nonatomic) NSObject<FlutterPluginRegistrar> *registrar;
@property(nonatomic) FVPPluginAPIProxy *pluginProxy;
@end

@implementation FVPVideoPlayerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FVPVideoPlayerPlugin *instance = [[FVPVideoPlayerPlugin alloc] initWithRegistrar:registrar];
  [registrar publish:instance];
  SetUpFVPAVFoundationVideoPlayerApi(registrar.messenger, instance);
}

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  self = [super init];
  NSAssert(self, @"super init cannot be nil");
  _registrar = registrar;
  _pluginProxy = [[FVPPluginAPIProxy alloc] initWithRegistrar:_registrar];
  return self;
}

- (void)detachFromEngineForRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  SetUpFVPAVFoundationVideoPlayerApi(registrar.messenger, nil);
}

- (nullable NSNumber *)pluginAPIProxyPointer:(FlutterError *_Nullable *_Nonnull)error {
  return @((NSInteger)(__bridge void *)self.pluginProxy);
}

- (nullable NSNumber *)configurePlayerPointer:(NSInteger)playerPointer
                                        error:(FlutterError *_Nullable *_Nonnull)error {
  FVPVideoPlayer *player = (__bridge FVPVideoPlayer *)((void *)playerPointer);
  __weak NSObject<FlutterPluginRegistrar> *weakRegistrar = self.registrar;
  int64_t textureIdentifier = [[self.registrar textures] registerTexture:player];
  [player configureDisplayWithAvailableFrameCallback:^{
    [[weakRegistrar textures] textureFrameAvailable:textureIdentifier];
  }];

  return @(textureIdentifier);
}

@end
