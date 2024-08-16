// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Foundation/Foundation.h>

#import "FVPViewProvider.h"

// A cross-platform display link abstraction.
@interface FVPDisplayLink : NSObject

/// Whether the display link is currently running (i.e., firing events).
///
/// Defaults to NO.
@property(nonatomic, assign) BOOL running;

/// Initializes a display link that calls the given callback when fired.
///
/// The display link starts paused, so must be started, by setting 'running' to YES, before the
/// callback will fire.
- (instancetype)initWithViewProvider:(id<FVPViewProvider>)viewProvider
                            callback:(void (^)(void))callback NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end
