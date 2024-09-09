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
#import "./include/video_player_avfoundation/FVPFrameUpdater.h"
#import "./include/video_player_avfoundation/FVPViewProvider.h"
#import "./include/video_player_avfoundation/InjectionProtocols.h"

/// The native component of a single video player instance.
@interface FVPVideoPlayer () <FlutterTexture>
// This is to fix 2 bugs: 1. blank video for encrypted video streams on iOS 16
// (https://github.com/flutter/flutter/issues/111457) and 2. swapped width and height for some video
// streams (not just iOS 16).  (https://github.com/flutter/flutter/issues/109116).
// An invisible AVPlayerLayer is used to overwrite the protection of pixel buffers in those streams
// for issue #1, and restore the correct width and height for issue #2.
@property(nonatomic) AVPlayerLayer *playerLayer;

/// Provides access to the enclosing Flutter view.
@property(nonatomic) id<FVPViewProvider> viewProvider;

// The updater that drives callbacks to the engine to indicate that a new frame is ready.
@property(nonatomic) FVPFrameUpdater *frameUpdater;

/// Configures the player to display with the given frame callback.
///
/// Until this is called, the player will not display any content, even if playing.
- (void)configureDisplayWithAvailableFrameCallback:(void (^)())frameAvailable;

@end
