// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

@interface FVPFrameUpdater : NSObject
@property(nonatomic) int64_t textureId;
@property(nonatomic, weak, readonly) NSObject<FlutterTextureRegistry> *registry;
// The output that this updater is managing.
@property(nonatomic, weak) AVPlayerItemVideoOutput *videoOutput;
// The last time that has been validated as avaliable according to hasNewPixelBufferForItemTime:.
@property(nonatomic, assign) CMTime lastKnownAvailableTime;

/// Initializes an instance that can get state from the given registry.
// TODO(stuartmorgan): Abstract the registry behind a simple protocol.
- (instancetype)initWithRegistry:(NSObject<FlutterTextureRegistry> *)registry;

/// Informs this object that the display link timer fired, so the frame should be updated if
/// possible.
- (void)displayLinkFired;
@end
