// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "./include/video_player_avfoundation/FVPVideoPlayer.h"

#import <AVFoundation/AVFoundation.h>

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#import "./include/video_player_avfoundation/FVPDisplayLink.h"
#import "./include/video_player_avfoundation/InjectionProtocols.h"
#import "FVPFrameUpdater.h"

/// The native component of a single video player instance.
@interface FVPVideoPlayer () <FlutterStreamHandler, FlutterTexture>
@property(nonatomic) AVPlayer *player;
// This is to fix 2 bugs: 1. blank video for encrypted video streams on iOS 16
// (https://github.com/flutter/flutter/issues/111457) and 2. swapped width and height for some video
// streams (not just iOS 16).  (https://github.com/flutter/flutter/issues/109116).
// An invisible AVPlayerLayer is used to overwrite the protection of pixel buffers in those streams
// for issue #1, and restore the correct width and height for issue #2.
@property(nonatomic) AVPlayerLayer *playerLayer;

@property(readonly, nonatomic) AVPlayerItemVideoOutput *videoOutput;
// The plugin registrar, to obtain view information from.
@property(nonatomic, weak) NSObject<FlutterPluginRegistrar> *registrar;
// The CALayer associated with the Flutter view this plugin is associated with, if any.
@property(nonatomic, readonly) CALayer *flutterViewLayer;
@property(nonatomic) FlutterEventChannel *eventChannel;
@property(nonatomic) FlutterEventSink eventSink;
@property(nonatomic) CGAffineTransform preferredTransform;
@property(nonatomic, readonly) BOOL disposed;
@property(nonatomic, readonly) BOOL isPlaying;
@property(nonatomic) BOOL isLooping;
@property(nonatomic, readonly) BOOL isInitialized;
// The updater that drives callbacks to the engine to indicate that a new frame is ready.
@property(nonatomic) FVPFrameUpdater *frameUpdater;
// The display link that drives frameUpdater.
@property(nonatomic) FVPDisplayLink *displayLink;
// Whether a new frame needs to be provided to the engine regardless of the current play/pause state
// (e.g., after a seek while paused). If YES, the display link should continue to run until the next
// frame is successfully provided.
@property(nonatomic, assign) BOOL waitingForFrame;

- (instancetype)initWithURL:(NSURL *)url
               frameUpdater:(FVPFrameUpdater *)frameUpdater
                displayLink:(FVPDisplayLink *)displayLink
                httpHeaders:(nonnull NSDictionary<NSString *, NSString *> *)headers
                  avFactory:(id<FVPAVFactory>)avFactory
                  registrar:(NSObject<FlutterPluginRegistrar> *)registrar;

- (instancetype)initWithAsset:(NSString *)asset
                 frameUpdater:(FVPFrameUpdater *)frameUpdater
                  displayLink:(FVPDisplayLink *)displayLink
                    avFactory:(id<FVPAVFactory>)avFactory
                    registrar:(NSObject<FlutterPluginRegistrar> *)registrar;

// Tells the player to run its frame updater until it receives a frame, regardless of the
// play/pause state.
- (void)expectFrame;

/// Informs the player that it won't be used from Dart any more and that it should clean up
/// related resources.
- (void)dispose;
@end
