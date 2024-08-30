// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

/// Handles event/status callbacks from FVPVideoPlayer.
///
/// This is an abstraction around the event channel to allow FVPVideoPlayer to be completely
/// disconnected from implementation details specific to the plugin system.
@protocol FVPVideoPlayerDelegate <NSObject>
@required
// Called when there's a state change that should trigger a re-check of whether the player is
// now ready.
- (void)videoPlayerMayBeInitialized;
- (void)videoPlayerDidErrorWithMessage:(NSString *)errorMessage;
/// Called when the video player plays to the end and then stops (i.e., looping is not enabled).
- (void)videoPlayerDidComplete;
/// Called when the video player needs to buffer more in order to play witohut stopping.
- (void)videoPlayerDidStartBuffering;
/// Called when the video player has buffered enough to likely be able to play witohut stopping.
- (void)videoPlayerDidEndBuffering;
/// Called when the buffered regions change.
- (void)videoPlayerDidUpdateBufferRegionsForItem:(AVPlayerItem *)item;
/// Called when the player starts or stops playing.
- (void)videoPlayerDidSetPlaying:(BOOL)playing;
@end
