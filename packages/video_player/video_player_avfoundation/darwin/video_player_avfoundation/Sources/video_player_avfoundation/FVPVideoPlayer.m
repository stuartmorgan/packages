// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "./include/video_player_avfoundation/FVPVideoPlayer.h"
#import "./include/video_player_avfoundation/FVPVideoPlayer_Test.h"
#import "FVPVideoPlayer_Private.h"

#import <AVFoundation/AVFoundation.h>
#import <GLKit/GLKit.h>

#import "./include/video_player_avfoundation/AVAssetTrackUtils.h"
#import "./include/video_player_avfoundation/FVPDisplayLink.h"
#import "FVPFrameUpdater.h"

NS_INLINE CGFloat FVPRadiansToDegrees(CGFloat radians) {
  // Input range [-pi, pi] or [-180, 180]
  CGFloat degrees = GLKMathRadiansToDegrees((float)radians);
  if (degrees < 0) {
    // Convert -90 to 270 and -180 to 180
    return degrees + 360;
  }
  // Output degrees in between [0, 360]
  return degrees;
};

static void FVPRegisterObservers(AVPlayerItem *item, AVPlayer *player, NSObject *observer) {
  [player addObserver:observer
           forKeyPath:@"rate"
              options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
              context:NULL];
}

@implementation FVPVideoPlayer

- (instancetype)initWithPlayerItem:(AVPlayerItem *)item
                      viewProvider:(id<FVPViewProvider>)viewProvider
                         AVFactory:(id<FVPAVFactory>)avFactory
                displayLinkFactory:(id<FVPDisplayLinkFactory>)displayLinkFactory {
  NSAssert([NSThread isMainThread], @"Must be called on main thread");
  self = [super init];
  NSAssert(self, @"super init cannot be nil");

  _viewProvider = viewProvider;
  _frameUpdater = [[FVPFrameUpdater alloc] init];

  AVAsset *asset = [item asset];
  void (^assetCompletionHandler)(void) = ^{
    if ([asset statusOfValueForKey:@"tracks" error:nil] == AVKeyValueStatusLoaded) {
      NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
      if ([tracks count] > 0) {
        AVAssetTrack *videoTrack = tracks[0];
        void (^trackCompletionHandler)(void) = ^{
          if (self->_disposed) return;
          if ([videoTrack statusOfValueForKey:@"preferredTransform"
                                        error:nil] == AVKeyValueStatusLoaded) {
            // Rotate the video by using a videoComposition and the preferredTransform
            self->_preferredTransform = FVPGetStandardizedTransformForTrack(videoTrack);
            // Note:
            // https://developer.apple.com/documentation/avfoundation/avplayeritem/1388818-videocomposition
            // Video composition can only be used with file-based media and is not supported for
            // use with media served using HTTP Live Streaming.
            AVMutableVideoComposition *videoComposition =
                [self getVideoCompositionWithTransform:self->_preferredTransform
                                             withAsset:asset
                                        withVideoTrack:videoTrack];
            item.videoComposition = videoComposition;
          }
        };
        [videoTrack loadValuesAsynchronouslyForKeys:@[ @"preferredTransform" ]
                                  completionHandler:trackCompletionHandler];
      }
    }
  };

  _player = [avFactory playerWithPlayerItem:item];
  _player.actionAtItemEnd = AVPlayerActionAtItemEndNone;

  // This is to fix 2 bugs: 1. blank video for encrypted video streams on iOS 16
  // (https://github.com/flutter/flutter/issues/111457) and 2. swapped width and height for some
  // video streams (not just iOS 16).  (https://github.com/flutter/flutter/issues/109116). An
  // invisible AVPlayerLayer is used to overwrite the protection of pixel buffers in those streams
  // for issue #1, and restore the correct width and height for issue #2.
  _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
#if TARGET_OS_OSX
  NSView *view = viewProvider.view;
#else
  UIView *view = viewProvider.view;
#endif
  [view.layer addSublayer:_playerLayer];

  // Configure output.
  NSDictionary *pixBuffAttributes = @{
    (id)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA),
    (id)kCVPixelBufferIOSurfacePropertiesKey : @{}
  };
  _videoOutput = [avFactory videoOutputWithPixelBufferAttributes:pixBuffAttributes];
  _frameUpdater.videoOutput = _videoOutput;

  __weak FVPFrameUpdater *frameUpdater = _frameUpdater;
  _displayLink = [displayLinkFactory displayLinkWithViewProvider:viewProvider
                                                        callback:^() {
                                                          [frameUpdater displayLinkFired];
                                                        }];

  FVPRegisterObservers(item, _player, self);

  [asset loadValuesAsynchronouslyForKeys:@[ @"tracks" ] completionHandler:assetCompletionHandler];

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
  if (!_disposed) {
    [self removeKeyValueObservers];
  }
}

- (AVMutableVideoComposition *)getVideoCompositionWithTransform:(CGAffineTransform)transform
                                                      withAsset:(AVAsset *)asset
                                                 withVideoTrack:(AVAssetTrack *)videoTrack {
  AVMutableVideoCompositionInstruction *instruction =
      [AVMutableVideoCompositionInstruction videoCompositionInstruction];
  instruction.timeRange = CMTimeRangeMake(kCMTimeZero, [asset duration]);
  AVMutableVideoCompositionLayerInstruction *layerInstruction =
      [AVMutableVideoCompositionLayerInstruction
          videoCompositionLayerInstructionWithAssetTrack:videoTrack];
  [layerInstruction setTransform:_preferredTransform atTime:kCMTimeZero];

  AVMutableVideoComposition *videoComposition = [AVMutableVideoComposition videoComposition];
  instruction.layerInstructions = @[ layerInstruction ];
  videoComposition.instructions = @[ instruction ];

  // If in portrait mode, switch the width and height of the video
  CGFloat width = videoTrack.naturalSize.width;
  CGFloat height = videoTrack.naturalSize.height;
  NSInteger rotationDegrees =
      (NSInteger)round(FVPRadiansToDegrees(atan2(_preferredTransform.b, _preferredTransform.a)));
  if (rotationDegrees == 90 || rotationDegrees == 270) {
    width = videoTrack.naturalSize.height;
    height = videoTrack.naturalSize.width;
  }
  videoComposition.renderSize = CGSizeMake(width, height);

  // TODO(@recastrodiaz): should we use videoTrack.nominalFrameRate ?
  // Currently set at a constant 30 FPS
  videoComposition.frameDuration = CMTimeMake(1, 30);

  return videoComposition;
}

- (void)observeValueForKeyPath:(NSString *)path
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  [self.delegate videoPlayerDidChangePlaybackRate];
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

  BOOL returnedBuffer = buffer != NULL;

  dispatch_async(dispatch_get_main_queue(), ^{
    if (self.waitingForFrame && returnedBuffer) {
      self.waitingForFrame = NO;
      // If the display link was only running temporarily to pick up a new frame while the video was
      // paused, stop it again.
      if (!self.playing) {
        self.displayLink.running = NO;
      }
    }
  });

  return buffer;
}

- (void)dispose {
  NSAssert([NSThread isMainThread], @"Must be called on main thread");
  _disposed = YES;
  [_playerLayer removeFromSuperlayer];
  _displayLink = nil;
  [self removeKeyValueObservers];

  [self.player replaceCurrentItemWithPlayerItem:nil];

  if (self.onDisposed) {
    self.onDisposed();
  }
}

/// Removes all key-value observers set up for the player.
///
/// This is called from dealloc, so must not use any methods on self.
- (void)removeKeyValueObservers {
  [_player removeObserver:self forKeyPath:@"rate"];
}

@end
