// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

#import "FVPDisplayLink.h"
#import "FVPFrameUpdater.h"

/// The native component of a single video player instance.
@interface FVPVideoPlayer : NSObject

// The output to use for items being played.
@property(nonatomic, strong, nonnull) AVPlayerItemVideoOutput *videoOutput;

@property(nonatomic, readonly) BOOL disposed;

// Called when a new frame is provided to the engine.
@property(nonatomic, copy, nonnull) void (^onFrameProvided)(void);

// A callback to call during 'dispose'.
@property(nonatomic, copy, nullable) void (^onDisposed)(void);

- (instancetype)initWithPlayer:(nonnull AVPlayer *)player
                          item:(nonnull AVPlayerItem *)item
                        output:(AVPlayerItemVideoOutput *)videoOutput
                  viewProvider:(nonnull id<FVPViewProvider>)viewProvider
                  frameUpdater:(nonnull FVPFrameUpdater *)frameUpdater
                 frameCallback:(void (^__nonnull)(void))frameCallback;

/// Informs the player that it won't be used from Dart any more and that it should clean up
/// related resources.
- (void)dispose;

@end
