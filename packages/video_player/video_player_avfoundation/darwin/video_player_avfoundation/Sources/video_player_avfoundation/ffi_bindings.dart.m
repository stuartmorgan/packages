#import <AVFoundation/AVFoundation.h>
#include <stdint.h>
#import "include/video_player_avfoundation/FVPDefaultAVFactory.h"
#import "include/video_player_avfoundation/FVPDefaultDisplayLinkFactory.h"
#import "include/video_player_avfoundation/FVPVideoPlayer.h"

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

typedef void (^ListenerBlock2)(NSTimer *);
ListenerBlock2 wrapListenerBlock_ObjCBlock_ffiVoid_NSTimer(ListenerBlock2 block)
    NS_RETURNS_RETAINED {
  return ^void(NSTimer *arg0) {
    block(objc_retain(arg0));
  };
}

#if TARGET_OS_OSX
typedef void (^ListenerBlock3)(NSEvent *);
ListenerBlock3 wrapListenerBlock_ObjCBlock_ffiVoid_NSEvent(ListenerBlock3 block)
    NS_RETURNS_RETAINED {
  return ^void(NSEvent *arg0) {
    block(objc_retain(arg0));
  };
}
#endif

#if TARGET_OS_OSX
typedef void (^ListenerBlock4)(NSMenu *);
ListenerBlock4 wrapListenerBlock_ObjCBlock_ffiVoid_NSMenu(ListenerBlock4 block)
    NS_RETURNS_RETAINED {
  return ^void(NSMenu *arg0) {
    block(objc_retain(arg0));
  };
}
#endif

typedef void (^ListenerBlock5)(struct CGRect, struct CGRect, NSTextContainer *, struct _NSRange,
                               BOOL *);
ListenerBlock5 wrapListenerBlock_ObjCBlock_ffiVoid_CGRect_CGRect_NSTextContainer_NSRange_bool(
    ListenerBlock5 block) NS_RETURNS_RETAINED {
  return ^void(struct CGRect arg0, struct CGRect arg1, NSTextContainer *arg2, struct _NSRange arg3,
               BOOL *arg4) {
    block(arg0, arg1, objc_retain(arg2), arg3, arg4);
  };
}

typedef void (^ListenerBlock6)(NSError *);
ListenerBlock6 wrapListenerBlock_ObjCBlock_ffiVoid_NSError(ListenerBlock6 block)
    NS_RETURNS_RETAINED {
  return ^void(NSError *arg0) {
    block(objc_retain(arg0));
  };
}

#if TARGET_OS_OSX
typedef void (^ListenerBlock7)(NSTextLayoutManager *, NSTextLayoutFragment *);
ListenerBlock7 wrapListenerBlock_ObjCBlock_ffiVoid_NSTextLayoutManager_NSTextLayoutFragment(
    ListenerBlock7 block) NS_RETURNS_RETAINED {
  return ^void(NSTextLayoutManager *arg0, NSTextLayoutFragment *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}
#endif

#if TARGET_OS_OSX
typedef void (^ListenerBlock8)(NSDraggingItem *, long, BOOL *);
ListenerBlock8 wrapListenerBlock_ObjCBlock_ffiVoid_NSDraggingItem_ffiLong_bool(ListenerBlock8 block)
    NS_RETURNS_RETAINED {
  return ^void(NSDraggingItem *arg0, long arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}
#endif

typedef void (^ListenerBlock9)(id);
ListenerBlock9 wrapListenerBlock_ObjCBlock_ffiVoid_objcObjCObject(ListenerBlock9 block)
    NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock10)(NSInputStream *, NSOutputStream *, NSError *);
ListenerBlock10 wrapListenerBlock_ObjCBlock_ffiVoid_NSInputStream_NSOutputStream_NSError(
    ListenerBlock10 block) NS_RETURNS_RETAINED {
  return ^void(NSInputStream *arg0, NSOutputStream *arg1, NSError *arg2) {
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

#if TARGET_OS_OSX
typedef void (^ListenerBlock11)(NSEvent *, BOOL *);
ListenerBlock11 wrapListenerBlock_ObjCBlock_ffiVoid_NSEvent_bool(ListenerBlock11 block)
    NS_RETURNS_RETAINED {
  return ^void(NSEvent *arg0, BOOL *arg1) {
    block(objc_retain(arg0), arg1);
  };
}
#endif

typedef void (^ListenerBlock12)(NSDate *, BOOL, BOOL *);
ListenerBlock12 wrapListenerBlock_ObjCBlock_ffiVoid_NSDate_bool_bool(ListenerBlock12 block)
    NS_RETURNS_RETAINED {
  return ^void(NSDate *arg0, BOOL arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void (^ListenerBlock13)(NSFileHandle *);
ListenerBlock13 wrapListenerBlock_ObjCBlock_ffiVoid_NSFileHandle(ListenerBlock13 block)
    NS_RETURNS_RETAINED {
  return ^void(NSFileHandle *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock14)(NSDictionary *, NSError *);
ListenerBlock14 wrapListenerBlock_ObjCBlock_ffiVoid_NSDictionary_NSError(ListenerBlock14 block)
    NS_RETURNS_RETAINED {
  return ^void(NSDictionary *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock15)(NSArray *);
ListenerBlock15 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray(ListenerBlock15 block)
    NS_RETURNS_RETAINED {
  return ^void(NSArray *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock16)(NSTextCheckingResult *, NSMatchingFlags, BOOL *);
ListenerBlock16 wrapListenerBlock_ObjCBlock_ffiVoid_NSTextCheckingResult_NSMatchingFlags_bool(
    ListenerBlock16 block) NS_RETURNS_RETAINED {
  return ^void(NSTextCheckingResult *arg0, NSMatchingFlags arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void (^ListenerBlock17)(NSCachedURLResponse *);
ListenerBlock17 wrapListenerBlock_ObjCBlock_ffiVoid_NSCachedURLResponse(ListenerBlock17 block)
    NS_RETURNS_RETAINED {
  return ^void(NSCachedURLResponse *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock18)(NSURLResponse *, NSData *, NSError *);
ListenerBlock18 wrapListenerBlock_ObjCBlock_ffiVoid_NSURLResponse_NSData_NSError(
    ListenerBlock18 block) NS_RETURNS_RETAINED {
  return ^void(NSURLResponse *arg0, NSData *arg1, NSError *arg2) {
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

typedef void (^ListenerBlock19)(NSDictionary *);
ListenerBlock19 wrapListenerBlock_ObjCBlock_ffiVoid_NSDictionary(ListenerBlock19 block)
    NS_RETURNS_RETAINED {
  return ^void(NSDictionary *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock20)(NSURLCredential *);
ListenerBlock20 wrapListenerBlock_ObjCBlock_ffiVoid_NSURLCredential(ListenerBlock20 block)
    NS_RETURNS_RETAINED {
  return ^void(NSURLCredential *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock21)(NSArray *, NSArray *, NSArray *);
ListenerBlock21 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray_NSArray_NSArray(ListenerBlock21 block)
    NS_RETURNS_RETAINED {
  return ^void(NSArray *arg0, NSArray *arg1, NSArray *arg2) {
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

typedef void (^ListenerBlock22)(NSArray *);
ListenerBlock22 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray1(ListenerBlock22 block)
    NS_RETURNS_RETAINED {
  return ^void(NSArray *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock23)(NSData *);
ListenerBlock23 wrapListenerBlock_ObjCBlock_ffiVoid_NSData(ListenerBlock23 block)
    NS_RETURNS_RETAINED {
  return ^void(NSData *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock24)(NSData *, BOOL, NSError *);
ListenerBlock24 wrapListenerBlock_ObjCBlock_ffiVoid_NSData_bool_NSError(ListenerBlock24 block)
    NS_RETURNS_RETAINED {
  return ^void(NSData *arg0, BOOL arg1, NSError *arg2) {
    block(objc_retain(arg0), arg1, objc_retain(arg2));
  };
}

typedef void (^ListenerBlock25)(NSURLSessionWebSocketMessage *, NSError *);
ListenerBlock25 wrapListenerBlock_ObjCBlock_ffiVoid_NSURLSessionWebSocketMessage_NSError(
    ListenerBlock25 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionWebSocketMessage *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock26)(NSData *, NSURLResponse *, NSError *);
ListenerBlock26 wrapListenerBlock_ObjCBlock_ffiVoid_NSData_NSURLResponse_NSError(
    ListenerBlock26 block) NS_RETURNS_RETAINED {
  return ^void(NSData *arg0, NSURLResponse *arg1, NSError *arg2) {
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

typedef void (^ListenerBlock27)(NSURL *, NSURLResponse *, NSError *);
ListenerBlock27 wrapListenerBlock_ObjCBlock_ffiVoid_NSURL_NSURLResponse_NSError(
    ListenerBlock27 block) NS_RETURNS_RETAINED {
  return ^void(NSURL *arg0, NSURLResponse *arg1, NSError *arg2) {
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

#if TARGET_OS_OSX
typedef void (^ListenerBlock28)(NSTask *);
ListenerBlock28 wrapListenerBlock_ObjCBlock_ffiVoid_NSTask(ListenerBlock28 block)
    NS_RETURNS_RETAINED {
  return ^void(NSTask *arg0) {
    block(objc_retain(arg0));
  };
}
#endif

typedef void (^ListenerBlock29)(NSData *, NSError *);
ListenerBlock29 wrapListenerBlock_ObjCBlock_ffiVoid_NSData_NSError(ListenerBlock29 block)
    NS_RETURNS_RETAINED {
  return ^void(NSData *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock30)(AVAssetTrackSegment *, NSError *);
ListenerBlock30 wrapListenerBlock_ObjCBlock_ffiVoid_AVAssetTrackSegment_NSError(
    ListenerBlock30 block) NS_RETURNS_RETAINED {
  return ^void(AVAssetTrackSegment *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock31)(CMTime, NSError *);
ListenerBlock31 wrapListenerBlock_ObjCBlock_ffiVoid_CMTime_NSError(ListenerBlock31 block)
    NS_RETURNS_RETAINED {
  return ^void(CMTime arg0, NSError *arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^ListenerBlock32)(NSArray *, NSError *);
ListenerBlock32 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray_NSError(ListenerBlock32 block)
    NS_RETURNS_RETAINED {
  return ^void(NSArray *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock33)(AVAssetTrack *, NSError *);
ListenerBlock33 wrapListenerBlock_ObjCBlock_ffiVoid_AVAssetTrack_NSError(ListenerBlock33 block)
    NS_RETURNS_RETAINED {
  return ^void(AVAssetTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock34)(AVMetadataItemValueRequest *);
ListenerBlock34 wrapListenerBlock_ObjCBlock_ffiVoid_AVMetadataItemValueRequest(
    ListenerBlock34 block) NS_RETURNS_RETAINED {
  return ^void(AVMetadataItemValueRequest *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock35)(AVMediaSelectionGroup *, NSError *);
ListenerBlock35 wrapListenerBlock_ObjCBlock_ffiVoid_AVMediaSelectionGroup_NSError(
    ListenerBlock35 block) NS_RETURNS_RETAINED {
  return ^void(AVMediaSelectionGroup *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock36)(int32_t, NSError *);
ListenerBlock36 wrapListenerBlock_ObjCBlock_ffiVoid_Int32_NSError(ListenerBlock36 block)
    NS_RETURNS_RETAINED {
  return ^void(int32_t arg0, NSError *arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^ListenerBlock37)(AVFragmentedAssetTrack *, NSError *);
ListenerBlock37 wrapListenerBlock_ObjCBlock_ffiVoid_AVFragmentedAssetTrack_NSError(
    ListenerBlock37 block) NS_RETURNS_RETAINED {
  return ^void(AVFragmentedAssetTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock38)(int64_t, NSError *);
ListenerBlock38 wrapListenerBlock_ObjCBlock_ffiVoid_Int64_NSError(ListenerBlock38 block)
    NS_RETURNS_RETAINED {
  return ^void(int64_t arg0, NSError *arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^ListenerBlock39)(AVVideoComposition *, NSError *);
ListenerBlock39 wrapListenerBlock_ObjCBlock_ffiVoid_AVVideoComposition_NSError(
    ListenerBlock39 block) NS_RETURNS_RETAINED {
  return ^void(AVVideoComposition *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock40)(AVAsynchronousCIImageFilteringRequest *);
ListenerBlock40 wrapListenerBlock_ObjCBlock_ffiVoid_AVAsynchronousCIImageFilteringRequest(
    ListenerBlock40 block) NS_RETURNS_RETAINED {
  return ^void(AVAsynchronousCIImageFilteringRequest *arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^ListenerBlock41)(BOOL, NSError *);
ListenerBlock41 wrapListenerBlock_ObjCBlock_ffiVoid_bool_NSError(ListenerBlock41 block)
    NS_RETURNS_RETAINED {
  return ^void(BOOL arg0, NSError *arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^ListenerBlock42)(AVMutableVideoComposition *, NSError *);
ListenerBlock42 wrapListenerBlock_ObjCBlock_ffiVoid_AVMutableVideoComposition_NSError(
    ListenerBlock42 block) NS_RETURNS_RETAINED {
  return ^void(AVMutableVideoComposition *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock43)(AUAudioUnit *, NSError *);
ListenerBlock43 wrapListenerBlock_ObjCBlock_ffiVoid_AUAudioUnit_NSError(ListenerBlock43 block)
    NS_RETURNS_RETAINED {
  return ^void(AUAudioUnit *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock44)(AUParameter *, float);
ListenerBlock44 wrapListenerBlock_ObjCBlock_ffiVoid_AUParameter_ffiFloat(ListenerBlock44 block)
    NS_RETURNS_RETAINED {
  return ^void(AUParameter *arg0, float arg1) {
    block(objc_retain(arg0), arg1);
  };
}

typedef void (^ListenerBlock45)(uint8_t, uint8_t, MIDICIProfile *, BOOL);
ListenerBlock45 wrapListenerBlock_ObjCBlock_ffiVoid_Uint8_Uint8_MIDICIProfile_bool(
    ListenerBlock45 block) NS_RETURNS_RETAINED {
  return ^void(uint8_t arg0, uint8_t arg1, MIDICIProfile *arg2, BOOL arg3) {
    block(arg0, arg1, objc_retain(arg2), arg3);
  };
}

typedef void (^ListenerBlock46)(AVCompositionTrack *, NSError *);
ListenerBlock46 wrapListenerBlock_ObjCBlock_ffiVoid_AVCompositionTrack_NSError(
    ListenerBlock46 block) NS_RETURNS_RETAINED {
  return ^void(AVCompositionTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock47)(AVMutableCompositionTrack *, NSError *);
ListenerBlock47 wrapListenerBlock_ObjCBlock_ffiVoid_AVMutableCompositionTrack_NSError(
    ListenerBlock47 block) NS_RETURNS_RETAINED {
  return ^void(AVMutableCompositionTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock48)(AVMovieTrack *, NSError *);
ListenerBlock48 wrapListenerBlock_ObjCBlock_ffiVoid_AVMovieTrack_NSError(ListenerBlock48 block)
    NS_RETURNS_RETAINED {
  return ^void(AVMovieTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock49)(AVMutableMovieTrack *, NSError *);
ListenerBlock49 wrapListenerBlock_ObjCBlock_ffiVoid_AVMutableMovieTrack_NSError(
    ListenerBlock49 block) NS_RETURNS_RETAINED {
  return ^void(AVMutableMovieTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock50)(AVFragmentedMovieTrack *, NSError *);
ListenerBlock50 wrapListenerBlock_ObjCBlock_ffiVoid_AVFragmentedMovieTrack_NSError(
    ListenerBlock50 block) NS_RETURNS_RETAINED {
  return ^void(AVFragmentedMovieTrack *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock51)(AVAudioPCMBuffer *, AVAudioTime *);
ListenerBlock51 wrapListenerBlock_ObjCBlock_ffiVoid_AVAudioPCMBuffer_AVAudioTime(
    ListenerBlock51 block) NS_RETURNS_RETAINED {
  return ^void(AVAudioPCMBuffer *arg0, AVAudioTime *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock52)(AVAudioUnit *, NSError *);
ListenerBlock52 wrapListenerBlock_ObjCBlock_ffiVoid_AVAudioUnit_NSError(ListenerBlock52 block)
    NS_RETURNS_RETAINED {
  return ^void(AVAudioUnit *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock53)(AVMusicEvent *, double *, BOOL *);
ListenerBlock53 wrapListenerBlock_ObjCBlock_ffiVoid_AVMusicEvent_ffiDouble_bool(
    ListenerBlock53 block) NS_RETURNS_RETAINED {
  return ^void(AVMusicEvent *arg0, double *arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void (^ListenerBlock54)(AVMusicTrack *, NSData *, double);
ListenerBlock54 wrapListenerBlock_ObjCBlock_ffiVoid_AVMusicTrack_NSData_ffiDouble(
    ListenerBlock54 block) NS_RETURNS_RETAINED {
  return ^void(AVMusicTrack *arg0, NSData *arg1, double arg2) {
    block(objc_retain(arg0), objc_retain(arg1), arg2);
  };
}

typedef void (^ListenerBlock55)(struct opaqueCMSampleBuffer *, NSError *);
ListenerBlock55 wrapListenerBlock_ObjCBlock_ffiVoid_opaqueCMSampleBuffer_NSError(
    ListenerBlock55 block) NS_RETURNS_RETAINED {
  return ^void(struct opaqueCMSampleBuffer *arg0, NSError *arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^ListenerBlock56)(struct opaqueCMSampleBuffer *,
                                AVCaptureBracketedStillImageSettings *, NSError *);
ListenerBlock56
wrapListenerBlock_ObjCBlock_ffiVoid_opaqueCMSampleBuffer_AVCaptureBracketedStillImageSettings_NSError(
    ListenerBlock56 block) NS_RETURNS_RETAINED {
  return ^void(struct opaqueCMSampleBuffer *arg0, AVCaptureBracketedStillImageSettings *arg1,
               NSError *arg2) {
    block(arg0, objc_retain(arg1), objc_retain(arg2));
  };
}

typedef void (^ListenerBlock57)(NSNotification *);
ListenerBlock57 wrapListenerBlock_ObjCBlock_ffiVoid_NSNotification(ListenerBlock57 block)
    NS_RETURNS_RETAINED {
  return ^void(NSNotification *arg0) {
    block(objc_retain(arg0));
  };
}

#if TARGET_OS_OSX
typedef void (^ListenerBlock58)(NSRunningApplication *, NSError *);
ListenerBlock58 wrapListenerBlock_ObjCBlock_ffiVoid_NSRunningApplication_NSError(
    ListenerBlock58 block) NS_RETURNS_RETAINED {
  return ^void(NSRunningApplication *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}
#endif

typedef void (^ListenerBlock59)(NSDictionary *, NSError *);
ListenerBlock59 wrapListenerBlock_ObjCBlock_ffiVoid_NSDictionary_NSError1(ListenerBlock59 block)
    NS_RETURNS_RETAINED {
  return ^void(NSDictionary *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

#if TARGET_OS_OSX
typedef void (^ListenerBlock60)(NSWorkspaceAuthorization *, NSError *);
ListenerBlock60 wrapListenerBlock_ObjCBlock_ffiVoid_NSWorkspaceAuthorization_NSError(
    ListenerBlock60 block) NS_RETURNS_RETAINED {
  return ^void(NSWorkspaceAuthorization *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}
#endif

#if TARGET_OS_OSX
typedef void (^ListenerBlock61)(NSPersistentStoreDescription *, NSError *);
ListenerBlock61 wrapListenerBlock_ObjCBlock_ffiVoid_NSPersistentStoreDescription_NSError(
    ListenerBlock61 block) NS_RETURNS_RETAINED {
  return ^void(NSPersistentStoreDescription *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}
#endif

typedef void (^ListenerBlock62)(void (^)());
ListenerBlock62 wrapListenerBlock_ObjCBlock_ffiVoid_ffiVoid(ListenerBlock62 block)
    NS_RETURNS_RETAINED {
  return ^void(void (^arg0)()) {
    block(objc_retainBlock(arg0));
  };
}

typedef void (^ListenerBlock63)(void (^)());
ListenerBlock63 wrapListenerBlock_ObjCBlock_ffiVoid_ffiVoid1(ListenerBlock63 block)
    NS_RETURNS_RETAINED {
  return ^void(void (^arg0)()) {
    block(objc_retainBlock(arg0));
  };
}

#if TARGET_OS_OSX
typedef void (^ListenerBlock64)(NSWindow *, NSError *);
ListenerBlock64 wrapListenerBlock_ObjCBlock_ffiVoid_NSWindow_NSError(ListenerBlock64 block)
    NS_RETURNS_RETAINED {
  return ^void(NSWindow *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock65)(NSWindow *, BOOL *);
ListenerBlock65 wrapListenerBlock_ObjCBlock_ffiVoid_NSWindow_bool(ListenerBlock65 block)
    NS_RETURNS_RETAINED {
  return ^void(NSWindow *arg0, BOOL *arg1) {
    block(objc_retain(arg0), arg1);
  };
}
#endif

#if TARGET_OS_OSX
typedef void (^ListenerBlock66)(NSDocument *, BOOL, NSError *);
ListenerBlock66 wrapListenerBlock_ObjCBlock_ffiVoid_NSDocument_bool_NSError(ListenerBlock66 block)
    NS_RETURNS_RETAINED {
  return ^void(NSDocument *arg0, BOOL arg1, NSError *arg2) {
    block(objc_retain(arg0), arg1, objc_retain(arg2));
  };
}
#endif

#if TARGET_OS_OSX
typedef void (^ListenerBlock67)(NSSliderAccessory *);
ListenerBlock67 wrapListenerBlock_ObjCBlock_ffiVoid_NSSliderAccessory(ListenerBlock67 block)
    NS_RETURNS_RETAINED {
  return ^void(NSSliderAccessory *arg0) {
    block(objc_retain(arg0));
  };
}
#endif

typedef void (^ListenerBlock68)(long, NSArray *, NSOrthography *, long);
ListenerBlock68 wrapListenerBlock_ObjCBlock_ffiVoid_ffiLong_NSArray_NSOrthography_ffiLong(
    ListenerBlock68 block) NS_RETURNS_RETAINED {
  return ^void(long arg0, NSArray *arg1, NSOrthography *arg2, long arg3) {
    block(arg0, objc_retain(arg1), objc_retain(arg2), arg3);
  };
}

typedef void (^ListenerBlock69)(long, NSArray *);
ListenerBlock69 wrapListenerBlock_ObjCBlock_ffiVoid_ffiLong_NSArray(ListenerBlock69 block)
    NS_RETURNS_RETAINED {
  return ^void(long arg0, NSArray *arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^ListenerBlock70)(NSString *);
ListenerBlock70 wrapListenerBlock_ObjCBlock_ffiVoid_NSString(ListenerBlock70 block)
    NS_RETURNS_RETAINED {
  return ^void(NSString *arg0) {
    block(objc_retain(arg0));
  };
}

#if TARGET_OS_OSX
typedef void (^ListenerBlock71)(NSTableRowView *, long);
ListenerBlock71 wrapListenerBlock_ObjCBlock_ffiVoid_NSTableRowView_ffiLong(ListenerBlock71 block)
    NS_RETURNS_RETAINED {
  return ^void(NSTableRowView *arg0, long arg1) {
    block(objc_retain(arg0), arg1);
  };
}
#endif

#if TARGET_OS_OSX
typedef void (^ListenerBlock72)(CKRecord *, NSError *);
ListenerBlock72 wrapListenerBlock_ObjCBlock_ffiVoid_CKRecord_NSError(ListenerBlock72 block)
    NS_RETURNS_RETAINED {
  return ^void(CKRecord *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock73)(CKRecordID *, NSError *);
ListenerBlock73 wrapListenerBlock_ObjCBlock_ffiVoid_CKRecordID_NSError(ListenerBlock73 block)
    NS_RETURNS_RETAINED {
  return ^void(CKRecordID *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock74)(CKRecordZone *, NSError *);
ListenerBlock74 wrapListenerBlock_ObjCBlock_ffiVoid_CKRecordZone_NSError(ListenerBlock74 block)
    NS_RETURNS_RETAINED {
  return ^void(CKRecordZone *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock75)(CKRecordZoneID *, NSError *);
ListenerBlock75 wrapListenerBlock_ObjCBlock_ffiVoid_CKRecordZoneID_NSError(ListenerBlock75 block)
    NS_RETURNS_RETAINED {
  return ^void(CKRecordZoneID *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^ListenerBlock76)(CKSubscription *, NSError *);
ListenerBlock76 wrapListenerBlock_ObjCBlock_ffiVoid_CKSubscription_NSError(ListenerBlock76 block)
    NS_RETURNS_RETAINED {
  return ^void(CKSubscription *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}
#endif

typedef void (^ListenerBlock77)(NSString *, NSError *);
ListenerBlock77 wrapListenerBlock_ObjCBlock_ffiVoid_NSString_NSError(ListenerBlock77 block)
    NS_RETURNS_RETAINED {
  return ^void(NSString *arg0, NSError *arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}
