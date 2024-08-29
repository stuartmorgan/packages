// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

#import "FVPVideoPlayerDelegate.h"
#import "InjectionProtocols.h"

/// The native component of a single video player instance.
@interface FVPVideoPlayer : NSObject

/// The event delegate that communicates information back to the Dart side of the plugin.
///
/// Note that although this is a delegate, this is an owning reference.
// TODO(stuartmorgan): Change to weak once this is on the Dart side instead of
// an object we need to keep around.
@property(nonatomic, strong) id<FVPVideoPlayerDelegate> delegate;

@property(nonatomic, strong) AVPlayer *player;

@property(nonatomic, readonly) BOOL disposed;

@property(nonatomic, readonly) BOOL isPlaying;

@property(nonatomic) BOOL isLooping;

- (instancetype)initWithPlayerItem:(AVPlayerItem *)item
                      viewProvider:(id<FVPViewProvider>)viewProvider
                         AVFactory:(id<FVPAVFactory>)avFactory
                displayLinkFactory:(id<FVPDisplayLinkFactory>)displayLinkFactory;

- (void)play;

- (void)pause;

- (void)seekTo:(int64_t)location completionHandler:(void (^)(BOOL))completionHandler;

@end
