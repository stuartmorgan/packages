// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "./include/video_player_avfoundation/FVPEventChannelVideoPlayerDelegate.h"

#import <Foundation/Foundation.h>

@interface FVPEventChannelVideoPlayerDelegate () <FlutterStreamHandler>

@property(nonatomic) FlutterEventChannel *eventChannel;
@property(nonatomic) FlutterEventSink eventSink;
@property(nonatomic, copy) NSMutableArray<NSObject *> *queuedEvents;

@end

@implementation FVPEventChannelVideoPlayerDelegate

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar
                 playerIdentifier:(int64_t)identifier {
  self = [super init];
  if (self) {
    _queuedEvents = [[NSMutableArray alloc] init];
    _eventChannel = [FlutterEventChannel
        eventChannelWithName:[NSString stringWithFormat:@"flutter.io/videoPlayer/videoEvents%lld",
                                                        identifier]
             binaryMessenger:[registrar messenger]];
    // This retain loop is broken in videoPlayerWasDisposed.
    [_eventChannel setStreamHandler:self];
  }
  return self;
}

#pragma mark FlutterStreamHandler

- (FlutterError *_Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(nonnull FlutterEventSink)events {
  self.eventSink = events;

  // Send any events that came in before the sink was ready.
  for (id event in self.queuedEvents) {
    self.eventSink(event);
  }
  [self.queuedEvents removeAllObjects];

  return nil;
}

- (FlutterError *_Nullable)onCancelWithArguments:(id _Nullable)arguments {
  self.eventSink = nil;
  // No need to queue events coming in after this point; nil the queue so they will be discarded.
  self.queuedEvents = nil;
  return nil;
}

#pragma mark FVPVideoPlayerDelegate

- (void)videoPlayerDidInitializeWithDuration:(int64_t)duration size:(CGSize)size {
  [self sendOrQueue:@{
    @"event" : @"initialized",
    @"duration" : @(duration),
    @"width" : @(size.width),
    @"height" : @(size.height)
  }];
}

- (void)videoPlayerDidErrorWithMessage:(NSString *)errorMessage {
  [self sendOrQueue:[FlutterError errorWithCode:@"VideoError" message:errorMessage details:nil]];
}

- (void)videoPlayerDidComplete {
  [self sendOrQueue:@{@"event" : @"completed"}];
}

- (void)videoPlayerDidStartBuffering {
  [self sendOrQueue:@{@"event" : @"bufferingStart"}];
}

- (void)videoPlayerDidEndBuffering {
  [self sendOrQueue:@{@"event" : @"bufferingEnd"}];
}

- (void)videoPlayerDidUpdateBufferRegions:(NSArray<NSArray<NSValue *> *> *)regions {
  [self sendOrQueue:@{@"event" : @"bufferingUpdate", @"values" : regions}];
}

- (void)videoPlayerDidSetPlaying:(BOOL)playing {
  [self sendOrQueue:@{@"event" : @"isPlayingStateUpdate", @"isPlaying" : @(playing)}];
}

- (void)videoPlayerWasDisposed {
  [self.eventChannel setStreamHandler:nil];
}

#pragma mark Private methods

/// Sends the given event to the event sink if it is ready to receive events, or enqueues it to send
/// later if not.
- (void)sendOrQueue:(id)event {
  if (self.eventSink) {
    self.eventSink(event);
  } else {
    [self.queuedEvents addObject:event];
  }
}

@end
