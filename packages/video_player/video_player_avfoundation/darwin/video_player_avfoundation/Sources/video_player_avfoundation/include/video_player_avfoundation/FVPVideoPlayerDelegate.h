// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FVPItemProperty) {
  FVPItemPropertyLoadedTimeRanges,
  FVPItemPropertyStatus,
  FVPItemPropertyPresentationSize,
  FVPItemPropertyDuration,
  FVPItemPropertyPlaybackLikelyToKeepUp,
};

/// Handles event/status callbacks from FVPVideoPlayer.
///
/// This is an abstraction around the event channel to allow FVPVideoPlayer to be completely
/// disconnected from implementation details specific to the plugin system.
@protocol FVPVideoPlayerDelegate <NSObject>
@required
- (void)videoPlayerItem:(AVPlayerItem *)item didChangeProperty:(FVPItemProperty)property;
- (void)videoPlayerDidChangePlaybackRate;
/// Called when the video player plays to the end and then stops (i.e., looping is not enabled).
- (void)videoPlayerDidComplete;
@end
