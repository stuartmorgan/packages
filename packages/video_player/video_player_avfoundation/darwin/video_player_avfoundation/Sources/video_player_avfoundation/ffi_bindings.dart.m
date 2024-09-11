#include <stdint.h>
#import "include/video_player_avfoundation/FFIHeaders.h"
#import "include/video_player_avfoundation/FVPBlockKeyValueObserver.h"
#import "include/video_player_avfoundation/FVPDisplayLink.h"
#import "include/video_player_avfoundation/FVPFrameUpdater.h"
#import "include/video_player_avfoundation/FVPVideoPlayer.h"

#if !__has_feature(objc_arc)
#error "This file must be compiled with ARC enabled"
#endif

id objc_retain(id);
id objc_retainBlock(id);

typedef void (^ListenerBlock)(NSNotification *);
ListenerBlock wrapListenerBlock_ObjCBlock_ffiVoid_NSNotification(ListenerBlock block)
    NS_RETURNS_RETAINED {
  return ^void(NSNotification *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock1)(NSDictionary *, struct _NSRange, BOOL *);
ListenerBlock1 wrapListenerBlock_ObjCBlock_ffiVoid_NSDictionary_NSRange_bool(ListenerBlock1 block)
    NS_RETURNS_RETAINED {
  return ^void(NSDictionary *arg0, struct _NSRange arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void (^ListenerBlock2)(id, struct _NSRange, BOOL *);
ListenerBlock2 wrapListenerBlock_ObjCBlock_ffiVoid_objcObjCObject_NSRange_bool(ListenerBlock2 block)
    NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void (^ListenerBlock3)(NSDate *, BOOL, BOOL *);
ListenerBlock3 wrapListenerBlock_ObjCBlock_ffiVoid_NSDate_bool_bool(ListenerBlock3 block)
    NS_RETURNS_RETAINED {
  return ^void(NSDate *arg0, BOOL arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void (^ListenerBlock4)(NSTimer *);
ListenerBlock4 wrapListenerBlock_ObjCBlock_ffiVoid_NSTimer(ListenerBlock4 block)
    NS_RETURNS_RETAINED {
  return ^void(NSTimer *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock5)(NSFileHandle *);
ListenerBlock5 wrapListenerBlock_ObjCBlock_ffiVoid_NSFileHandle(ListenerBlock5 block)
    NS_RETURNS_RETAINED {
  return ^void(NSFileHandle *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock6)(NSError *);
ListenerBlock6 wrapListenerBlock_ObjCBlock_ffiVoid_NSError(ListenerBlock6 block)
    NS_RETURNS_RETAINED {
  return ^void(NSError *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock7)(NSDictionary *, NSError *);
ListenerBlock7 wrapListenerBlock_ObjCBlock_ffiVoid_NSDictionary_NSError(ListenerBlock7 block)
    NS_RETURNS_RETAINED {
  return ^void(NSDictionary *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock8)(NSArray *);
ListenerBlock8 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray(ListenerBlock8 block)
    NS_RETURNS_RETAINED {
  return ^void(NSArray *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock9)(NSTextCheckingResult *, NSMatchingFlags, BOOL *);
ListenerBlock9 wrapListenerBlock_ObjCBlock_ffiVoid_NSTextCheckingResult_NSMatchingFlags_bool(
    ListenerBlock9 block) NS_RETURNS_RETAINED {
  return ^void(NSTextCheckingResult *arg0, NSMatchingFlags arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void (^ListenerBlock10)(NSCachedURLResponse *);
ListenerBlock10 wrapListenerBlock_ObjCBlock_ffiVoid_NSCachedURLResponse(ListenerBlock10 block)
    NS_RETURNS_RETAINED {
  return ^void(NSCachedURLResponse *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock11)(NSURLResponse *, NSData *, NSError *);
ListenerBlock11 wrapListenerBlock_ObjCBlock_ffiVoid_NSURLResponse_NSData_NSError(
    ListenerBlock11 block) NS_RETURNS_RETAINED {
  return ^void(NSURLResponse *arg0, NSData *arg1, NSError *arg2) {
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

typedef void (^ListenerBlock12)(NSDictionary *);
ListenerBlock12 wrapListenerBlock_ObjCBlock_ffiVoid_NSDictionary(ListenerBlock12 block)
    NS_RETURNS_RETAINED {
  return ^void(NSDictionary *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock13)(NSURLCredential *);
ListenerBlock13 wrapListenerBlock_ObjCBlock_ffiVoid_NSURLCredential(ListenerBlock13 block)
    NS_RETURNS_RETAINED {
  return ^void(NSURLCredential *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock14)(NSArray *, NSArray *, NSArray *);
ListenerBlock14 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray_NSArray_NSArray(ListenerBlock14 block)
    NS_RETURNS_RETAINED {
  return ^void(NSArray *arg0, NSArray *arg1, NSArray *arg2) {
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

typedef void (^ListenerBlock15)(NSArray *);
ListenerBlock15 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray1(ListenerBlock15 block)
    NS_RETURNS_RETAINED {
  return ^void(NSArray *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock16)(NSData *);
ListenerBlock16 wrapListenerBlock_ObjCBlock_ffiVoid_NSData(ListenerBlock16 block)
    NS_RETURNS_RETAINED {
  return ^void(NSData *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock17)(NSData *, BOOL, NSError *);
ListenerBlock17 wrapListenerBlock_ObjCBlock_ffiVoid_NSData_bool_NSError(ListenerBlock17 block)
    NS_RETURNS_RETAINED {
  return ^void(NSData *arg0, BOOL arg1, NSError *arg2) {
    block(objc_retain(arg0), arg1, objc_retain(arg2));
  };
}

typedef void (^ListenerBlock18)(NSURLSessionWebSocketMessage *, NSError *);
ListenerBlock18 wrapListenerBlock_ObjCBlock_ffiVoid_NSURLSessionWebSocketMessage_NSError(
    ListenerBlock18 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionWebSocketMessage *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock19)(NSData *, NSURLResponse *, NSError *);
ListenerBlock19 wrapListenerBlock_ObjCBlock_ffiVoid_NSData_NSURLResponse_NSError(
    ListenerBlock19 block) NS_RETURNS_RETAINED {
  return ^void(NSData *arg0, NSURLResponse *arg1, NSError *arg2) {
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

typedef void (^ListenerBlock20)(NSURL *, NSURLResponse *, NSError *);
ListenerBlock20 wrapListenerBlock_ObjCBlock_ffiVoid_NSURL_NSURLResponse_NSError(
    ListenerBlock20 block) NS_RETURNS_RETAINED {
  return ^void(NSURL *arg0, NSURLResponse *arg1, NSError *arg2) {
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

#if TARGET_OS_OSX
typedef void (^ListenerBlock21)(NSTask *);
ListenerBlock21 wrapListenerBlock_ObjCBlock_ffiVoid_NSTask(ListenerBlock21 block)
    NS_RETURNS_RETAINED {
  return ^void(NSTask *arg0) {
    block(objc_retain(arg0));
  };
}
#endif

typedef void (^ListenerBlock22)(NSData *, NSError *);
ListenerBlock22 wrapListenerBlock_ObjCBlock_ffiVoid_NSData_NSError(ListenerBlock22 block)
    NS_RETURNS_RETAINED {
  return ^void(NSData *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock23)(AVAssetTrackSegment *, NSError *);
ListenerBlock23 wrapListenerBlock_ObjCBlock_ffiVoid_AVAssetTrackSegment_NSError(
    ListenerBlock23 block) NS_RETURNS_RETAINED {
  return ^void(AVAssetTrackSegment *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock24)(CMTime, NSError *);
ListenerBlock24 wrapListenerBlock_ObjCBlock_ffiVoid_CMTime_NSError(ListenerBlock24 block)
    NS_RETURNS_RETAINED {
  return ^void(CMTime arg0, NSError *arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^ListenerBlock25)(NSArray *, NSError *);
ListenerBlock25 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray_NSError(ListenerBlock25 block)
    NS_RETURNS_RETAINED {
  return ^void(NSArray *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock26)(AVAssetTrack *, NSError *);
ListenerBlock26 wrapListenerBlock_ObjCBlock_ffiVoid_AVAssetTrack_NSError(ListenerBlock26 block)
    NS_RETURNS_RETAINED {
  return ^void(AVAssetTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock27)(AVMetadataItemValueRequest *);
ListenerBlock27 wrapListenerBlock_ObjCBlock_ffiVoid_AVMetadataItemValueRequest(
    ListenerBlock27 block) NS_RETURNS_RETAINED {
  return ^void(AVMetadataItemValueRequest *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock28)(AVMediaSelectionGroup *, NSError *);
ListenerBlock28 wrapListenerBlock_ObjCBlock_ffiVoid_AVMediaSelectionGroup_NSError(
    ListenerBlock28 block) NS_RETURNS_RETAINED {
  return ^void(AVMediaSelectionGroup *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock29)(int32_t, NSError *);
ListenerBlock29 wrapListenerBlock_ObjCBlock_ffiVoid_Int32_NSError(ListenerBlock29 block)
    NS_RETURNS_RETAINED {
  return ^void(int32_t arg0, NSError *arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^ListenerBlock30)(AVFragmentedAssetTrack *, NSError *);
ListenerBlock30 wrapListenerBlock_ObjCBlock_ffiVoid_AVFragmentedAssetTrack_NSError(
    ListenerBlock30 block) NS_RETURNS_RETAINED {
  return ^void(AVFragmentedAssetTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock31)(int64_t, NSError *);
ListenerBlock31 wrapListenerBlock_ObjCBlock_ffiVoid_Int64_NSError(ListenerBlock31 block)
    NS_RETURNS_RETAINED {
  return ^void(int64_t arg0, NSError *arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^ListenerBlock32)(AVVideoComposition *, NSError *);
ListenerBlock32 wrapListenerBlock_ObjCBlock_ffiVoid_AVVideoComposition_NSError(
    ListenerBlock32 block) NS_RETURNS_RETAINED {
  return ^void(AVVideoComposition *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock33)(AVAsynchronousCIImageFilteringRequest *);
ListenerBlock33 wrapListenerBlock_ObjCBlock_ffiVoid_AVAsynchronousCIImageFilteringRequest(
    ListenerBlock33 block) NS_RETURNS_RETAINED {
  return ^void(AVAsynchronousCIImageFilteringRequest *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock34)(BOOL, NSError *);
ListenerBlock34 wrapListenerBlock_ObjCBlock_ffiVoid_bool_NSError(ListenerBlock34 block)
    NS_RETURNS_RETAINED {
  return ^void(BOOL arg0, NSError *arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^ListenerBlock35)(AVMutableVideoComposition *, NSError *);
ListenerBlock35 wrapListenerBlock_ObjCBlock_ffiVoid_AVMutableVideoComposition_NSError(
    ListenerBlock35 block) NS_RETURNS_RETAINED {
  return ^void(AVMutableVideoComposition *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock36)(AUAudioUnit *, NSError *);
ListenerBlock36 wrapListenerBlock_ObjCBlock_ffiVoid_AUAudioUnit_NSError(ListenerBlock36 block)
    NS_RETURNS_RETAINED {
  return ^void(AUAudioUnit *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock37)(AUParameter *, float);
ListenerBlock37 wrapListenerBlock_ObjCBlock_ffiVoid_AUParameter_ffiFloat(ListenerBlock37 block)
    NS_RETURNS_RETAINED {
  return ^void(AUParameter *arg0, float arg1) {
    block(objc_retain(arg0), arg1);
  };
}

typedef void (^ListenerBlock38)(uint8_t, uint8_t, MIDICIProfile *, BOOL);
ListenerBlock38 wrapListenerBlock_ObjCBlock_ffiVoid_Uint8_Uint8_MIDICIProfile_bool(
    ListenerBlock38 block) NS_RETURNS_RETAINED {
  return ^void(uint8_t arg0, uint8_t arg1, MIDICIProfile *arg2, BOOL arg3) {
    block(arg0, arg1, objc_retain(arg2), arg3);
  };
}

typedef void (^ListenerBlock39)(NSInputStream *, NSOutputStream *, NSError *);
ListenerBlock39 wrapListenerBlock_ObjCBlock_ffiVoid_NSInputStream_NSOutputStream_NSError(
    ListenerBlock39 block) NS_RETURNS_RETAINED {
  return ^void(NSInputStream *arg0, NSOutputStream *arg1, NSError *arg2) {
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

typedef void (^ListenerBlock40)(AVCompositionTrack *, NSError *);
ListenerBlock40 wrapListenerBlock_ObjCBlock_ffiVoid_AVCompositionTrack_NSError(
    ListenerBlock40 block) NS_RETURNS_RETAINED {
  return ^void(AVCompositionTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock41)(AVMutableCompositionTrack *, NSError *);
ListenerBlock41 wrapListenerBlock_ObjCBlock_ffiVoid_AVMutableCompositionTrack_NSError(
    ListenerBlock41 block) NS_RETURNS_RETAINED {
  return ^void(AVMutableCompositionTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock42)(AVMovieTrack *, NSError *);
ListenerBlock42 wrapListenerBlock_ObjCBlock_ffiVoid_AVMovieTrack_NSError(ListenerBlock42 block)
    NS_RETURNS_RETAINED {
  return ^void(AVMovieTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock43)(AVMutableMovieTrack *, NSError *);
ListenerBlock43 wrapListenerBlock_ObjCBlock_ffiVoid_AVMutableMovieTrack_NSError(
    ListenerBlock43 block) NS_RETURNS_RETAINED {
  return ^void(AVMutableMovieTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock44)(AVFragmentedMovieTrack *, NSError *);
ListenerBlock44 wrapListenerBlock_ObjCBlock_ffiVoid_AVFragmentedMovieTrack_NSError(
    ListenerBlock44 block) NS_RETURNS_RETAINED {
  return ^void(AVFragmentedMovieTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock45)(AVAudioPCMBuffer *, AVAudioTime *);
ListenerBlock45 wrapListenerBlock_ObjCBlock_ffiVoid_AVAudioPCMBuffer_AVAudioTime(
    ListenerBlock45 block) NS_RETURNS_RETAINED {
  return ^void(AVAudioPCMBuffer *arg0, AVAudioTime *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock46)(AVAudioUnit *, NSError *);
ListenerBlock46 wrapListenerBlock_ObjCBlock_ffiVoid_AVAudioUnit_NSError(ListenerBlock46 block)
    NS_RETURNS_RETAINED {
  return ^void(AVAudioUnit *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock47)(AVMusicEvent *, double *, BOOL *);
ListenerBlock47 wrapListenerBlock_ObjCBlock_ffiVoid_AVMusicEvent_ffiDouble_bool(
    ListenerBlock47 block) NS_RETURNS_RETAINED {
  return ^void(AVMusicEvent *arg0, double *arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void (^ListenerBlock48)(AVMusicTrack *, NSData *, double);
ListenerBlock48 wrapListenerBlock_ObjCBlock_ffiVoid_AVMusicTrack_NSData_ffiDouble(
    ListenerBlock48 block) NS_RETURNS_RETAINED {
  return ^void(AVMusicTrack *arg0, NSData *arg1, double arg2) {
    block(objc_retain(arg0), objc_retain(arg1), arg2);
  };
}

typedef void (^ListenerBlock49)(struct opaqueCMSampleBuffer *, NSError *);
ListenerBlock49 wrapListenerBlock_ObjCBlock_ffiVoid_opaqueCMSampleBuffer_NSError(
    ListenerBlock49 block) NS_RETURNS_RETAINED {
  return ^void(struct opaqueCMSampleBuffer *arg0, NSError *arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^ListenerBlock50)(struct opaqueCMSampleBuffer *,
                                AVCaptureBracketedStillImageSettings *, NSError *);
ListenerBlock50
wrapListenerBlock_ObjCBlock_ffiVoid_opaqueCMSampleBuffer_AVCaptureBracketedStillImageSettings_NSError(
    ListenerBlock50 block) NS_RETURNS_RETAINED {
  return ^void(struct opaqueCMSampleBuffer *arg0, AVCaptureBracketedStillImageSettings *arg1,
               NSError *arg2) {
    block(arg0, objc_retain(arg1), objc_retain(arg2));
  };
}

typedef void (^ListenerBlock51)(id, NSString *);
ListenerBlock51 wrapListenerBlock_ObjCBlock_ffiVoid_objcObjCObject_NSString(ListenerBlock51 block)
    NS_RETURNS_RETAINED {
  return ^void(id arg0, NSString *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}
