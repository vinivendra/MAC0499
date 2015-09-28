// TODO: Add a pinch gesture for zoom.

#import "TriggerActionManager.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "NSArray+Extension.h"
#import "MethodAction.h"
#import "FunctionAction.h"
#import "NSNumber+Extension.h"


NSDictionary *gestureEnumConversion;
NSDictionary *stateEnumConversion;


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

- (NSArray *)actionsForItem:(Item *)item
                    gesture:(UIGestures)gesture
                      state:(UIGestureRecognizerState)state
                    touches:(NSInteger)touches {
    return [self.items[@(item.hash)]
            actionsForKey:[self triggerForGesture:gesture
                                            state:state
                                          touches:touches]];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Gestures CallbackDelegate

- (void)callGestureCallbackForGesture:(UIGestures)gesture
                                state:(UIGestureRecognizerState)state
                              touches:(NSInteger)touches
                        withArguments:(NSArray *)arguments {
    if (arguments.count > 0) {
        NSArray *items = arguments[0];
        if (items.count > 0) {
            Item *item = items[0];

            NSArray *actions = [self actionsForItem:item
                                            gesture:gesture
                                              state:state
                                            touches:touches];

            for (NSInteger i = 0; i < actions.count; i++) {
                MethodAction *action = actions[i];
                [action callWithArguments:arguments];
            }
        }
    }

    NSArray *actions = [self.actions
                        actionsForKey:[self triggerForGesture:gesture
                                                        state:state
                                                      touches:touches]];
    for (NSInteger i = 0; i < actions.count; i++) {
        MethodAction *action = actions[i];
        [action callWithArguments:arguments];
    }
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - UI Delegate

- (void)callUICallbackForView:(UIView *)view
                       ofType:(UIType)type {
#warning Not implemented
}

- (MethodAction *)actionForUIViewOfType:(UIType)type {
    return nil;
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Export

- (void)addAction:(JSValue *)function forTrigger:(NSDictionary *)dictionary {

    NSString *gestureString = dictionary[@"gesture"];

    if (gestureString) {
        UIGestures gesture = [self gestureForString:gestureString];

        UIGestureRecognizerState state = [self
                                          stateForString:dictionary[@"state"]
                                          gesture:gesture];

        NSInteger touches = [self
                             numberOfTouchesForNumber:dictionary[@"touches"]];

        NSString *trigger = [self triggerForGesture:gesture
                                              state:state
                                            touches:touches];

        [self addJSValue:function forTrigger:trigger];
    }
}

- (UIGestures)gestureForString:(NSString *)string {
    if (!gestureEnumConversion) {
        gestureEnumConversion = @{@"swipe": @(SwipeGesture),
                                  @"tap": @(TapGesture),
                                  @"pan": @(PanGesture),
                                  @"pinch": @(PinchGesture),
                                  @"rotate": @(RotateGesture),
                                  @"longpress": @(LongPressGesture)};
    }

    NSNumber *gestureNumber = gestureEnumConversion[string];
    UIGestures gestureEnum = gestureNumber.unsignedIntegerValue;

    return gestureEnum;
}

- (UIGestureRecognizerState)stateForString:(NSString *)string
                                   gesture:(UIGestures)gesture {
    if (!stateEnumConversion) {
        stateEnumConversion = @{@"beagn": @(UIGestureRecognizerStateBegan),
                                @"ended": @(UIGestureRecognizerStateEnded),
                                @"recognized": @(UIGestureRecognizerStateRecognized),
                                @"changed": @(UIGestureRecognizerStateChanged)};
    }

    NSNumber *stateNumber = stateEnumConversion[string];

    UIGestureRecognizerState stateEnum;

    if (!stateNumber) {
        if (gesture == TapGesture || gesture == SwipeGesture) {
            stateEnum = UIGestureRecognizerStateRecognized;
        }
        else {
            stateEnum = UIGestureRecognizerStateChanged;
        }
    }
    else {
        stateEnum = stateNumber.unsignedIntegerValue;
    }

    return stateEnum;
}

- (NSInteger)numberOfTouchesForNumber:(NSNumber *)object {
    NSInteger touches;

    if (!object) {
        touches = 1;
    }
    else {
        touches = object.integerValue;
    }

    return touches;
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Interface

- (NSString *)triggerForGesture:(UIGestures)gesture
                          state:(UIGestureRecognizerState)state
                        touches:(NSInteger)touches {

    return [NSString stringWithFormat:@"triggerGesture%d-%d-%d",
            gesture, state, touches];
}


- (void)addJSValue:(JSValue *)value
        forTrigger:(NSString *)trigger {
    FunctionAction *action = [[FunctionAction alloc] initWithJSValue:value
                                                           arguments:nil];
    [self addMethodAction:action forTrigger:trigger];
}

- (void)addMethodAction:(MethodAction *)action
             forTrigger:(NSString *)trigger {
    [self.actions addAction:action forKey:trigger];
}

- (void)addMethodAction:(MethodAction *)action
                 toItem:(Item *)item
             forTrigger:(NSString *)trigger {
    ActionCollection *collection = self.items[@(item.hash)];
    if (!collection) {
        collection = [ActionCollection new];
        self.items[@(item.hash)] = collection;
    }
    
    [collection addAction:action forKey:trigger];
}


@end
