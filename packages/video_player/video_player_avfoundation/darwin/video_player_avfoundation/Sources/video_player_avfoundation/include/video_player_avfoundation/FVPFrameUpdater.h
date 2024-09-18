// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

/// Manages the state to mediate between a display link callback and a texture update callback, to
/// decide when and how to update frames in the texture.
@interface FVPFrameUpdater : NSObject
// The callback to call when a new frame is available.
@property(nonatomic, copy, nullable) void (^onTextureAvailable)();
// The output that this updater is managing.
@property(nonatomic, weak) AVPlayerItemVideoOutput *videoOutput;
// The last available pixel buffer.
@property(nonatomic, assign) CVPixelBufferRef latestPixelBuffer;
@property(nonatomic, strong) dispatch_queue_t pixelBufferSynchronizationQueue;

/// Informs this object that the display link timer fired, so the frame should be updated if
/// possible.
- (void)displayLinkFired;
@end
