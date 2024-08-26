// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "./include/video_player_avfoundation/FVPDefaultDisplayLinkFactory.h"

@implementation FVPDefaultDisplayLinkFactory
- (FVPDisplayLink *)displayLinkWithViewProvider:(id<FVPViewProvider>)viewProvider
                                       callback:(void (^)(void))callback {
  return [[FVPDisplayLink alloc] initWithViewProvider:viewProvider callback:callback];
}
@end
