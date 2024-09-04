// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "./include/video_player_avfoundation/FVPBlockAdapterVideoPlayerDelegate.h"

#import <Foundation/Foundation.h>

@implementation FVPBlockAdapterVideoPlayerDelegate

// These should all have null handling, or have an init making them all non-nullable, but this is
// fine for temporary code.
#pragma mark FVPVideoPlayerDelegate

- (void)videoPlayerItem:(AVPlayerItem *)item didChangeProperty:(FVPItemProperty)property {
  self.videoPlayerItemDidChangePropertyHandler(item, property);
}

- (void)videoPlayerDidChangePlaybackRate {
  self.videoPlayerDidChangePlaybackRateHandler();
}

- (void)videoPlayerDidComplete {
  self.videoPlayerDidCompleteHandler();
}

@end
