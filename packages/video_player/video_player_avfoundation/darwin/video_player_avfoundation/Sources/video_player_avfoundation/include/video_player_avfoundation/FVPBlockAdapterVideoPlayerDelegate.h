// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Foundation/Foundation.h>

#import "FVPVideoPlayerDelegate.h"

/// An implementation of FVPVideoPlayerDelegate that forwards messages blocks.
///
/// This is a manual version of what future versions of ffigen will codegen, to unblock exploration.
@interface FVPBlockAdapterVideoPlayerDelegate : NSObject <FVPVideoPlayerDelegate>

@property(nonatomic) void (^videoPlayerItemDidChangePropertyHandler)
    (AVPlayerItem *item, FVPItemProperty property);
@property(nonatomic) void (^videoPlayerDidChangePlaybackRateHandler)();
@property(nonatomic) void (^videoPlayerDidCompleteHandler)();

@end
