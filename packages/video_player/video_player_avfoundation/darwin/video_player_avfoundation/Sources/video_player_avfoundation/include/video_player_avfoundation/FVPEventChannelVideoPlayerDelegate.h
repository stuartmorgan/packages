// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Foundation/Foundation.h>

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

#import "FVPVideoPlayerDelegate.h"

/// An implementation of FVPVideoPlayerDelegate that forwards messages to Dart via an event channel.
@interface FVPEventChannelVideoPlayerDelegate : NSObject <FVPVideoPlayerDelegate>

/// Initializes the the delegate to use an event channel with the given channel instance identifier.
- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar
                 playerIdentifier:(int64_t)identifier;

@end
