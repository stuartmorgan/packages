// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

#import "FVPDisplayLink.h"
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

// The display link that drives frameUpdater.
@property(nonatomic, strong) FVPDisplayLink *displayLink;

// The output to use for items being played.
@property(nonatomic, strong) AVPlayerItemVideoOutput *videoOutput;

@property(nonatomic, strong) AVPlayer *player;

@property(nonatomic, readonly) BOOL disposed;

@property(nonatomic, assign) BOOL initialized;

@property(nonatomic, assign) BOOL playing;

@property(nonatomic, assign) CGAffineTransform preferredTransform;

// A callback to call during 'dispose'.
@property(nonatomic, copy, nullable) void (^onDisposed)();

// Whether a new frame needs to be provided to the engine regardless of the current play/pause state
// (e.g., after a seek while paused). If YES, the display link should continue to run until the next
// frame is successfully provided.
@property(nonatomic, assign) BOOL waitingForFrame;

- (instancetype)initWithPlayerItem:(AVPlayerItem *)item
                      viewProvider:(id<FVPViewProvider>)viewProvider
                         AVFactory:(id<FVPAVFactory>)avFactory
                displayLinkFactory:(id<FVPDisplayLinkFactory>)displayLinkFactory;

// Tells the player to run its frame updater until it receives a frame, regardless of the
// play/pause state.
- (void)expectFrame;

/// Informs the player that it won't be used from Dart any more and that it should clean up
/// related resources.
- (void)dispose;

@end
