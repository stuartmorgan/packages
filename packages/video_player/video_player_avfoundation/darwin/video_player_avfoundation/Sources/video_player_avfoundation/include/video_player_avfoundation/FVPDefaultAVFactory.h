// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <AVFoundation/AVFoundation.h>

#import "InjectionProtocols.h"

/// An implementation of FVPAVFactory that forwards directly to AVPlayer*.
// TODO(stuartmorgan): Move this to Dart.
@interface FVPDefaultAVFactory : NSObject <FVPAVFactory>
@end
