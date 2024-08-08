// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "./include/video_player_avfoundation/FVPFFIPlayer.h"

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#import "./include/video_player_avfoundation/FVPVideoPlayer.h"
// Private interface for facade access.
#import "./include/video_player_avfoundation/FVPVideoPlayer_Test.h"
#import "FVPVideoPlayer_Private.h"

@interface FVPFFIPlayer ()
@property(nonatomic, weak) FVPVideoPlayer *player;
@end

@implementation FVPFFIPlayer
- (instancetype)initWithPlayer:(id)player {
  self = [super init];
  if (self) {
    _player = player;
  }
  return self;
}

- (void)printTheInstanceForSanityChecking {
  NSLog([NSString stringWithFormat:@"%@", self.player]);
  NSLog([NSString stringWithFormat:@"Position: %ld", self.player.position]);
}
@end
