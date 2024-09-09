// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Foundation/Foundation.h>

/// An implementation of a KVO observer that delegates to a block.
///
/// This allows registering an observer from Dart.
/// See https://github.com/dart-lang/native/issues/1508
@interface FVPBlockKeyValueObserver : NSObject

@property(nonatomic, nonnull) void (^observedValueDidChange)(id object, NSString *path);

- (instancetype)initWithCallback:(void (^__nonnull)(id, NSString *))callback;

+ (instancetype)observerWithCallback:(void (^__nonnull)(id, NSString *))callback;

@end
