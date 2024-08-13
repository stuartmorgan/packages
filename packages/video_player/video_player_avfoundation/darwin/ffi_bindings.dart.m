#include <stdint.h>

#import <AVFoundation/AVFoundation.h>#import "../video_player_avfoundation/include/video_player_avfoundation/FVPVideoPlayer.h"

typedef void (^ListenerBlock)(NSDictionary *, struct _NSRange, BOOL *);
ListenerBlock wrapListenerBlock_ObjCBlock_ffiVoid_NSDictionary_NSRange_bool(ListenerBlock block) {
  ListenerBlock wrapper = [^void(NSDictionary *arg0, struct _NSRange arg1, BOOL *arg2) {
    block([arg0 retain], arg1, arg2);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock1)(id, struct _NSRange, BOOL *);
ListenerBlock1 wrapListenerBlock_ObjCBlock_ffiVoid_objcObjCObject_NSRange_bool(
    ListenerBlock1 block) {
  ListenerBlock1 wrapper = [^void(id arg0, struct _NSRange arg1, BOOL *arg2) {
    block([arg0 retain], arg1, arg2);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock2)(NSDate *, BOOL, BOOL *);
ListenerBlock2 wrapListenerBlock_ObjCBlock_ffiVoid_NSDate_bool_bool(ListenerBlock2 block) {
  ListenerBlock2 wrapper = [^void(NSDate *arg0, BOOL arg1, BOOL *arg2) {
    block([arg0 retain], arg1, arg2);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock3)(NSTimer *);
ListenerBlock3 wrapListenerBlock_ObjCBlock_ffiVoid_NSTimer(ListenerBlock3 block) {
  ListenerBlock3 wrapper = [^void(NSTimer *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock4)(NSFileHandle *);
ListenerBlock4 wrapListenerBlock_ObjCBlock_ffiVoid_NSFileHandle(ListenerBlock4 block) {
  ListenerBlock4 wrapper = [^void(NSFileHandle *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock5)(NSError *);
ListenerBlock5 wrapListenerBlock_ObjCBlock_ffiVoid_NSError(ListenerBlock5 block) {
  ListenerBlock5 wrapper = [^void(NSError *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock6)(NSDictionary *, NSError *);
ListenerBlock6 wrapListenerBlock_ObjCBlock_ffiVoid_NSDictionary_NSError(ListenerBlock6 block) {
  ListenerBlock6 wrapper = [^void(NSDictionary *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock7)(NSArray *);
ListenerBlock7 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray(ListenerBlock7 block) {
  ListenerBlock7 wrapper = [^void(NSArray *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock8)(NSTextCheckingResult *, NSMatchingFlags, BOOL *);
ListenerBlock8 wrapListenerBlock_ObjCBlock_ffiVoid_NSTextCheckingResult_NSMatchingFlags_bool(
    ListenerBlock8 block) {
  ListenerBlock8 wrapper = [^void(NSTextCheckingResult *arg0, NSMatchingFlags arg1, BOOL *arg2) {
    block([arg0 retain], arg1, arg2);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock9)(NSCachedURLResponse *);
ListenerBlock9 wrapListenerBlock_ObjCBlock_ffiVoid_NSCachedURLResponse(ListenerBlock9 block) {
  ListenerBlock9 wrapper = [^void(NSCachedURLResponse *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock10)(NSURLResponse *, NSData *, NSError *);
ListenerBlock10 wrapListenerBlock_ObjCBlock_ffiVoid_NSURLResponse_NSData_NSError(
    ListenerBlock10 block) {
  ListenerBlock10 wrapper = [^void(NSURLResponse *arg0, NSData *arg1, NSError *arg2) {
    block([arg0 retain], [arg1 retain], [arg2 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock11)(NSDictionary *);
ListenerBlock11 wrapListenerBlock_ObjCBlock_ffiVoid_NSDictionary(ListenerBlock11 block) {
  ListenerBlock11 wrapper = [^void(NSDictionary *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock12)(NSURLCredential *);
ListenerBlock12 wrapListenerBlock_ObjCBlock_ffiVoid_NSURLCredential(ListenerBlock12 block) {
  ListenerBlock12 wrapper = [^void(NSURLCredential *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock13)(NSArray *, NSArray *, NSArray *);
ListenerBlock13 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray_NSArray_NSArray(ListenerBlock13 block) {
  ListenerBlock13 wrapper = [^void(NSArray *arg0, NSArray *arg1, NSArray *arg2) {
    block([arg0 retain], [arg1 retain], [arg2 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock14)(NSArray *);
ListenerBlock14 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray1(ListenerBlock14 block) {
  ListenerBlock14 wrapper = [^void(NSArray *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock15)(NSData *);
ListenerBlock15 wrapListenerBlock_ObjCBlock_ffiVoid_NSData(ListenerBlock15 block) {
  ListenerBlock15 wrapper = [^void(NSData *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock16)(NSData *, BOOL, NSError *);
ListenerBlock16 wrapListenerBlock_ObjCBlock_ffiVoid_NSData_bool_NSError(ListenerBlock16 block) {
  ListenerBlock16 wrapper = [^void(NSData *arg0, BOOL arg1, NSError *arg2) {
    block([arg0 retain], arg1, [arg2 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock17)(NSURLSessionWebSocketMessage *, NSError *);
ListenerBlock17 wrapListenerBlock_ObjCBlock_ffiVoid_NSURLSessionWebSocketMessage_NSError(
    ListenerBlock17 block) {
  ListenerBlock17 wrapper = [^void(NSURLSessionWebSocketMessage *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock18)(NSData *, NSURLResponse *, NSError *);
ListenerBlock18 wrapListenerBlock_ObjCBlock_ffiVoid_NSData_NSURLResponse_NSError(
    ListenerBlock18 block) {
  ListenerBlock18 wrapper = [^void(NSData *arg0, NSURLResponse *arg1, NSError *arg2) {
    block([arg0 retain], [arg1 retain], [arg2 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock19)(NSURL *, NSURLResponse *, NSError *);
ListenerBlock19 wrapListenerBlock_ObjCBlock_ffiVoid_NSURL_NSURLResponse_NSError(
    ListenerBlock19 block) {
  ListenerBlock19 wrapper = [^void(NSURL *arg0, NSURLResponse *arg1, NSError *arg2) {
    block([arg0 retain], [arg1 retain], [arg2 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock20)(NSTask *);
ListenerBlock20 wrapListenerBlock_ObjCBlock_ffiVoid_NSTask(ListenerBlock20 block) {
  ListenerBlock20 wrapper = [^void(NSTask *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock21)(NSData *, NSError *);
ListenerBlock21 wrapListenerBlock_ObjCBlock_ffiVoid_NSData_NSError(ListenerBlock21 block) {
  ListenerBlock21 wrapper = [^void(NSData *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock22)(AVAssetTrackSegment *, NSError *);
ListenerBlock22 wrapListenerBlock_ObjCBlock_ffiVoid_AVAssetTrackSegment_NSError(
    ListenerBlock22 block) {
  ListenerBlock22 wrapper = [^void(AVAssetTrackSegment *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock23)(CMTime, NSError *);
ListenerBlock23 wrapListenerBlock_ObjCBlock_ffiVoid_CMTime_NSError(ListenerBlock23 block) {
  ListenerBlock23 wrapper = [^void(CMTime arg0, NSError *arg1) {
    block(arg0, [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock24)(NSArray *, NSError *);
ListenerBlock24 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray_NSError(ListenerBlock24 block) {
  ListenerBlock24 wrapper = [^void(NSArray *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock25)(AVAssetTrack *, NSError *);
ListenerBlock25 wrapListenerBlock_ObjCBlock_ffiVoid_AVAssetTrack_NSError(ListenerBlock25 block) {
  ListenerBlock25 wrapper = [^void(AVAssetTrack *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock26)(AVMetadataItemValueRequest *);
ListenerBlock26 wrapListenerBlock_ObjCBlock_ffiVoid_AVMetadataItemValueRequest(
    ListenerBlock26 block) {
  ListenerBlock26 wrapper = [^void(AVMetadataItemValueRequest *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock27)(AVMediaSelectionGroup *, NSError *);
ListenerBlock27 wrapListenerBlock_ObjCBlock_ffiVoid_AVMediaSelectionGroup_NSError(
    ListenerBlock27 block) {
  ListenerBlock27 wrapper = [^void(AVMediaSelectionGroup *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock28)(int32_t, NSError *);
ListenerBlock28 wrapListenerBlock_ObjCBlock_ffiVoid_Int32_NSError(ListenerBlock28 block) {
  ListenerBlock28 wrapper = [^void(int32_t arg0, NSError *arg1) {
    block(arg0, [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock29)(AVFragmentedAssetTrack *, NSError *);
ListenerBlock29 wrapListenerBlock_ObjCBlock_ffiVoid_AVFragmentedAssetTrack_NSError(
    ListenerBlock29 block) {
  ListenerBlock29 wrapper = [^void(AVFragmentedAssetTrack *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock30)(int64_t, NSError *);
ListenerBlock30 wrapListenerBlock_ObjCBlock_ffiVoid_Int64_NSError(ListenerBlock30 block) {
  ListenerBlock30 wrapper = [^void(int64_t arg0, NSError *arg1) {
    block(arg0, [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock31)(AVVideoComposition *, NSError *);
ListenerBlock31 wrapListenerBlock_ObjCBlock_ffiVoid_AVVideoComposition_NSError(
    ListenerBlock31 block) {
  ListenerBlock31 wrapper = [^void(AVVideoComposition *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock32)(AVAsynchronousCIImageFilteringRequest *);
ListenerBlock32 wrapListenerBlock_ObjCBlock_ffiVoid_AVAsynchronousCIImageFilteringRequest(
    ListenerBlock32 block) {
  ListenerBlock32 wrapper = [^void(AVAsynchronousCIImageFilteringRequest *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock33)(BOOL, NSError *);
ListenerBlock33 wrapListenerBlock_ObjCBlock_ffiVoid_bool_NSError(ListenerBlock33 block) {
  ListenerBlock33 wrapper = [^void(BOOL arg0, NSError *arg1) {
    block(arg0, [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock34)(AVMutableVideoComposition *, NSError *);
ListenerBlock34 wrapListenerBlock_ObjCBlock_ffiVoid_AVMutableVideoComposition_NSError(
    ListenerBlock34 block) {
  ListenerBlock34 wrapper = [^void(AVMutableVideoComposition *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock35)(AUAudioUnit *, NSError *);
ListenerBlock35 wrapListenerBlock_ObjCBlock_ffiVoid_AUAudioUnit_NSError(ListenerBlock35 block) {
  ListenerBlock35 wrapper = [^void(AUAudioUnit *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock36)(AUParameter *, float);
ListenerBlock36 wrapListenerBlock_ObjCBlock_ffiVoid_AUParameter_ffiFloat(ListenerBlock36 block) {
  ListenerBlock36 wrapper = [^void(AUParameter *arg0, float arg1) {
    block([arg0 retain], arg1);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock37)(uint8_t, uint8_t, MIDICIProfile *, BOOL);
ListenerBlock37 wrapListenerBlock_ObjCBlock_ffiVoid_Uint8_Uint8_MIDICIProfile_bool(
    ListenerBlock37 block) {
  ListenerBlock37 wrapper = [^void(uint8_t arg0, uint8_t arg1, MIDICIProfile *arg2, BOOL arg3) {
    block(arg0, arg1, [arg2 retain], arg3);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock38)(NSInputStream *, NSOutputStream *, NSError *);
ListenerBlock38 wrapListenerBlock_ObjCBlock_ffiVoid_NSInputStream_NSOutputStream_NSError(
    ListenerBlock38 block) {
  ListenerBlock38 wrapper = [^void(NSInputStream *arg0, NSOutputStream *arg1, NSError *arg2) {
    block([arg0 retain], [arg1 retain], [arg2 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock39)(AVCompositionTrack *, NSError *);
ListenerBlock39 wrapListenerBlock_ObjCBlock_ffiVoid_AVCompositionTrack_NSError(
    ListenerBlock39 block) {
  ListenerBlock39 wrapper = [^void(AVCompositionTrack *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock40)(AVMutableCompositionTrack *, NSError *);
ListenerBlock40 wrapListenerBlock_ObjCBlock_ffiVoid_AVMutableCompositionTrack_NSError(
    ListenerBlock40 block) {
  ListenerBlock40 wrapper = [^void(AVMutableCompositionTrack *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock41)(AVMovieTrack *, NSError *);
ListenerBlock41 wrapListenerBlock_ObjCBlock_ffiVoid_AVMovieTrack_NSError(ListenerBlock41 block) {
  ListenerBlock41 wrapper = [^void(AVMovieTrack *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock42)(AVMutableMovieTrack *, NSError *);
ListenerBlock42 wrapListenerBlock_ObjCBlock_ffiVoid_AVMutableMovieTrack_NSError(
    ListenerBlock42 block) {
  ListenerBlock42 wrapper = [^void(AVMutableMovieTrack *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock43)(AVFragmentedMovieTrack *, NSError *);
ListenerBlock43 wrapListenerBlock_ObjCBlock_ffiVoid_AVFragmentedMovieTrack_NSError(
    ListenerBlock43 block) {
  ListenerBlock43 wrapper = [^void(AVFragmentedMovieTrack *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock44)(AVAudioPCMBuffer *, AVAudioTime *);
ListenerBlock44 wrapListenerBlock_ObjCBlock_ffiVoid_AVAudioPCMBuffer_AVAudioTime(
    ListenerBlock44 block) {
  ListenerBlock44 wrapper = [^void(AVAudioPCMBuffer *arg0, AVAudioTime *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock45)(AVAudioUnit *, NSError *);
ListenerBlock45 wrapListenerBlock_ObjCBlock_ffiVoid_AVAudioUnit_NSError(ListenerBlock45 block) {
  ListenerBlock45 wrapper = [^void(AVAudioUnit *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock46)(AVMusicEvent *, double *, BOOL *);
ListenerBlock46 wrapListenerBlock_ObjCBlock_ffiVoid_AVMusicEvent_ffiDouble_bool(
    ListenerBlock46 block) {
  ListenerBlock46 wrapper = [^void(AVMusicEvent *arg0, double *arg1, BOOL *arg2) {
    block([arg0 retain], arg1, arg2);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock47)(AVMusicTrack *, NSData *, double);
ListenerBlock47 wrapListenerBlock_ObjCBlock_ffiVoid_AVMusicTrack_NSData_ffiDouble(
    ListenerBlock47 block) {
  ListenerBlock47 wrapper = [^void(AVMusicTrack *arg0, NSData *arg1, double arg2) {
    block([arg0 retain], [arg1 retain], arg2);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock48)(struct opaqueCMSampleBuffer *, NSError *);
ListenerBlock48 wrapListenerBlock_ObjCBlock_ffiVoid_opaqueCMSampleBuffer_NSError(
    ListenerBlock48 block) {
  ListenerBlock48 wrapper = [^void(struct opaqueCMSampleBuffer *arg0, NSError *arg1) {
    block(arg0, [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock49)(struct opaqueCMSampleBuffer *,
                                AVCaptureBracketedStillImageSettings *, NSError *);
ListenerBlock49
wrapListenerBlock_ObjCBlock_ffiVoid_opaqueCMSampleBuffer_AVCaptureBracketedStillImageSettings_NSError(
    ListenerBlock49 block) {
  ListenerBlock49 wrapper = [^void(struct opaqueCMSampleBuffer *arg0,
                                   AVCaptureBracketedStillImageSettings *arg1, NSError *arg2) {
    block(arg0, [arg1 retain], [arg2 retain]);
  } copy];
  [block release];
  return wrapper;
}
