// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "./include/video_player_avfoundation/FVPVideoPlayer.h"
#import "./include/video_player_avfoundation/FVPVideoPlayer_Test.h"
#import "FVPVideoPlayer_Private.h"

#import <AVFoundation/AVFoundation.h>

#import "./include/video_player_avfoundation/AVAssetTrackUtils.h"
#import "./include/video_player_avfoundation/FVPFrameUpdater.h"

@implementation FVPVideoPlayer

- (instancetype)initWithPlayer:(nonnull AVPlayer *)player
                        output:(AVPlayerItemVideoOutput *)videoOutput
                  frameUpdater:(FVPFrameUpdater *)frameUpdater
                 frameCallback:(void (^__nonnull)(void))frameCallback {
  NSAssert([NSThread isMainThread], @"Must be called on main thread");
  self = [super init];
  NSAssert(self, @"super init cannot be nil");

  _player = player;
  _videoOutput = videoOutput;
  _frameUpdater = frameUpdater;
  _onFrameProvided = frameCallback;

  return self;
}

- (void)configureDisplayWithAvailableFrameCallback:(void (^)())frameAvailable {
  // Wire up the display link.
  self.frameUpdater.onTextureAvailable = frameAvailable;
}

- (void)dealloc {
  NSLog(@"Dealloc'd");
  if (![NSThread isMainThread]) {
    NSLog(@"  Uh-oh, on wrong thread!");
  }
}

- (CVPixelBufferRef)copyPixelBuffer {
  // TODO(stuartmorgan): Fix the threading here; this is method is not called on the main thread.
  CVPixelBufferRef buffer = NULL;
  CMTime outputItemTime = [_videoOutput itemTimeForHostTime:CACurrentMediaTime()];
  if ([_videoOutput hasNewPixelBufferForItemTime:outputItemTime]) {
    buffer = [_videoOutput copyPixelBufferForItemTime:outputItemTime itemTimeForDisplay:NULL];
  } else {
    // If the current time isn't available yet, use the time that was checked when informing the
    // engine that a frame was available (if any).
    CMTime lastAvailableTime = self.frameUpdater.lastKnownAvailableTime;
    if (CMTIME_IS_VALID(lastAvailableTime)) {
      buffer = [_videoOutput copyPixelBufferForItemTime:lastAvailableTime itemTimeForDisplay:NULL];
    }
  }

  if (buffer != NULL) {
    dispatch_async(dispatch_get_main_queue(), ^{
      _onFrameProvided();
    });
  }

  return buffer;
}

@end
