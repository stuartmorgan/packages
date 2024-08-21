#include <stdint.h>

#import <AVFoundation/AVFoundation.h>#import "video_player_avfoundation/Sources/video_player_avfoundation/include/video_player_avfoundation/FVPDefaultAVFactory.h"
#import "video_player_avfoundation/Sources/video_player_avfoundation/include/video_player_avfoundation/FVPVideoPlayer.h"

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

typedef void (^ListenerBlock2)(NSTimer *);
ListenerBlock2 wrapListenerBlock_ObjCBlock_ffiVoid_NSTimer(ListenerBlock2 block) {
  ListenerBlock2 wrapper = [^void(NSTimer *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock3)(NSEvent *);
ListenerBlock3 wrapListenerBlock_ObjCBlock_ffiVoid_NSEvent(ListenerBlock3 block) {
  ListenerBlock3 wrapper = [^void(NSEvent *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock4)(NSMenu *);
ListenerBlock4 wrapListenerBlock_ObjCBlock_ffiVoid_NSMenu(ListenerBlock4 block) {
  ListenerBlock4 wrapper = [^void(NSMenu *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock5)(struct CGRect, struct CGRect, NSTextContainer *, struct _NSRange,
                               BOOL *);
ListenerBlock5 wrapListenerBlock_ObjCBlock_ffiVoid_CGRect_CGRect_NSTextContainer_NSRange_bool(
    ListenerBlock5 block) {
  ListenerBlock5 wrapper = [^void(struct CGRect arg0, struct CGRect arg1, NSTextContainer *arg2,
                                  struct _NSRange arg3, BOOL *arg4) {
    block(arg0, arg1, [arg2 retain], arg3, arg4);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock6)(NSError *);
ListenerBlock6 wrapListenerBlock_ObjCBlock_ffiVoid_NSError(ListenerBlock6 block) {
  ListenerBlock6 wrapper = [^void(NSError *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock7)(NSTextLayoutManager *, NSTextLayoutFragment *);
ListenerBlock7 wrapListenerBlock_ObjCBlock_ffiVoid_NSTextLayoutManager_NSTextLayoutFragment(
    ListenerBlock7 block) {
  ListenerBlock7 wrapper = [^void(NSTextLayoutManager *arg0, NSTextLayoutFragment *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock8)(NSDraggingItem *, long, BOOL *);
ListenerBlock8 wrapListenerBlock_ObjCBlock_ffiVoid_NSDraggingItem_ffiLong_bool(
    ListenerBlock8 block) {
  ListenerBlock8 wrapper = [^void(NSDraggingItem *arg0, long arg1, BOOL *arg2) {
    block([arg0 retain], arg1, arg2);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock9)(id);
ListenerBlock9 wrapListenerBlock_ObjCBlock_ffiVoid_objcObjCObject(ListenerBlock9 block) {
  ListenerBlock9 wrapper = [^void(id arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock10)(NSInputStream *, NSOutputStream *, NSError *);
ListenerBlock10 wrapListenerBlock_ObjCBlock_ffiVoid_NSInputStream_NSOutputStream_NSError(
    ListenerBlock10 block) {
  ListenerBlock10 wrapper = [^void(NSInputStream *arg0, NSOutputStream *arg1, NSError *arg2) {
    block([arg0 retain], [arg1 retain], [arg2 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock11)(NSEvent *, BOOL *);
ListenerBlock11 wrapListenerBlock_ObjCBlock_ffiVoid_NSEvent_bool(ListenerBlock11 block) {
  ListenerBlock11 wrapper = [^void(NSEvent *arg0, BOOL *arg1) {
    block([arg0 retain], arg1);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock12)(NSDate *, BOOL, BOOL *);
ListenerBlock12 wrapListenerBlock_ObjCBlock_ffiVoid_NSDate_bool_bool(ListenerBlock12 block) {
  ListenerBlock12 wrapper = [^void(NSDate *arg0, BOOL arg1, BOOL *arg2) {
    block([arg0 retain], arg1, arg2);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock13)(NSFileHandle *);
ListenerBlock13 wrapListenerBlock_ObjCBlock_ffiVoid_NSFileHandle(ListenerBlock13 block) {
  ListenerBlock13 wrapper = [^void(NSFileHandle *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock14)(NSDictionary *, NSError *);
ListenerBlock14 wrapListenerBlock_ObjCBlock_ffiVoid_NSDictionary_NSError(ListenerBlock14 block) {
  ListenerBlock14 wrapper = [^void(NSDictionary *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock15)(NSArray *);
ListenerBlock15 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray(ListenerBlock15 block) {
  ListenerBlock15 wrapper = [^void(NSArray *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock16)(NSTextCheckingResult *, NSMatchingFlags, BOOL *);
ListenerBlock16 wrapListenerBlock_ObjCBlock_ffiVoid_NSTextCheckingResult_NSMatchingFlags_bool(
    ListenerBlock16 block) {
  ListenerBlock16 wrapper = [^void(NSTextCheckingResult *arg0, NSMatchingFlags arg1, BOOL *arg2) {
    block([arg0 retain], arg1, arg2);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock17)(NSCachedURLResponse *);
ListenerBlock17 wrapListenerBlock_ObjCBlock_ffiVoid_NSCachedURLResponse(ListenerBlock17 block) {
  ListenerBlock17 wrapper = [^void(NSCachedURLResponse *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock18)(NSURLResponse *, NSData *, NSError *);
ListenerBlock18 wrapListenerBlock_ObjCBlock_ffiVoid_NSURLResponse_NSData_NSError(
    ListenerBlock18 block) {
  ListenerBlock18 wrapper = [^void(NSURLResponse *arg0, NSData *arg1, NSError *arg2) {
    block([arg0 retain], [arg1 retain], [arg2 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock19)(NSDictionary *);
ListenerBlock19 wrapListenerBlock_ObjCBlock_ffiVoid_NSDictionary(ListenerBlock19 block) {
  ListenerBlock19 wrapper = [^void(NSDictionary *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock20)(NSURLCredential *);
ListenerBlock20 wrapListenerBlock_ObjCBlock_ffiVoid_NSURLCredential(ListenerBlock20 block) {
  ListenerBlock20 wrapper = [^void(NSURLCredential *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock21)(NSArray *, NSArray *, NSArray *);
ListenerBlock21 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray_NSArray_NSArray(ListenerBlock21 block) {
  ListenerBlock21 wrapper = [^void(NSArray *arg0, NSArray *arg1, NSArray *arg2) {
    block([arg0 retain], [arg1 retain], [arg2 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock22)(NSArray *);
ListenerBlock22 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray1(ListenerBlock22 block) {
  ListenerBlock22 wrapper = [^void(NSArray *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock23)(NSData *);
ListenerBlock23 wrapListenerBlock_ObjCBlock_ffiVoid_NSData(ListenerBlock23 block) {
  ListenerBlock23 wrapper = [^void(NSData *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock24)(NSData *, BOOL, NSError *);
ListenerBlock24 wrapListenerBlock_ObjCBlock_ffiVoid_NSData_bool_NSError(ListenerBlock24 block) {
  ListenerBlock24 wrapper = [^void(NSData *arg0, BOOL arg1, NSError *arg2) {
    block([arg0 retain], arg1, [arg2 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock25)(NSURLSessionWebSocketMessage *, NSError *);
ListenerBlock25 wrapListenerBlock_ObjCBlock_ffiVoid_NSURLSessionWebSocketMessage_NSError(
    ListenerBlock25 block) {
  ListenerBlock25 wrapper = [^void(NSURLSessionWebSocketMessage *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock26)(NSData *, NSURLResponse *, NSError *);
ListenerBlock26 wrapListenerBlock_ObjCBlock_ffiVoid_NSData_NSURLResponse_NSError(
    ListenerBlock26 block) {
  ListenerBlock26 wrapper = [^void(NSData *arg0, NSURLResponse *arg1, NSError *arg2) {
    block([arg0 retain], [arg1 retain], [arg2 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock27)(NSURL *, NSURLResponse *, NSError *);
ListenerBlock27 wrapListenerBlock_ObjCBlock_ffiVoid_NSURL_NSURLResponse_NSError(
    ListenerBlock27 block) {
  ListenerBlock27 wrapper = [^void(NSURL *arg0, NSURLResponse *arg1, NSError *arg2) {
    block([arg0 retain], [arg1 retain], [arg2 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock28)(NSTask *);
ListenerBlock28 wrapListenerBlock_ObjCBlock_ffiVoid_NSTask(ListenerBlock28 block) {
  ListenerBlock28 wrapper = [^void(NSTask *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock29)(NSData *, NSError *);
ListenerBlock29 wrapListenerBlock_ObjCBlock_ffiVoid_NSData_NSError(ListenerBlock29 block) {
  ListenerBlock29 wrapper = [^void(NSData *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock30)(AVAssetTrackSegment *, NSError *);
ListenerBlock30 wrapListenerBlock_ObjCBlock_ffiVoid_AVAssetTrackSegment_NSError(
    ListenerBlock30 block) {
  ListenerBlock30 wrapper = [^void(AVAssetTrackSegment *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock31)(CMTime, NSError *);
ListenerBlock31 wrapListenerBlock_ObjCBlock_ffiVoid_CMTime_NSError(ListenerBlock31 block) {
  ListenerBlock31 wrapper = [^void(CMTime arg0, NSError *arg1) {
    block(arg0, [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock32)(NSArray *, NSError *);
ListenerBlock32 wrapListenerBlock_ObjCBlock_ffiVoid_NSArray_NSError(ListenerBlock32 block) {
  ListenerBlock32 wrapper = [^void(NSArray *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock33)(AVAssetTrack *, NSError *);
ListenerBlock33 wrapListenerBlock_ObjCBlock_ffiVoid_AVAssetTrack_NSError(ListenerBlock33 block) {
  ListenerBlock33 wrapper = [^void(AVAssetTrack *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock34)(AVMetadataItemValueRequest *);
ListenerBlock34 wrapListenerBlock_ObjCBlock_ffiVoid_AVMetadataItemValueRequest(
    ListenerBlock34 block) {
  ListenerBlock34 wrapper = [^void(AVMetadataItemValueRequest *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock35)(AVMediaSelectionGroup *, NSError *);
ListenerBlock35 wrapListenerBlock_ObjCBlock_ffiVoid_AVMediaSelectionGroup_NSError(
    ListenerBlock35 block) {
  ListenerBlock35 wrapper = [^void(AVMediaSelectionGroup *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock36)(int32_t, NSError *);
ListenerBlock36 wrapListenerBlock_ObjCBlock_ffiVoid_Int32_NSError(ListenerBlock36 block) {
  ListenerBlock36 wrapper = [^void(int32_t arg0, NSError *arg1) {
    block(arg0, [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock37)(AVFragmentedAssetTrack *, NSError *);
ListenerBlock37 wrapListenerBlock_ObjCBlock_ffiVoid_AVFragmentedAssetTrack_NSError(
    ListenerBlock37 block) {
  ListenerBlock37 wrapper = [^void(AVFragmentedAssetTrack *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock38)(int64_t, NSError *);
ListenerBlock38 wrapListenerBlock_ObjCBlock_ffiVoid_Int64_NSError(ListenerBlock38 block) {
  ListenerBlock38 wrapper = [^void(int64_t arg0, NSError *arg1) {
    block(arg0, [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock39)(AVVideoComposition *, NSError *);
ListenerBlock39 wrapListenerBlock_ObjCBlock_ffiVoid_AVVideoComposition_NSError(
    ListenerBlock39 block) {
  ListenerBlock39 wrapper = [^void(AVVideoComposition *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock40)(AVAsynchronousCIImageFilteringRequest *);
ListenerBlock40 wrapListenerBlock_ObjCBlock_ffiVoid_AVAsynchronousCIImageFilteringRequest(
    ListenerBlock40 block) {
  ListenerBlock40 wrapper = [^void(AVAsynchronousCIImageFilteringRequest *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock41)(BOOL, NSError *);
ListenerBlock41 wrapListenerBlock_ObjCBlock_ffiVoid_bool_NSError(ListenerBlock41 block) {
  ListenerBlock41 wrapper = [^void(BOOL arg0, NSError *arg1) {
    block(arg0, [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock42)(AVMutableVideoComposition *, NSError *);
ListenerBlock42 wrapListenerBlock_ObjCBlock_ffiVoid_AVMutableVideoComposition_NSError(
    ListenerBlock42 block) {
  ListenerBlock42 wrapper = [^void(AVMutableVideoComposition *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock43)(AUAudioUnit *, NSError *);
ListenerBlock43 wrapListenerBlock_ObjCBlock_ffiVoid_AUAudioUnit_NSError(ListenerBlock43 block) {
  ListenerBlock43 wrapper = [^void(AUAudioUnit *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock44)(AUParameter *, float);
ListenerBlock44 wrapListenerBlock_ObjCBlock_ffiVoid_AUParameter_ffiFloat(ListenerBlock44 block) {
  ListenerBlock44 wrapper = [^void(AUParameter *arg0, float arg1) {
    block([arg0 retain], arg1);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock45)(uint8_t, uint8_t, MIDICIProfile *, BOOL);
ListenerBlock45 wrapListenerBlock_ObjCBlock_ffiVoid_Uint8_Uint8_MIDICIProfile_bool(
    ListenerBlock45 block) {
  ListenerBlock45 wrapper = [^void(uint8_t arg0, uint8_t arg1, MIDICIProfile *arg2, BOOL arg3) {
    block(arg0, arg1, [arg2 retain], arg3);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock46)(AVCompositionTrack *, NSError *);
ListenerBlock46 wrapListenerBlock_ObjCBlock_ffiVoid_AVCompositionTrack_NSError(
    ListenerBlock46 block) {
  ListenerBlock46 wrapper = [^void(AVCompositionTrack *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock47)(AVMutableCompositionTrack *, NSError *);
ListenerBlock47 wrapListenerBlock_ObjCBlock_ffiVoid_AVMutableCompositionTrack_NSError(
    ListenerBlock47 block) {
  ListenerBlock47 wrapper = [^void(AVMutableCompositionTrack *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock48)(AVMovieTrack *, NSError *);
ListenerBlock48 wrapListenerBlock_ObjCBlock_ffiVoid_AVMovieTrack_NSError(ListenerBlock48 block) {
  ListenerBlock48 wrapper = [^void(AVMovieTrack *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock49)(AVMutableMovieTrack *, NSError *);
ListenerBlock49 wrapListenerBlock_ObjCBlock_ffiVoid_AVMutableMovieTrack_NSError(
    ListenerBlock49 block) {
  ListenerBlock49 wrapper = [^void(AVMutableMovieTrack *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock50)(AVFragmentedMovieTrack *, NSError *);
ListenerBlock50 wrapListenerBlock_ObjCBlock_ffiVoid_AVFragmentedMovieTrack_NSError(
    ListenerBlock50 block) {
  ListenerBlock50 wrapper = [^void(AVFragmentedMovieTrack *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock51)(AVAudioPCMBuffer *, AVAudioTime *);
ListenerBlock51 wrapListenerBlock_ObjCBlock_ffiVoid_AVAudioPCMBuffer_AVAudioTime(
    ListenerBlock51 block) {
  ListenerBlock51 wrapper = [^void(AVAudioPCMBuffer *arg0, AVAudioTime *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock52)(AVAudioUnit *, NSError *);
ListenerBlock52 wrapListenerBlock_ObjCBlock_ffiVoid_AVAudioUnit_NSError(ListenerBlock52 block) {
  ListenerBlock52 wrapper = [^void(AVAudioUnit *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock53)(AVMusicEvent *, double *, BOOL *);
ListenerBlock53 wrapListenerBlock_ObjCBlock_ffiVoid_AVMusicEvent_ffiDouble_bool(
    ListenerBlock53 block) {
  ListenerBlock53 wrapper = [^void(AVMusicEvent *arg0, double *arg1, BOOL *arg2) {
    block([arg0 retain], arg1, arg2);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock54)(AVMusicTrack *, NSData *, double);
ListenerBlock54 wrapListenerBlock_ObjCBlock_ffiVoid_AVMusicTrack_NSData_ffiDouble(
    ListenerBlock54 block) {
  ListenerBlock54 wrapper = [^void(AVMusicTrack *arg0, NSData *arg1, double arg2) {
    block([arg0 retain], [arg1 retain], arg2);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock55)(struct opaqueCMSampleBuffer *, NSError *);
ListenerBlock55 wrapListenerBlock_ObjCBlock_ffiVoid_opaqueCMSampleBuffer_NSError(
    ListenerBlock55 block) {
  ListenerBlock55 wrapper = [^void(struct opaqueCMSampleBuffer *arg0, NSError *arg1) {
    block(arg0, [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock56)(struct opaqueCMSampleBuffer *,
                                AVCaptureBracketedStillImageSettings *, NSError *);
ListenerBlock56
wrapListenerBlock_ObjCBlock_ffiVoid_opaqueCMSampleBuffer_AVCaptureBracketedStillImageSettings_NSError(
    ListenerBlock56 block) {
  ListenerBlock56 wrapper = [^void(struct opaqueCMSampleBuffer *arg0,
                                   AVCaptureBracketedStillImageSettings *arg1, NSError *arg2) {
    block(arg0, [arg1 retain], [arg2 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock57)(NSNotification *);
ListenerBlock57 wrapListenerBlock_ObjCBlock_ffiVoid_NSNotification(ListenerBlock57 block) {
  ListenerBlock57 wrapper = [^void(NSNotification *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock58)(NSRunningApplication *, NSError *);
ListenerBlock58 wrapListenerBlock_ObjCBlock_ffiVoid_NSRunningApplication_NSError(
    ListenerBlock58 block) {
  ListenerBlock58 wrapper = [^void(NSRunningApplication *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock59)(NSDictionary *, NSError *);
ListenerBlock59 wrapListenerBlock_ObjCBlock_ffiVoid_NSDictionary_NSError1(ListenerBlock59 block) {
  ListenerBlock59 wrapper = [^void(NSDictionary *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock60)(NSWorkspaceAuthorization *, NSError *);
ListenerBlock60 wrapListenerBlock_ObjCBlock_ffiVoid_NSWorkspaceAuthorization_NSError(
    ListenerBlock60 block) {
  ListenerBlock60 wrapper = [^void(NSWorkspaceAuthorization *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock61)(NSPersistentStoreDescription *, NSError *);
ListenerBlock61 wrapListenerBlock_ObjCBlock_ffiVoid_NSPersistentStoreDescription_NSError(
    ListenerBlock61 block) {
  ListenerBlock61 wrapper = [^void(NSPersistentStoreDescription *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock62)(void (^)());
ListenerBlock62 wrapListenerBlock_ObjCBlock_ffiVoid_ffiVoid(ListenerBlock62 block) {
  ListenerBlock62 wrapper = [^void(void (^arg0)()) {
    block([arg0 copy]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock63)(void (^)());
ListenerBlock63 wrapListenerBlock_ObjCBlock_ffiVoid_ffiVoid1(ListenerBlock63 block) {
  ListenerBlock63 wrapper = [^void(void (^arg0)()) {
    block([arg0 copy]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock64)(NSWindow *, NSError *);
ListenerBlock64 wrapListenerBlock_ObjCBlock_ffiVoid_NSWindow_NSError(ListenerBlock64 block) {
  ListenerBlock64 wrapper = [^void(NSWindow *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock65)(NSWindow *, BOOL *);
ListenerBlock65 wrapListenerBlock_ObjCBlock_ffiVoid_NSWindow_bool(ListenerBlock65 block) {
  ListenerBlock65 wrapper = [^void(NSWindow *arg0, BOOL *arg1) {
    block([arg0 retain], arg1);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock66)(NSDocument *, BOOL, NSError *);
ListenerBlock66 wrapListenerBlock_ObjCBlock_ffiVoid_NSDocument_bool_NSError(ListenerBlock66 block) {
  ListenerBlock66 wrapper = [^void(NSDocument *arg0, BOOL arg1, NSError *arg2) {
    block([arg0 retain], arg1, [arg2 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock67)(NSSliderAccessory *);
ListenerBlock67 wrapListenerBlock_ObjCBlock_ffiVoid_NSSliderAccessory(ListenerBlock67 block) {
  ListenerBlock67 wrapper = [^void(NSSliderAccessory *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock68)(long, NSArray *, NSOrthography *, long);
ListenerBlock68 wrapListenerBlock_ObjCBlock_ffiVoid_ffiLong_NSArray_NSOrthography_ffiLong(
    ListenerBlock68 block) {
  ListenerBlock68 wrapper = [^void(long arg0, NSArray *arg1, NSOrthography *arg2, long arg3) {
    block(arg0, [arg1 retain], [arg2 retain], arg3);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock69)(long, NSArray *);
ListenerBlock69 wrapListenerBlock_ObjCBlock_ffiVoid_ffiLong_NSArray(ListenerBlock69 block) {
  ListenerBlock69 wrapper = [^void(long arg0, NSArray *arg1) {
    block(arg0, [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock70)(NSString *);
ListenerBlock70 wrapListenerBlock_ObjCBlock_ffiVoid_NSString(ListenerBlock70 block) {
  ListenerBlock70 wrapper = [^void(NSString *arg0) {
    block([arg0 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock71)(NSTableRowView *, long);
ListenerBlock71 wrapListenerBlock_ObjCBlock_ffiVoid_NSTableRowView_ffiLong(ListenerBlock71 block) {
  ListenerBlock71 wrapper = [^void(NSTableRowView *arg0, long arg1) {
    block([arg0 retain], arg1);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock72)(CKRecord *, NSError *);
ListenerBlock72 wrapListenerBlock_ObjCBlock_ffiVoid_CKRecord_NSError(ListenerBlock72 block) {
  ListenerBlock72 wrapper = [^void(CKRecord *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock73)(CKRecordID *, NSError *);
ListenerBlock73 wrapListenerBlock_ObjCBlock_ffiVoid_CKRecordID_NSError(ListenerBlock73 block) {
  ListenerBlock73 wrapper = [^void(CKRecordID *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock74)(CKRecordZone *, NSError *);
ListenerBlock74 wrapListenerBlock_ObjCBlock_ffiVoid_CKRecordZone_NSError(ListenerBlock74 block) {
  ListenerBlock74 wrapper = [^void(CKRecordZone *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock75)(CKRecordZoneID *, NSError *);
ListenerBlock75 wrapListenerBlock_ObjCBlock_ffiVoid_CKRecordZoneID_NSError(ListenerBlock75 block) {
  ListenerBlock75 wrapper = [^void(CKRecordZoneID *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock76)(CKSubscription *, NSError *);
ListenerBlock76 wrapListenerBlock_ObjCBlock_ffiVoid_CKSubscription_NSError(ListenerBlock76 block) {
  ListenerBlock76 wrapper = [^void(CKSubscription *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}

typedef void (^ListenerBlock77)(NSString *, NSError *);
ListenerBlock77 wrapListenerBlock_ObjCBlock_ffiVoid_NSString_NSError(ListenerBlock77 block) {
  ListenerBlock77 wrapper = [^void(NSString *arg0, NSError *arg1) {
    block([arg0 retain], [arg1 retain]);
  } copy];
  [block release];
  return wrapper;
}
