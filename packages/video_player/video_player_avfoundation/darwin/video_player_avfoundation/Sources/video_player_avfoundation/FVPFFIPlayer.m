// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "./include/video_player_avfoundation/FVPVideoPlayerPlugin.h"

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

@interface FVPFFIPlayer ()
@property(nonatomic) FVPVideoPlayerPlugin plugin;
@end

@implementation FVPFFIPlayer
- (instancetype)initWithPlayer:(long)fvpPluginRawPointer {
  self = [super init];
  if (self) {
    // TODO(stuartmorgan): Something better than this, hopefully.
    _plugin = (FVPVideoPlayerPlugin *)fvpPluginRawPointer;
  }
  return self;
}

- (void)printTheInstanceForSanityChecking {
  NSLog([NSString stringWithFormat:@"%@", self.plugin]);
}
@end
