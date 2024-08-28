// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Foundation/Foundation.h>

/// Protocol for accessing the view that is displaying the Flutter content
/// associated with a plugin instance.
@protocol FVPViewProvider <NSObject>
@required
// TODO(stuartmorgan): Make this UIView/NSView once pruning is implemented for ffigen; for now use
// id to avoid bringing in a ton of unwanted transitive dependencies via extensions.
@property(readonly, nonatomic) id view;
@end
