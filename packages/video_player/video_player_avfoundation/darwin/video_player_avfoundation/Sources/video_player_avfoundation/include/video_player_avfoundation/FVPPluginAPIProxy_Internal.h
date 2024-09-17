// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#import "FVPViewProvider.h"

#if TARGET_OS_OSX
#import <FlutterMacOS/FlutterMacOS.h>
#else
#import <Flutter/Flutter.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface FVPPluginAPIProxy ()

// The registrar to query view information from.
@property(nonatomic, nonnull) NSObject<FlutterPluginRegistrar> *registrar;

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;

@end

NS_ASSUME_NONNULL_END
