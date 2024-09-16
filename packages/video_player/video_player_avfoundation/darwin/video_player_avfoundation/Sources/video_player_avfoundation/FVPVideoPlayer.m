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
                          item:(AVPlayerItem *)item
                        output:(AVPlayerItemVideoOutput *)videoOutput
                  viewProvider:(id<FVPViewProvider>)viewProvider
                  frameUpdater:(FVPFrameUpdater *)frameUpdater
                 frameCallback:(void (^__nonnull)(void))frameCallback {
  NSAssert([NSThread isMainThread], @"Must be called on main thread");
  self = [super init];
  NSAssert(self, @"super init cannot be nil");

  _player = player;
  _viewProvider = viewProvider;
  _videoOutput = videoOutput;
  _frameUpdater = frameUpdater;
  _onFrameProvided = frameCallback;

  // This is to fix 2 bugs: 1. blank video for encrypted video streams on iOS 16
  // (https://github.com/flutter/flutter/issues/111457) and 2. swapped width and height for some
  // video streams (not just iOS 16).  (https://github.com/flutter/flutter/issues/109116). An
  // invisible AVPlayerLayer is used to overwrite the protection of pixel buffers in those streams
  // for issue #1, and restore the correct width and height for issue #2.
  // TODO(stuartmorgan): Move this to native once NSView/UIView don't pull in the world.
  _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
#if TARGET_OS_OSX
  NSView *view = viewProvider.view;
#else
  UIView *view = viewProvider.view;
#endif
  [view.layer addSublayer:_playerLayer];

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

- (void)dispose {
  NSAssert([NSThread isMainThread], @"Must be called on main thread");
  _disposed = YES;
  [_playerLayer removeFromSuperlayer];

  if (self.onDisposed) {
    self.onDisposed();
  }
}

@end
