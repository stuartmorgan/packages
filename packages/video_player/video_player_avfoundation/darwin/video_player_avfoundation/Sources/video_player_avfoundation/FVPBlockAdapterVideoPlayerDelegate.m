// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "./include/video_player_avfoundation/FVPBlockAdapterVideoPlayerDelegate.h"

#import <Foundation/Foundation.h>

@implementation FVPBlockAdapterVideoPlayerDelegate

#pragma mark FVPVideoPlayerDelegate

- (void)videoPlayerDidChangePlaybackRate {
  if (self.videoPlayerDidChangePlaybackRateHandler) {
    self.videoPlayerDidChangePlaybackRateHandler();
  }
}

@end
