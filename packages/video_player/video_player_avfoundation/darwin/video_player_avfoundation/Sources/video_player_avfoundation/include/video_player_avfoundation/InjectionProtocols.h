// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <AVFoundation/AVFoundation.h>

#import "FVPDisplayLink.h"
#import "FVPViewProvider.h"

/// Protocol for AVFoundation object instance factory. Used for injecting framework objects in
/// tests.
@protocol FVPAVFactory <NSObject>
@required
- (AVPlayer *)playerWithPlayerItem:(AVPlayerItem *)playerItem;
- (AVPlayerItemVideoOutput *)videoOutputWithPixelBufferAttributes:
    (NSDictionary<NSString *, id> *)attributes;
@end

/// Protocol for an AVPlayer instance factory. Used for injecting display links in tests.
@protocol FVPDisplayLinkFactory <NSObject>
@required
- (FVPDisplayLink *)displayLinkWithViewProvider:(id<FVPViewProvider>)viewProvider
                                       callback:(void (^)(void))callback;
@end
