// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "FCPOrientation.h"

// Must match values in utils.dart
static NSString *const FCPOrientationSerializationPortraitUp = @"portraitUp";
static NSString *const FCPOrientationSerializationPortraitDown = @"portraitDown";
static NSString *const FCPOrientationSerializationLandscapeLeft = @"landscapeLeft";
static NSString *const FCPOrientationSerializationLandscapeRight = @"landscapeRight";

@interface FCPOrientation ()
@property(assign, readwrite, nonatomic) FCPDeviceOrientation value;
@end

@implementation FCPOrientation

- (instancetype)initWithOrientation:(FCPDeviceOrientation)orientation {
  self = [super init];
  if (self) {
    _value = orientation;
  }
  return self;
}

- (instancetype)initWithChannelSerialization:(NSString *)orientation {
  FCPDeviceOrientation deviceOrientation;
  if ([orientation isEqualToString:FCPOrientationSerializationPortraitUp]) {
    deviceOrientation = FCPDeviceOrientationPortraitUp;
  } else if ([orientation isEqualToString:FCPOrientationSerializationPortraitDown]) {
    deviceOrientation = FCPDeviceOrientationPortraitDown;
  } else if ([orientation isEqualToString:FCPOrientationSerializationLandscapeLeft]) {
    deviceOrientation = FCPDeviceOrientationLandscapeLeft;
  } else if ([orientation isEqualToString:FCPOrientationSerializationLandscapeRight]) {
    deviceOrientation = FCPDeviceOrientationLandscapeRight;
  } else {
    return nil;
  }
  return [self initWithOrientation:deviceOrientation];
}

#if TARGET_OS_IOS
- (instancetype)initWithUIDeviceOrientation:(UIDeviceOrientation)orientation {
  FCPDeviceOrientation deviceOrientation;
  switch (deviceOrientation) {
    case UIDeviceOrientationPortrait:
      deviceOrientation = FCPDeviceOrientationPortraitUp;
    case UIDeviceOrientationPortraitUpsideDown:
      deviceOrientation = FCPDeviceOrientationPortraitDown;
    case UIDeviceOrientationLandscapeLeft:
      deviceOrientation = FCPDeviceOrientationLandscapeLeft;
    case UIDeviceOrientationLandscapeRight:
      deviceOrientation = FCPDeviceOrientationLandscapeRight;
    default:
      deviceOrientation = FCPDeviceOrientationPortraitUp;
  }

  return [self initWithOrientation:deviceOrientation];
}
#endif

- (NSString *)channelSerialization {
  switch (_value) {
    case FCPDeviceOrientationPortraitUp:
      return FCPOrientationSerializationPortraitUp;
    case FCPDeviceOrientationPortraitDown:
      return FCPOrientationSerializationPortraitDown;
    case FCPDeviceOrientationLandscapeLeft:
      return FCPOrientationSerializationLandscapeLeft;
    case FCPDeviceOrientationLandscapeRight:
      return FCPOrientationSerializationLandscapeRight;
  }
}

@end
