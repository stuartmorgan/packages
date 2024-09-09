// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "./include/video_player_avfoundation/FVPBlockKeyValueObserver.h"

#import <Foundation/Foundation.h>

@implementation FVPBlockKeyValueObserver

- (instancetype)initWithCallback:(void (^)(id, NSString *))callback {
  if (self = [super init]) {
    _observedValueDidChange = callback;
  }
  return self;
}

+ (instancetype)observerWithCallback:(void (^)(id, NSString *))callback {
  return [[[self class] alloc] initWithCallback:callback];
}

- (void)observeValueForKeyPath:(NSString *)path
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  self.observedValueDidChange(object, path);
}

@end
