// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "FVPVideoPlayerPlugin.h"
#import "FVPVideoPlayerPlugin_Test.h"

#import <AVFoundation/AVFoundation.h>

#import "./include/video_player_avfoundation/AVAssetTrackUtils.h"
#import "./include/video_player_avfoundation/FVPDisplayLink.h"
#import "./include/video_player_avfoundation/FVPEventChannelVideoPlayerDelegate.h"
#import "./include/video_player_avfoundation/FVPVideoPlayer.h"
#import "./include/video_player_avfoundation/FVPViewProvider.h"
#import "./include/video_player_avfoundation/InjectionProtocols.h"
#import "./include/video_player_avfoundation/messages.g.h"
#import "FVPFrameUpdater.h"
#import "FVPVideoPlayer_Private.h"

#if !__has_feature(objc_arc)
#error Code Requires ARC.
#endif

/// Non-test implementation of the view provider.
@interface FVPDefaultViewProvider : NSObject <FVPViewProvider>
// The registrar to query view information from.
@property(readonly, nonatomic) NSObject<FlutterPluginRegistrar> *registrar;
- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;
@end

@implementation FVPDefaultViewProvider
- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  self = [super init];
  if (self) {
    _registrar = registrar;
  }
  return self;
}

#if TARGET_OS_OSX
- (NSView *)view {
  return registrar.view.layer;
}
#else
- (UIView *)view {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  // TODO(hellohuanlin): Provide a non-deprecated codepath. See
  // https://github.com/flutter/flutter/issues/104117
  UIViewController *root = UIApplication.sharedApplication.keyWindow.rootViewController;
#pragma clang diagnostic pop
  return root.view;
}
#endif
@end

#pragma mark -

@interface FVPVideoPlayerPlugin ()
@property(readonly, strong, nonatomic) NSObject<FlutterPluginRegistrar> *registrar;
@property(nonatomic) NSObject<FVPViewProvider> *viewProvider;
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
  _viewProvider = [[FVPDefaultViewProvider alloc] initWithRegistrar:_registrar];
  _players =
      [NSMapTable mapTableWithKeyOptions:(NSMapTableWeakMemory | NSMapTableObjectPointerPersonality)
                            valueOptions:NSMapTableStrongMemory];
  return self;
}

- (void)detachFromEngineForRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  for (FVPVideoPlayer *player in self.players.keyEnumerator) {
    // Remove the delegate to ensure that the player doesn't message the engine that is no longer
    // connected.
    player.delegate = nil;
    // Similarly, don't try to unregister the texture during a later dispose.
    player.onDisposed = nil;
  }
  [self.players removeAllObjects];
  SetUpFVPAVFoundationVideoPlayerApi(registrar.messenger, nil);
}

- (nullable NSNumber *)viewProviderPointer:(FlutterError *_Nullable *_Nonnull)error {
  return @((NSInteger)(__bridge void *)self.viewProvider);
}

- (nullable NSNumber *)configurePlayerPointer:(NSInteger)playerPointer
                                        error:(FlutterError *_Nullable *_Nonnull)error {
  FVPVideoPlayer *player = (__bridge FVPVideoPlayer *)((void *)playerPointer);
  __weak NSObject<FlutterPluginRegistrar> *weakRegistrar = self.registrar;
  int64_t textureIdentifier = [[self.registrar textures] registerTexture:player];
  player.onDisposed = ^{
    [[weakRegistrar textures] unregisterTexture:textureIdentifier];
  };
  // The value is ignored, NSMapTable is just easier to use than NSPointerArray.
  [self.players setObject:@(YES) forKey:player];
  player.delegate =
      [[FVPEventChannelVideoPlayerDelegate alloc] initWithRegistrar:self.registrar
                                                   playerIdentifier:textureIdentifier];
  [player configureDisplayWithAvailableFrameCallback:^{
    [[weakRegistrar textures] textureFrameAvailable:textureIdentifier];
  }];

  return @(textureIdentifier);
}

- (void)disposePlayerPointer:(NSInteger)playerPointer error:(FlutterError **)error {
  FVPVideoPlayer *player = (__bridge FVPVideoPlayer *)((void *)playerPointer);
  [self.players removeObjectForKey:player];
  [player dispose];
}

- (nullable NSString *)pathForAssetWithName:(NSString *)assetName
                                    package:(nullable NSString *)packageName
                                      error:(FlutterError *_Nullable *_Nonnull)error {
  NSString *lookupKey = packageName
                            ? [_registrar lookupKeyForAsset:assetName fromPackage:packageName]
                            : [_registrar lookupKeyForAsset:assetName];
  NSString *path = [[NSBundle mainBundle] pathForResource:lookupKey ofType:nil];
#if TARGET_OS_OSX
  // See https://github.com/flutter/flutter/issues/135302
  // TODO(stuartmorgan): Remove this if the asset APIs are adjusted to work better for macOS.
  if (!path) {
    path = [NSURL URLWithString:lookupKey relativeToURL:NSBundle.mainBundle.bundleURL].path;
  }
#endif
  return path;
}

@end
