// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Foundation/Foundation.h>

/// A facade for FVPVideoPlayerPlugin to temporarily work around the issue
/// with ffigen not being able to find Flutter.h.
@interface FVPFFIPlayer : NSObject
// Initializes with a weak pointer to the backing object. Type is ID because of
// the header problem; there are less ugly solutions but this will do for now.
- (instancetype)initWithPlayer:(id)player;

- (void)printTheInstanceForSanityChecking;
@end
