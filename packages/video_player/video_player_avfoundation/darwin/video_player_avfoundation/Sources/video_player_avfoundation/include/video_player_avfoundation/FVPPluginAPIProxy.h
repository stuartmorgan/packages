// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#import "FVPViewProvider.h"

NS_ASSUME_NONNULL_BEGIN

/// Wrapper for functionality that comes from the Flutter plugin registrar and its vended objects,
/// to work around current limitations in accessing them directly from FFI.
// TODO(stuartmorgan): Make this a protocol instead once the issues around proxy typing and method
// calling in ffigen are fixed.
@interface FVPPluginAPIProxy : NSObject <FVPViewProvider>

/// The layer displaying the Flutter content.
@property(readonly, nonatomic, nullable) CALayer *layer;

- (void)textureFrameAvailable:(int64_t)textureIdentifier;

- (void)unregisterTexture:(int64_t)textureIdentifier;

- (NSString *)lookupKeyForAsset:(NSString *)asset;

- (NSString *)lookupKeyForAsset:(NSString *)asset fromPackage:(NSString *)package;

@end

NS_ASSUME_NONNULL_END
