#import <AVFoundation/AVFoundation.h>
#include <stdint.h>
#import "include/video_player_avfoundation/FVPBlockAdapterVideoPlayerDelegate.h"
#import "include/video_player_avfoundation/FVPDefaultAVFactory.h"
#import "include/video_player_avfoundation/FVPDefaultDisplayLinkFactory.h"
#import "include/video_player_avfoundation/FVPVideoPlayer.h"
#import "include/video_player_avfoundation/FVPVideoPlayerDelegate.h"

#if !__has_feature(objc_arc)
#error "This file must be compiled with ARC enabled"
#endif

id objc_retain(id);
id objc_retainBlock(id);

typedef void (^ListenerBlock)(NSDictionary *, struct _NSRange, BOOL *);
ListenerBlock wrapListenerBlock_ObjCBlock_ffiVoid_NSDictionary_NSRange_bool(ListenerBlock block)
    NS_RETURNS_RETAINED {
  return ^void(NSDictionary *arg0, struct _NSRange arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void (^ListenerBlock1)(id, struct _NSRange, BOOL *);
ListenerBlock1 wrapListenerBlock_ObjCBlock_ffiVoid_objcObjCObject_NSRange_bool(ListenerBlock1 block)
    NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void (^ListenerBlock2)(NSDate *, BOOL, BOOL *);
ListenerBlock2 wrapListenerBlock_ObjCBlock_ffiVoid_NSDate_bool_bool(ListenerBlock2 block)
    NS_RETURNS_RETAINED {
  return ^void(NSDate *arg0, BOOL arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void (^ListenerBlock3)(NSTimer *);
ListenerBlock3 wrapListenerBlock_ObjCBlock_ffiVoid_NSTimer(ListenerBlock3 block)
    NS_RETURNS_RETAINED {
  return ^void(NSTimer *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock4)(NSFileHandle *);
ListenerBlock4 wrapListenerBlock_ObjCBlock_ffiVoid_NSFileHandle(ListenerBlock4 block)
    NS_RETURNS_RETAINED {
  return ^void(NSFileHandle *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock5)(NSError *);
ListenerBlock5 wrapListenerBlock_ObjCBlock_ffiVoid_NSError(ListenerBlock5 block)
    NS_RETURNS_RETAINED {
  return ^void(NSError *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock6)(NSDictionary *, NSError *);
ListenerBlock6 wrapListenerBlock_ObjCBlock_ffiVoid_NSDictionary_NSError(ListenerBlock6 block)
    NS_RETURNS_RETAINED {
  return ^void(NSDictionary *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock7)(NSArray *);
ListenerBlock7 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray(ListenerBlock7 block)
    NS_RETURNS_RETAINED {
  return ^void(NSArray *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock8)(NSTextCheckingResult *, NSMatchingFlags, BOOL *);
ListenerBlock8 wrapListenerBlock_ObjCBlock_ffiVoid_NSTextCheckingResult_NSMatchingFlags_bool(
    ListenerBlock8 block) NS_RETURNS_RETAINED {
  return ^void(NSTextCheckingResult *arg0, NSMatchingFlags arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void (^ListenerBlock9)(NSCachedURLResponse *);
ListenerBlock9 wrapListenerBlock_ObjCBlock_ffiVoid_NSCachedURLResponse(ListenerBlock9 block)
    NS_RETURNS_RETAINED {
  return ^void(NSCachedURLResponse *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock10)(NSURLResponse *, NSData *, NSError *);
ListenerBlock10 wrapListenerBlock_ObjCBlock_ffiVoid_NSURLResponse_NSData_NSError(
    ListenerBlock10 block) NS_RETURNS_RETAINED {
  return ^void(NSURLResponse *arg0, NSData *arg1, NSError *arg2) {
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

typedef void (^ListenerBlock11)(NSDictionary *);
ListenerBlock11 wrapListenerBlock_ObjCBlock_ffiVoid_NSDictionary(ListenerBlock11 block)
    NS_RETURNS_RETAINED {
  return ^void(NSDictionary *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock12)(NSURLCredential *);
ListenerBlock12 wrapListenerBlock_ObjCBlock_ffiVoid_NSURLCredential(ListenerBlock12 block)
    NS_RETURNS_RETAINED {
  return ^void(NSURLCredential *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock13)(NSArray *, NSArray *, NSArray *);
ListenerBlock13 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray_NSArray_NSArray(ListenerBlock13 block)
    NS_RETURNS_RETAINED {
  return ^void(NSArray *arg0, NSArray *arg1, NSArray *arg2) {
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

typedef void (^ListenerBlock14)(NSArray *);
ListenerBlock14 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray1(ListenerBlock14 block)
    NS_RETURNS_RETAINED {
  return ^void(NSArray *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock15)(NSData *);
ListenerBlock15 wrapListenerBlock_ObjCBlock_ffiVoid_NSData(ListenerBlock15 block)
    NS_RETURNS_RETAINED {
  return ^void(NSData *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock16)(NSData *, BOOL, NSError *);
ListenerBlock16 wrapListenerBlock_ObjCBlock_ffiVoid_NSData_bool_NSError(ListenerBlock16 block)
    NS_RETURNS_RETAINED {
  return ^void(NSData *arg0, BOOL arg1, NSError *arg2) {
    block(objc_retain(arg0), arg1, objc_retain(arg2));
  };
}

typedef void (^ListenerBlock17)(NSURLSessionWebSocketMessage *, NSError *);
ListenerBlock17 wrapListenerBlock_ObjCBlock_ffiVoid_NSURLSessionWebSocketMessage_NSError(
    ListenerBlock17 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionWebSocketMessage *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock18)(NSData *, NSURLResponse *, NSError *);
ListenerBlock18 wrapListenerBlock_ObjCBlock_ffiVoid_NSData_NSURLResponse_NSError(
    ListenerBlock18 block) NS_RETURNS_RETAINED {
  return ^void(NSData *arg0, NSURLResponse *arg1, NSError *arg2) {
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

typedef void (^ListenerBlock19)(NSURL *, NSURLResponse *, NSError *);
ListenerBlock19 wrapListenerBlock_ObjCBlock_ffiVoid_NSURL_NSURLResponse_NSError(
    ListenerBlock19 block) NS_RETURNS_RETAINED {
  return ^void(NSURL *arg0, NSURLResponse *arg1, NSError *arg2) {
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

#if TARGET_OS_OSX
typedef void (^ListenerBlock20)(NSTask *);
ListenerBlock20 wrapListenerBlock_ObjCBlock_ffiVoid_NSTask(ListenerBlock20 block)
    NS_RETURNS_RETAINED {
  return ^void(NSTask *arg0) {
    block(objc_retain(arg0));
  };
}
#endif

typedef void (^ListenerBlock21)(NSData *, NSError *);
ListenerBlock21 wrapListenerBlock_ObjCBlock_ffiVoid_NSData_NSError(ListenerBlock21 block)
    NS_RETURNS_RETAINED {
  return ^void(NSData *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock22)(AVAssetTrackSegment *, NSError *);
ListenerBlock22 wrapListenerBlock_ObjCBlock_ffiVoid_AVAssetTrackSegment_NSError(
    ListenerBlock22 block) NS_RETURNS_RETAINED {
  return ^void(AVAssetTrackSegment *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock23)(CMTime, NSError *);
ListenerBlock23 wrapListenerBlock_ObjCBlock_ffiVoid_CMTime_NSError(ListenerBlock23 block)
    NS_RETURNS_RETAINED {
  return ^void(CMTime arg0, NSError *arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^ListenerBlock24)(NSArray *, NSError *);
ListenerBlock24 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray_NSError(ListenerBlock24 block)
    NS_RETURNS_RETAINED {
  return ^void(NSArray *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock25)(AVAssetTrack *, NSError *);
ListenerBlock25 wrapListenerBlock_ObjCBlock_ffiVoid_AVAssetTrack_NSError(ListenerBlock25 block)
    NS_RETURNS_RETAINED {
  return ^void(AVAssetTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock26)(AVMetadataItemValueRequest *);
ListenerBlock26 wrapListenerBlock_ObjCBlock_ffiVoid_AVMetadataItemValueRequest(
    ListenerBlock26 block) NS_RETURNS_RETAINED {
  return ^void(AVMetadataItemValueRequest *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock27)(AVMediaSelectionGroup *, NSError *);
ListenerBlock27 wrapListenerBlock_ObjCBlock_ffiVoid_AVMediaSelectionGroup_NSError(
    ListenerBlock27 block) NS_RETURNS_RETAINED {
  return ^void(AVMediaSelectionGroup *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock28)(int32_t, NSError *);
ListenerBlock28 wrapListenerBlock_ObjCBlock_ffiVoid_Int32_NSError(ListenerBlock28 block)
    NS_RETURNS_RETAINED {
  return ^void(int32_t arg0, NSError *arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^ListenerBlock29)(AVFragmentedAssetTrack *, NSError *);
ListenerBlock29 wrapListenerBlock_ObjCBlock_ffiVoid_AVFragmentedAssetTrack_NSError(
    ListenerBlock29 block) NS_RETURNS_RETAINED {
  return ^void(AVFragmentedAssetTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock30)(int64_t, NSError *);
ListenerBlock30 wrapListenerBlock_ObjCBlock_ffiVoid_Int64_NSError(ListenerBlock30 block)
    NS_RETURNS_RETAINED {
  return ^void(int64_t arg0, NSError *arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^ListenerBlock31)(AVVideoComposition *, NSError *);
ListenerBlock31 wrapListenerBlock_ObjCBlock_ffiVoid_AVVideoComposition_NSError(
    ListenerBlock31 block) NS_RETURNS_RETAINED {
  return ^void(AVVideoComposition *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock32)(AVAsynchronousCIImageFilteringRequest *);
ListenerBlock32 wrapListenerBlock_ObjCBlock_ffiVoid_AVAsynchronousCIImageFilteringRequest(
    ListenerBlock32 block) NS_RETURNS_RETAINED {
  return ^void(AVAsynchronousCIImageFilteringRequest *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock33)(BOOL, NSError *);
ListenerBlock33 wrapListenerBlock_ObjCBlock_ffiVoid_bool_NSError(ListenerBlock33 block)
    NS_RETURNS_RETAINED {
  return ^void(BOOL arg0, NSError *arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^ListenerBlock34)(AVMutableVideoComposition *, NSError *);
ListenerBlock34 wrapListenerBlock_ObjCBlock_ffiVoid_AVMutableVideoComposition_NSError(
    ListenerBlock34 block) NS_RETURNS_RETAINED {
  return ^void(AVMutableVideoComposition *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock35)(AUAudioUnit *, NSError *);
ListenerBlock35 wrapListenerBlock_ObjCBlock_ffiVoid_AUAudioUnit_NSError(ListenerBlock35 block)
    NS_RETURNS_RETAINED {
  return ^void(AUAudioUnit *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock36)(AUParameter *, float);
ListenerBlock36 wrapListenerBlock_ObjCBlock_ffiVoid_AUParameter_ffiFloat(ListenerBlock36 block)
    NS_RETURNS_RETAINED {
  return ^void(AUParameter *arg0, float arg1) {
    block(objc_retain(arg0), arg1);
  };
}

typedef void (^ListenerBlock37)(uint8_t, uint8_t, MIDICIProfile *, BOOL);
ListenerBlock37 wrapListenerBlock_ObjCBlock_ffiVoid_Uint8_Uint8_MIDICIProfile_bool(
    ListenerBlock37 block) NS_RETURNS_RETAINED {
  return ^void(uint8_t arg0, uint8_t arg1, MIDICIProfile *arg2, BOOL arg3) {
    block(arg0, arg1, objc_retain(arg2), arg3);
  };
}

typedef void (^ListenerBlock38)(NSInputStream *, NSOutputStream *, NSError *);
ListenerBlock38 wrapListenerBlock_ObjCBlock_ffiVoid_NSInputStream_NSOutputStream_NSError(
    ListenerBlock38 block) NS_RETURNS_RETAINED {
  return ^void(NSInputStream *arg0, NSOutputStream *arg1, NSError *arg2) {
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

typedef void (^ListenerBlock39)(AVCompositionTrack *, NSError *);
ListenerBlock39 wrapListenerBlock_ObjCBlock_ffiVoid_AVCompositionTrack_NSError(
    ListenerBlock39 block) NS_RETURNS_RETAINED {
  return ^void(AVCompositionTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock40)(AVMutableCompositionTrack *, NSError *);
ListenerBlock40 wrapListenerBlock_ObjCBlock_ffiVoid_AVMutableCompositionTrack_NSError(
    ListenerBlock40 block) NS_RETURNS_RETAINED {
  return ^void(AVMutableCompositionTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock41)(AVMovieTrack *, NSError *);
ListenerBlock41 wrapListenerBlock_ObjCBlock_ffiVoid_AVMovieTrack_NSError(ListenerBlock41 block)
    NS_RETURNS_RETAINED {
  return ^void(AVMovieTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock42)(AVMutableMovieTrack *, NSError *);
ListenerBlock42 wrapListenerBlock_ObjCBlock_ffiVoid_AVMutableMovieTrack_NSError(
    ListenerBlock42 block) NS_RETURNS_RETAINED {
  return ^void(AVMutableMovieTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock43)(AVFragmentedMovieTrack *, NSError *);
ListenerBlock43 wrapListenerBlock_ObjCBlock_ffiVoid_AVFragmentedMovieTrack_NSError(
    ListenerBlock43 block) NS_RETURNS_RETAINED {
  return ^void(AVFragmentedMovieTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock44)(AVAudioPCMBuffer *, AVAudioTime *);
ListenerBlock44 wrapListenerBlock_ObjCBlock_ffiVoid_AVAudioPCMBuffer_AVAudioTime(
    ListenerBlock44 block) NS_RETURNS_RETAINED {
  return ^void(AVAudioPCMBuffer *arg0, AVAudioTime *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock45)(AVAudioUnit *, NSError *);
ListenerBlock45 wrapListenerBlock_ObjCBlock_ffiVoid_AVAudioUnit_NSError(ListenerBlock45 block)
    NS_RETURNS_RETAINED {
  return ^void(AVAudioUnit *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock46)(AVMusicEvent *, double *, BOOL *);
ListenerBlock46 wrapListenerBlock_ObjCBlock_ffiVoid_AVMusicEvent_ffiDouble_bool(
    ListenerBlock46 block) NS_RETURNS_RETAINED {
  return ^void(AVMusicEvent *arg0, double *arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void (^ListenerBlock47)(AVMusicTrack *, NSData *, double);
ListenerBlock47 wrapListenerBlock_ObjCBlock_ffiVoid_AVMusicTrack_NSData_ffiDouble(
    ListenerBlock47 block) NS_RETURNS_RETAINED {
  return ^void(AVMusicTrack *arg0, NSData *arg1, double arg2) {
    block(objc_retain(arg0), objc_retain(arg1), arg2);
  };
}

typedef void (^ListenerBlock48)(struct opaqueCMSampleBuffer *, NSError *);
ListenerBlock48 wrapListenerBlock_ObjCBlock_ffiVoid_opaqueCMSampleBuffer_NSError(
    ListenerBlock48 block) NS_RETURNS_RETAINED {
  return ^void(struct opaqueCMSampleBuffer *arg0, NSError *arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^ListenerBlock49)(struct opaqueCMSampleBuffer *,
                                AVCaptureBracketedStillImageSettings *, NSError *);
ListenerBlock49
wrapListenerBlock_ObjCBlock_ffiVoid_opaqueCMSampleBuffer_AVCaptureBracketedStillImageSettings_NSError(
    ListenerBlock49 block) NS_RETURNS_RETAINED {
  return ^void(struct opaqueCMSampleBuffer *arg0, AVCaptureBracketedStillImageSettings *arg1,
               NSError *arg2) {
    block(arg0, objc_retain(arg1), objc_retain(arg2));
  };
}

typedef void (^ListenerBlock50)(AVPlayerItem *, FVPItemProperty);
ListenerBlock50 wrapListenerBlock_ObjCBlock_ffiVoid_AVPlayerItem_FVPItemProperty(
    ListenerBlock50 block) NS_RETURNS_RETAINED {
  return ^void(AVPlayerItem *arg0, FVPItemProperty arg1) {
    block(objc_retain(arg0), arg1);
  };
}
