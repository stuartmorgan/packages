// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

/// Protocol for accessing information about the view that is displaying the
/// Flutter content associated with a plugin instance.
///
/// The view itself is abstracted since the class is different on iOS and macOS,
/// and that's more trouble than it's worth when using ffigen.
@protocol FVPViewProvider <NSObject>
@required
@property(readonly, nonatomic) CALayer *layer;
@end
