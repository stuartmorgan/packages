// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "FVPVideoPlayerPlugin.h"

#import <AVFoundation/AVFoundation.h>

#import "FVPVideoPlayer.h"
#import "InjectionProtocols.h"
#import "messages.g.h"

@interface FVPVideoPlayerPlugin () <FVPAVFoundationVideoPlayerApi>

@property(readonly, strong, nonatomic)
    NSMutableDictionary<NSNumber *, FVPVideoPlayer *> *playersByTextureId;

- (instancetype)initWithAVFactory:(id<FVPAVFactory>)avFactory
               displayLinkFactory:(id<FVPDisplayLinkFactory>)displayLinkFactory
                        registrar:(NSObject<FlutterPluginRegistrar> *)registrar;

@end
