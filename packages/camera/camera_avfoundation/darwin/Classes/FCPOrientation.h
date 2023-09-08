// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

@import AVFoundation;

/**
 * Cross-platform representation of a device orientation, corresponding to the Dart
 * DeviceOrientation.
 */
typedef NS_ENUM(NSInteger, FCPDeviceOrientation) {
  FCPDeviceOrientationPortraitUp,
  FCPDeviceOrientationPortraitDown,
  FCPDeviceOrientationLandscapeLeft,
  FCPDeviceOrientationLandscapeRight,
};

/**
 * Cross-platform representation of a device orientation, corresponding to the Dart
 * DeviceOrientation.
 */
// TODO(stuartmorgan): When this plugin is converted to Pigeon, this class and the enum above can
// be replaced with a Pigeon-generated nullable enum.
@interface FCPOrientation : NSObject

/**
 * Initializes an orientation with the given Dart device orientation.
 */
- (instancetype)initWithOrientation:(FCPDeviceOrientation)orientation NS_DESIGNATED_INITIALIZER;

/**
 * Initializes an orientation with the given method channel representation.
 */
- (instancetype)initWithChannelSerialization:(NSString *)orientation;

#if TARGET_OS_IOS
/**
 * Initializes an orientation with the given native device orientation.
 */
- (instancetype)initWithUIDeviceOrientation:(UIDeviceOrientation)orientation;
#endif

- (instancetype)init NS_UNAVAILABLE;

@property(readonly, assign, nonatomic) FCPDeviceOrientation value;

// The method channel serialization of this orientation.
@property(readonly, nonatomic) NSString *channelSerialization;

@end
