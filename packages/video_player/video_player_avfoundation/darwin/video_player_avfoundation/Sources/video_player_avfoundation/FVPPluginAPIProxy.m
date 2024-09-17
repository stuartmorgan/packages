// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "./include/video_player_avfoundation/FVPPluginAPIProxy.h"
#import "./include/video_player_avfoundation/FVPPluginAPIProxy_Internal.h"

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

@implementation FVPPluginAPIProxy

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  self = [super init];
  if (self) {
    _registrar = registrar;
  }
  return self;
}

- (CALayer *)layer {
  return self.view.layer;
}

- (int64_t)registerTexture:(NSObject *)texture {
  NSAssert([texture conformsToProtocol:@protocol(FlutterTexture)],
           @"texture must implement FlutterTexture");
  return [[self.registrar textures] registerTexture:(id<FlutterTexture>)texture];
}

- (void)textureFrameAvailable:(int64_t)textureIdentifier {
  [[self.registrar textures] textureFrameAvailable:textureIdentifier];
}

- (void)unregisterTexture:(int64_t)textureIdentifier {
  [[self.registrar textures] unregisterTexture:textureIdentifier];
}

- (NSString *)lookupKeyForAsset:(NSString *)asset {
  return [self.registrar lookupKeyForAsset:asset];
}

- (NSString *)lookupKeyForAsset:(NSString *)asset fromPackage:(NSString *)package {
  return [self.registrar lookupKeyForAsset:asset fromPackage:package];
}

#pragma mark Private methods

#if TARGET_OS_OSX
- (NSView *)view {
  return self.registrar.view.layer;
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
