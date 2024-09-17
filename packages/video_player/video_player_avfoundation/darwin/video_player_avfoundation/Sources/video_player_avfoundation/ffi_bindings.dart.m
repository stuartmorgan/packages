#include <stdint.h>
#import "include/video_player_avfoundation/FFIHeaders.h"
#import "include/video_player_avfoundation/FVPBlockKeyValueObserver.h"
#import "include/video_player_avfoundation/FVPDisplayLink.h"
#import "include/video_player_avfoundation/FVPFrameUpdater.h"
#import "include/video_player_avfoundation/FVPPluginAPIProxy.h"
#import "include/video_player_avfoundation/FVPVideoPlayer.h"

#if !__has_feature(objc_arc)
#error "This file must be compiled with ARC enabled"
#endif

id objc_retain(id);
id objc_retainBlock(id);

typedef void (^_ListenerTrampoline)(id arg0);
_ListenerTrampoline _wrapListenerBlock_285c7346(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    block(objc_retain(arg0));
  };
}

typedef void (^_ListenerTrampoline1)(id arg0, struct _NSRange arg1, BOOL *arg2);
_ListenerTrampoline1 _wrapListenerBlock_3e9386eb(_ListenerTrampoline1 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void (^_ListenerTrampoline2)(id arg0, BOOL arg1, BOOL *arg2);
_ListenerTrampoline2 _wrapListenerBlock_28d78a0c(_ListenerTrampoline2 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void (^_ListenerTrampoline3)(id arg0, id arg1);
_ListenerTrampoline3 _wrapListenerBlock_13466199(_ListenerTrampoline3 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    block(objc_retain(arg0), objc_retain(arg1));
  };
}

typedef void (^_ListenerTrampoline4)(id arg0, NSMatchingFlags arg1, BOOL *arg2);
_ListenerTrampoline4 _wrapListenerBlock_24c57ca6(_ListenerTrampoline4 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, NSMatchingFlags arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void (^_ListenerTrampoline5)(id arg0, id arg1, id arg2);
_ListenerTrampoline5 _wrapListenerBlock_1ef5fe09(_ListenerTrampoline5 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    block(objc_retain(arg0), objc_retain(arg1), objc_retain(arg2));
  };
}

typedef void (^_ListenerTrampoline6)(id arg0, BOOL arg1, id arg2);
_ListenerTrampoline6 _wrapListenerBlock_281cde6a(_ListenerTrampoline6 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1, id arg2) {
    block(objc_retain(arg0), arg1, objc_retain(arg2));
  };
}

typedef void (^_ListenerTrampoline7)(CMTime arg0, id arg1);
_ListenerTrampoline7 _wrapListenerBlock_2eb8229f(_ListenerTrampoline7 block) NS_RETURNS_RETAINED {
  return ^void(CMTime arg0, id arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^_ListenerTrampoline8)(int32_t arg0, id arg1);
_ListenerTrampoline8 _wrapListenerBlock_140eb8ec(_ListenerTrampoline8 block) NS_RETURNS_RETAINED {
  return ^void(int32_t arg0, id arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^_ListenerTrampoline9)(int64_t arg0, id arg1);
_ListenerTrampoline9 _wrapListenerBlock_1389564b(_ListenerTrampoline9 block) NS_RETURNS_RETAINED {
  return ^void(int64_t arg0, id arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^_ListenerTrampoline10)(BOOL arg0, id arg1);
_ListenerTrampoline10 _wrapListenerBlock_1f95e20d(_ListenerTrampoline10 block) NS_RETURNS_RETAINED {
  return ^void(BOOL arg0, id arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^_ListenerTrampoline11)(id arg0, float arg1);
_ListenerTrampoline11 _wrapListenerBlock_22929f1e(_ListenerTrampoline11 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, float arg1) {
    block(objc_retain(arg0), arg1);
  };
}

typedef void (^_ListenerTrampoline12)(uint8_t arg0, uint8_t arg1, id arg2, BOOL arg3);
_ListenerTrampoline12 _wrapListenerBlock_1ed4186f(_ListenerTrampoline12 block) NS_RETURNS_RETAINED {
  return ^void(uint8_t arg0, uint8_t arg1, id arg2, BOOL arg3) {
    block(arg0, arg1, objc_retain(arg2), arg3);
  };
}

typedef void (^_ListenerTrampoline13)(id arg0, double *arg1, BOOL *arg2);
_ListenerTrampoline13 _wrapListenerBlock_2e8c8c43(_ListenerTrampoline13 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, double *arg1, BOOL *arg2) {
    block(objc_retain(arg0), arg1, arg2);
  };
}

typedef void (^_ListenerTrampoline14)(id arg0, id arg1, double arg2);
_ListenerTrampoline14 _wrapListenerBlock_2c09db6e(_ListenerTrampoline14 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, double arg2) {
    block(objc_retain(arg0), objc_retain(arg1), arg2);
  };
}

typedef void (^_ListenerTrampoline15)(struct opaqueCMSampleBuffer *arg0, id arg1);
_ListenerTrampoline15 _wrapListenerBlock_c43095b(_ListenerTrampoline15 block) NS_RETURNS_RETAINED {
  return ^void(struct opaqueCMSampleBuffer *arg0, id arg1) {
    block(arg0, objc_retain(arg1));
  };
}

typedef void (^_ListenerTrampoline16)(struct opaqueCMSampleBuffer *arg0, id arg1, id arg2);
_ListenerTrampoline16 _wrapListenerBlock_2019a82d(_ListenerTrampoline16 block) NS_RETURNS_RETAINED {
  return ^void(struct opaqueCMSampleBuffer *arg0, id arg1, id arg2) {
    block(arg0, objc_retain(arg1), objc_retain(arg2));
  };
}
