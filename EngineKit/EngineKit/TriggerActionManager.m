

#import "TriggerActionManager.h"
#import <JavaScriptCore/JavaScriptCore.h>

@implementation TriggerActionManager

- (instancetype)init {
    if (self = [super init]) {
        self.actions = [NSMutableDictionary new];
    }

    return self;
}

- (JSValue *)actionForGesture:(UIGestures)gesture
                        state:(UIGestureRecognizerState)state {
    static NSMutableArray *gestureCallbacks;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      gestureCallbacks =
                      [NSMutableArray arrayWithCapacity:6];

                      NSMutableArray *tapArray = [NSMutableArray arrayWithCapacity:1];
                      NSMutableArray *swipeArray = [NSMutableArray arrayWithCapacity:1];
                      NSMutableArray *panArray = [NSMutableArray arrayWithCapacity:6];
                      NSMutableArray *pinchArray = [NSMutableArray arrayWithCapacity:6];
                      NSMutableArray *rotateArray = [NSMutableArray arrayWithCapacity:6];
                      NSMutableArray *longPressArray = [NSMutableArray arrayWithCapacity:6];

                      long int max = MAX(MAX(MAX(UIGestureRecognizerStateRecognized,
                                                 UIGestureRecognizerStateEnded),
                                             UIGestureRecognizerStateBegan),
                                         UIGestureRecognizerStateBegan);
                      for (long int i = 0; i < max + 1; i++) {
                          tapArray[i] = [NSNull null];
                          swipeArray[i] = [NSNull null];
                          panArray[i] = [NSNull null];
                          pinchArray[i] = [NSNull null];
                          rotateArray[i] = [NSNull null];
                          longPressArray[i] = [NSNull null];
                      }
                      for (int i = 0; i < UIGesturesCount; i++) {
                          gestureCallbacks[i] = [NSNull null];
                      }

                      tapArray[UIGestureRecognizerStateRecognized] = triggerTap;
                      swipeArray[UIGestureRecognizerStateRecognized] = triggerSwipe;
                      panArray[UIGestureRecognizerStateBegan] = triggerPanBegan;
                      panArray[UIGestureRecognizerStateChanged] = triggerPan;
                      panArray[UIGestureRecognizerStateEnded] = triggerPanEnded;
                      pinchArray[UIGestureRecognizerStateBegan] = triggerPinchBegan;
                      pinchArray[UIGestureRecognizerStateChanged] = triggerPinch;
                      pinchArray[UIGestureRecognizerStateEnded] = triggerPinchEnded;
                      rotateArray[UIGestureRecognizerStateBegan] = triggerRorateBegan;
                      rotateArray[UIGestureRecognizerStateChanged]
                      = triggerRotate;
                      rotateArray[UIGestureRecognizerStateEnded] = triggerRotateEnded;
                      longPressArray[UIGestureRecognizerStateBegan]
                      = triggerLongPressBegan;
                      longPressArray[UIGestureRecognizerStateChanged]
                      = triggerLongPress;
                      longPressArray[UIGestureRecognizerStateEnded]
                      = triggerLongPressEnded;
                      
                      gestureCallbacks[TapGesture] = tapArray;
                      gestureCallbacks[SwipeGesture] = swipeArray;
                      gestureCallbacks[PanGesture] = panArray;
                      gestureCallbacks[PinchGesture] = pinchArray;
                      gestureCallbacks[RotateGesture] = rotateArray;
                      gestureCallbacks[LongPressGesture] = longPressArray;
                  });

    return self.actions[gestureCallbacks[gesture][state]];
}

- (void)callGestureCallbackForGesture:(UIGestures)gesture
                                state:(UIGestureRecognizerState)state
                        withArguments:(NSArray *)arguments {
    JSValue *action = [self actionForGesture:gesture state:state];
    [action callWithArguments:arguments];
}

@end
