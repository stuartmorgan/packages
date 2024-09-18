// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "./include/video_player_avfoundation/FVPFrameUpdater.h"

#import <AVFoundation/AVFoundation.h>
#import <CoreFoundation/CoreFoundation.h>

@implementation FVPFrameUpdater

- (instancetype)init {
  self = [super init];
  NSAssert(self, @"super init cannot be nil");
  if (self) {
    _pixelBufferSynchronizationQueue =
        dispatch_queue_create("io.flutter.video_player.pixelBufferSynchronizationQueue", NULL);
  }
  return self;
}

- (void)displayLinkFired {
  if (![NSThread isMainThread]) {
    NSLog(@"  Uh-oh, on wrong thread for display link!");
  }
  dispatch_async(self.pixelBufferSynchronizationQueue, ^{
    // Only report a new frame if one is actually available.
    CMTime outputItemTime = [self.videoOutput itemTimeForHostTime:CACurrentMediaTime()];
    if (![self.videoOutput hasNewPixelBufferForItemTime:outputItemTime]) {
      return;
    }
    // Copy the buffer now, since there's no guarantee that it will still be available in the video
    // output by the time the engine asks a new texture.
    CVBufferRelease(self.latestPixelBuffer);
    self.latestPixelBuffer = [self.videoOutput copyPixelBufferForItemTime:outputItemTime
                                                       itemTimeForDisplay:NULL];
    dispatch_async(dispatch_get_main_queue(), ^() {
      if (self.onTextureAvailable) {
        self.onTextureAvailable();
      }
    });
  });
}

- (void)dealloc {
  if (![NSThread isMainThread]) {
    NSLog(@"  Uh-oh, on wrong thread for deallocing frame updater!");
  }
  CVBufferRelease(_latestPixelBuffer);
}

@end
