// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "./include/video_player_avfoundation/FVPVideoPlayer.h"
#import "./include/video_player_avfoundation/FVPVideoPlayer_Test.h"

#import <AVFoundation/AVFoundation.h>

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#import "./include/video_player_avfoundation/FVPFrameUpdater.h"

/// The native component of a single video player instance.
@interface FVPVideoPlayer () <FlutterTexture>

// The updater that drives callbacks to the engine to indicate that a new frame is ready.
@property(nonatomic, nonnull) FVPFrameUpdater *frameUpdater;

@end

@implementation FVPVideoPlayer

- (instancetype)initWithVideoOutput:(AVPlayerItemVideoOutput *)videoOutput
                       frameUpdater:(FVPFrameUpdater *)frameUpdater
                      frameCallback:(void (^__nonnull)(void))frameCallback {
  NSAssert([NSThread isMainThread], @"Must be called on main thread");
  self = [super init];
  NSAssert(self, @"super init cannot be nil");

  _videoOutput = videoOutput;
  _frameUpdater = frameUpdater;
  _onFrameProvided = frameCallback;

  return self;
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
