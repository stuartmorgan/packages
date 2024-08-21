// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

#import "InjectionProtocols.h"

/// The native component of a single video player instance.
@interface FVPVideoPlayer : NSObject

@property(readonly, nonatomic) int64_t position;

@property(nonatomic) BOOL isLooping;

- (instancetype)initWithPlayerItem:(AVPlayerItem *)item AVFactory:(id<FVPAVFactory>)avFactory;

- (void)setVolume:(double)volume;

- (void)setPlaybackSpeed:(double)speed;

- (void)play;

- (void)pause;

- (void)seekTo:(int64_t)location completionHandler:(void (^)(BOOL))completionHandler;

@end
