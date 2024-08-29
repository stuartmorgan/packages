// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Foundation/Foundation.h>

#import "FVPVideoPlayerDelegate.h"

/// An implementation of FVPVideoPlayerDelegate that forwards messages blocks.
///
/// This is a manual version of what future versions of ffigen will codegen, to unblock exploration.
@interface FVPBlockAdapterVideoPlayerDelegate : NSObject <FVPVideoPlayerDelegate>

@property(nonatomic) void (^videoPlayerDidInitializeHandler)(int64_t duration, CGSize size);
@property(nonatomic) void (^videoPlayerDidErrorHandler)(NSString *message);
@property(nonatomic) void (^videoPlayerDidCompleteHandler)();
@property(nonatomic) void (^videoPlayerDidStartBufferingHandler)();
@property(nonatomic) void (^videoPlayerDidEndBufferingHandler)();
@property(nonatomic) void (^videoPlayerDidUpdateBufferRegionsHandler)(AVPlayerItem *item);
@property(nonatomic) void (^videoPlayerDidSetPlayingHandler)(BOOL playing);

@end
