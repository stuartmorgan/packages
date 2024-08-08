// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "FVPVideoPlayerPlugin.h"

#import <AVFoundation/AVFoundation.h>

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#import "FVPDisplayLink.h"

/// Protocol for AVFoundation object instance factory. Used for injecting framework objects in tests.
@protocol FVPAVFactory
@required
- (AVPlayer *)playerWithPlayerItem:(AVPlayerItem *)playerItem;
- (AVPlayerItemVideoOutput *)videoOutputWithPixelBufferAttributes:
    (NSDictionary<NSString *, id> *)attributes;
@end

/// Protocol for an AVPlayer instance factory. Used for injecting display links in tests.
// TODO(stuartmorgan): Abstract the registrar with a more minimal protocol.
@protocol FVPDisplayLinkFactory
- (FVPDisplayLink *)displayLinkWithRegistrar:(id<FlutterPluginRegistrar>)registrar
                                    callback:(void (^)(void))callback;
@end
