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

// Called when a new frame is provided to the engine.
@property(nonatomic, copy, nonnull) void (^onFrameProvided)(void);

- (instancetype)initWithPlayer:(nonnull AVPlayer *)player
                        output:(AVPlayerItemVideoOutput *)videoOutput
                  frameUpdater:(nonnull FVPFrameUpdater *)frameUpdater
                 frameCallback:(void (^__nonnull)(void))frameCallback;

@end
