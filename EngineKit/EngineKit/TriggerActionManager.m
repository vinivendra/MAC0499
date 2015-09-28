// TODO: Add a pinch gesture for zoom.

#import "TriggerActionManager.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "NSArray+Extension.h"
#import "MethodAction.h"
#import "FunctionAction.h"


static NSMutableArray *gestureCallbacks;


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation TriggerActionManager

- (instancetype)init {
    if (self = [super init]) {
        self.actions = [ActionCollection new];
        self.items = [NSMutableDictionary new];
    }

    return self;
}

- (NSString *)keyForGesture:(UIGestures)gesture
                      state:(UIGestureRecognizerState)state {

    if (! gestureCallbacks) {
        gestureCallbacks =
        [NSMutableArray arrayWithCapacity:UIGesturesCount];

        UIGestureRecognizerState recognized = UIGestureRecognizerStateRecognized;
        UIGestureRecognizerState began = UIGestureRecognizerStateBegan;
        UIGestureRecognizerState ended = UIGestureRecognizerStateEnded;
        UIGestureRecognizerState changed = UIGestureRecognizerStateChanged;

        long int max;
        max = MAX(MAX(MAX(recognized, ended), began), changed) + 1;

        NSMutableArray *tapArray       = [NSMutableArray
                                          arrayWithCapacity:max];
        NSMutableArray *swipeArray     = [NSMutableArray
                                          arrayWithCapacity:max];
        NSMutableArray *panArray       = [NSMutableArray
                                          arrayWithCapacity:max];
        NSMutableArray *pinchArray     = [NSMutableArray
                                          arrayWithCapacity:max];
        NSMutableArray *rotateArray    = [NSMutableArray
                                          arrayWithCapacity:max];
        NSMutableArray *longPressArray = [NSMutableArray
                                          arrayWithCapacity:max];

        for (long int i = 0; i < max; i++) {
            [tapArray addObject:[NSNull null]];
            [swipeArray addObject:[NSNull null]];;
            [panArray addObject:[NSNull null]];;
            [pinchArray addObject:[NSNull null]];;
            [rotateArray addObject:[NSNull null]];;
            [longPressArray addObject:[NSNull null]];;
        }
        for (int i = 0; i < UIGesturesCount; i++) {
            [gestureCallbacks addObject:[NSNull null]];;
        }

        tapArray[recognized]    = triggerTap;
        swipeArray[recognized]  = triggerSwipe;
        panArray[began]         = triggerPanBegan;
        panArray[changed]       = triggerPan;
        panArray[ended]         = triggerPanEnded;
        pinchArray[began]       = triggerPinchBegan;
        pinchArray[changed]     = triggerPinch;
        pinchArray[ended]       = triggerPinchEnded;
        rotateArray[began]      = triggerRorateBegan;
        rotateArray[changed]    = triggerRotate;
        rotateArray[ended]      = triggerRotateEnded;
        longPressArray[began]   = triggerLongPressBegan;
        longPressArray[changed] = triggerLongPress;
        longPressArray[ended]   = triggerLongPressEnded;

        gestureCallbacks[TapGesture]       = tapArray;
        gestureCallbacks[SwipeGesture]     = swipeArray;
        gestureCallbacks[PanGesture]       = panArray;
        gestureCallbacks[PinchGesture]     = pinchArray;
        gestureCallbacks[RotateGesture]    = rotateArray;
        gestureCallbacks[LongPressGesture] = longPressArray;
    }

    return gestureCallbacks[gesture][state];
}

- (NSArray *)actionsForItem:(Item *)item
                    gesture:(UIGestures)gesture
                      state:(UIGestureRecognizerState)state {
    return [self.items[@(item.hash)] actionsForKey:[self keyForGesture:gesture
                                                                 state:state]];
}

- (void)callGestureCallbackForGesture:(UIGestures)gesture
                                state:(UIGestureRecognizerState)state
                        withArguments:(NSArray *)arguments {
    if (arguments.count > 0) {
        NSArray *items = arguments[0];
        if (items.count > 0) {
            Item *item = items[0];

            NSArray *actions = [self actionsForItem:item
                                            gesture:gesture
                                              state:state];

            for (int i = 0; i < actions.count; i++) {
                MethodAction *action = actions[i];
                [action callWithArguments:arguments];
            }
        }
    }

    NSArray *actions = [self.actions actionsForKey:[self keyForGesture:gesture
                                                                 state:state]];
    for (int i = 0; i < actions.count; i++) {
        MethodAction *action = actions[i];
        [action callWithArguments:arguments];
    }
}

- (void)addJSValue:(JSValue *)value
        forTrigger:(NSString *)trigger {
    FunctionAction *action = [[FunctionAction alloc] initWithJSValue:value
                                                           arguments:nil];
    [self addAction:action forTrigger:trigger];
}

- (void)addAction:(MethodAction *)action
       forTrigger:(NSString *)trigger {
    [self.actions addAction:action forKey:trigger];
}

- (void)addAction:(MethodAction *)action
          toItem:(Item *)item
       forTrigger:(NSString *)trigger {
    ActionCollection *collection = self.items[@(item.hash)];
    if (!collection) {
        collection = [ActionCollection new];
        self.items[@(item.hash)] = collection;
    }

    [collection addAction:action forKey:trigger];
}

- (MethodAction *)actionForUIViewOfType:(UIType)type {
//    static NSMutableArray *UICallbacks;
//
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken,
//                  ^{
//                      UICallbacks = [NSMutableArray arrayWithCapacity:UITypeCount];
//
//                      for (int i = 0; i < UITypeCount; i++) {
//                          UICallbacks[i] = [NSNull null];
//                      }
//
//                      UICallbacks[Button] = @"buttonPressed";
//                      UICallbacks[Slider] = @"sliderPressed";
//                  });
//    
//    return self.actions[UICallbacks[type]];
    return nil;
}

- (void)callUICallbackForView:(UIView *)view
                       ofType:(UIType)type {
#warning Not implemented
}

@end
