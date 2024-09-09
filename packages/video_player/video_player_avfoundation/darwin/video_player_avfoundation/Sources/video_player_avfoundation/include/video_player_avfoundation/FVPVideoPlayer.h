// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

#import "FVPDisplayLink.h"
#import "FVPFrameUpdater.h"
#import "InjectionProtocols.h"

/// The native component of a single video player instance.
@interface FVPVideoPlayer : NSObject

// The output to use for items being played.
@property(nonatomic, strong, nullable) AVPlayerItemVideoOutput *videoOutput;

@property(nonatomic, strong, nonnull) AVPlayer *player;

@property(nonatomic, readonly) BOOL disposed;

// Called when a new frame is provided to the engine.
@property(nonatomic, copy, nonnull) void (^onFrameProvided)(void);

// A callback to call during 'dispose'.
@property(nonatomic, copy, nullable) void (^onDisposed)(void);

- (instancetype)initWithPlayerItem:(nullable AVPlayerItem *)item
                      viewProvider:(nullable id<FVPViewProvider>)viewProvider
                      frameUpdater:(nonnull FVPFrameUpdater *)frameUpdater
                         AVFactory:(nullable id<FVPAVFactory>)avFactory
                     frameCallback:(void (^__nonnull)(void))frameCallback;

/// Informs the player that it won't be used from Dart any more and that it should clean up
/// related resources.
- (void)dispose;

@end
