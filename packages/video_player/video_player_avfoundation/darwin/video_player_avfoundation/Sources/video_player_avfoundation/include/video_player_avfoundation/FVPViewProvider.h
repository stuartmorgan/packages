// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#if TARGET_OS_OSX
#import <Cocoa/Cocoa.h>
#else
#import <UIKit/UIKit.h>
#endif

/// Protocol for accessing the view that is displaying the Flutter content
/// associated with a plugin instance.
@protocol FVPViewProvider <NSObject>
@required
#if TARGET_OS_OSX
@property(readonly, nonatomic) NSView *view;
#else
@property(readonly, nonatomic) UIView *view;
#endif
@end
