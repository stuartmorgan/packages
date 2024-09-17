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

#import "./include/video_player_avfoundation/FVPFrameUpdater.h"

/// The native component of a single video player instance.
@interface FVPVideoPlayer () <FlutterTexture>

@property(nonatomic, strong, nonnull) AVPlayer *player;

// The updater that drives callbacks to the engine to indicate that a new frame is ready.
@property(nonatomic, nonnull) FVPFrameUpdater *frameUpdater;

@end
