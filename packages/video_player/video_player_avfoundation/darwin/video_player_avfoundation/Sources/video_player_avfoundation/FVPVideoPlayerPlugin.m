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
#import "./include/video_player_avfoundation/InjectionProtocols.h"
#import "./include/video_player_avfoundation/messages.g.h"
#import "FVPFrameUpdater.h"
#import "FVPVideoPlayer_Private.h"

#if !__has_feature(objc_arc)
#error Code Requires ARC.
#endif

@interface FVPDefaultAVFactory : NSObject <FVPAVFactory>
@end

@implementation FVPDefaultAVFactory
- (AVPlayer *)playerWithPlayerItem:(AVPlayerItem *)playerItem {
  return [AVPlayer playerWithPlayerItem:playerItem];
}
- (AVPlayerItemVideoOutput *)videoOutputWithPixelBufferAttributes:
    (NSDictionary<NSString *, id> *)attributes {
  return [[AVPlayerItemVideoOutput alloc] initWithPixelBufferAttributes:attributes];
}
@end

/// Non-test implementation of the diplay link factory.
@interface FVPDefaultDisplayLinkFactory : NSObject <FVPDisplayLinkFactory>
@end

@implementation FVPDefaultDisplayLinkFactory
- (FVPDisplayLink *)displayLinkWithViewProvider:(id<FVPViewProvider>)viewProvider
                                       callback:(void (^)(void))callback {
  return [[FVPDisplayLink alloc] initWithViewProvider:viewProvider callback:callback];
}

@end

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
@property(nonatomic, strong) id<FVPDisplayLinkFactory> displayLinkFactory;
@property(nonatomic, strong) id<FVPAVFactory> avFactory;
@end

@implementation FVPVideoPlayerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  FVPVideoPlayerPlugin *instance = [[FVPVideoPlayerPlugin alloc] initWithRegistrar:registrar];
  [registrar publish:instance];
  SetUpFVPAVFoundationVideoPlayerApi(registrar.messenger, instance);
}

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  return [self initWithAVFactory:[[FVPDefaultAVFactory alloc] init]
              displayLinkFactory:[[FVPDefaultDisplayLinkFactory alloc] init]
                       registrar:registrar];
}

- (instancetype)initWithAVFactory:(id<FVPAVFactory>)avFactory
               displayLinkFactory:(id<FVPDisplayLinkFactory>)displayLinkFactory
                        registrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  self = [super init];
  NSAssert(self, @"super init cannot be nil");
  _registrar = registrar;
  _displayLinkFactory = displayLinkFactory ?: [[FVPDefaultDisplayLinkFactory alloc] init];
  _avFactory = avFactory ?: [[FVPDefaultAVFactory alloc] init];
  _playersByTextureId = [NSMutableDictionary dictionaryWithCapacity:1];
  return self;
}

- (void)detachFromEngineForRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  for (FVPVideoPlayer *player in self.playersByTextureId.allValues) {
    // Remove the delegate to ensure that the player doesn't message the engine that is no longer
    // connected.
    player.delegate = nil;
    [player dispose];
  }
  [self.playersByTextureId removeAllObjects];
  SetUpFVPAVFoundationVideoPlayerApi(registrar.messenger, nil);
}

- (void)initialize:(FlutterError *__autoreleasing *)error {
#if TARGET_OS_IOS
  // Allow audio playback when the Ring/Silent switch is set to silent
  [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
#endif

  NSObject<FlutterTextureRegistry> *textureRegistry = [self.registrar textures];
  [self.playersByTextureId
      enumerateKeysAndObjectsUsingBlock:^(NSNumber *textureId, FVPVideoPlayer *player, BOOL *stop) {
        [textureRegistry unregisterTexture:textureId.unsignedIntegerValue];
        [player dispose];
      }];
  [self.playersByTextureId removeAllObjects];
}

- (nullable FVPVideoPlayerNativeDetails *)
    createWithURL:(NSString *)url
          headers:(NSDictionary<NSString *, NSString *> *)httpHeaders
            error:(FlutterError *_Nullable *_Nonnull)error {
  // Create a player item from the parameters.
  NSDictionary<NSString *, id> *options = nil;
  if (httpHeaders.count != 0) {
    options = @{@"AVURLAssetHTTPHeaderFieldsKey" : httpHeaders};
  }
  AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:url] options:options];
  AVPlayerItem *avItem = [AVPlayerItem playerItemWithAsset:urlAsset];

  FVPVideoPlayer *player = [[FVPVideoPlayer alloc]
      initWithPlayerItem:avItem
               avFactory:self.avFactory];
  int64_t textureIdentifier = [[self.registrar textures] registerTexture:player];
  self.playersByTextureId[@(textureIdentifier)] = player;
  __weak NSObject<FlutterPluginRegistrar> *weakRegistrar = self.registrar;
  player.delegate = [[FVPEventChannelVideoPlayerDelegate alloc] initWithRegistrar:self.registrar
                                                                 playerIdentifier:textureIdentifier];
  [player configureDisplayWithViewProvider:[[FVPDefaultViewProvider alloc] initWithRegistrar:self.registrar]
                        displayLinkFactory:self.displayLinkFactory
  availableFrameCallback:^{
    [[weakRegistrar textures] textureFrameAvailable:textureIdentifier];
  }];

  return [FVPVideoPlayerNativeDetails makeWithTextureId:textureIdentifier
                                    nativePlayerPointer:(intptr_t)player];
}

- (void)disposePlayer:(NSInteger)textureId error:(FlutterError **)error {
  NSNumber *playerKey = @(textureId);
  FVPVideoPlayer *player = self.playersByTextureId[playerKey];
  [[self.registrar textures] unregisterTexture:textureId];
  [self.playersByTextureId removeObjectForKey:playerKey];
  if (!player.disposed) {
    [player dispose];
  }
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
