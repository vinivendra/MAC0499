  // TODO: Add a pinch gesture for zoom.

#import "TriggerActionManager.h"

#import <JavaScriptCore/JavaScriptCore.h>

#import "NSArray+Extension.h"
#import "NSNumber+Extension.h"
#import "SCNScene+Extension.h"
#import "JSValue+Extension.h"
#import "ObjectiveSugar.h"

#import "SceneManager.h"

#import "MethodAction.h"
#import "FunctionAction.h"


NSDictionary *gestureEnumConversion;
NSDictionary *stateEnumConversion;

NSMutableArray <JSValue *> *registeredActions;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation TriggerActionManager

- (instancetype)init {
    if (self = [super init]) {
        self.actions = [ActionCollection new];
    }

    return self;
}

- (NSMutableArray *)actionsForItem:(Item *)item
                           gesture:(UIGestures)gesture
                             state:(UIGestureRecognizerState)state
                           touches:(NSInteger)touches {
    return [item actionsForKey:[TriggerActionManager triggerForGesture:gesture
                                                                 state:state
                                                               touches:touches]];
}

- (NSMutableArray *)actionsForGesture:(UIGestures)gesture
                                state:(UIGestureRecognizerState)state
                              touches:(NSInteger)touches {
    return [self.actions
            actionsForKey:[TriggerActionManager triggerForGesture:gesture
                                                            state:state
                                                          touches:touches]];
}

- (void)registerAction:(JSValue *)function {
    if (!registeredActions) {
        registeredActions = [NSMutableArray new];
    }

    BOOL present = NO;
    for (JSValue *action in registeredActions) {
        if ([action.functionName isEqualToString:function.functionName]) {
            present = YES;
        }
    }

    if (!present) {
        [registeredActions addObject:function];
    }
}

+ (NSArray *)registeredActions {
    return registeredActions;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Gestures CallbackDelegate

- (void)callGestureCallbackForGesture:(UIGestures)gesture
                                state:(UIGestureRecognizerState)state
                              touches:(NSInteger)touches
                        withArguments:(NSArray *)arguments {
    BOOL done = NO;

    if (arguments.count > 0) {
        NSArray *items = arguments[0];
        if (items.count > 0) {

            for (Item *item = items[0];; item = item.parent) {
                NSArray *actions = [self actionsForItem:item
                                                gesture:gesture
                                                  state:state
                                                touches:touches];

                for (NSInteger i = 0; i < actions.count; i++) {
                    done = YES;
                    MethodAction *action = actions[i];
                    [action callWithArguments:arguments];
                }

                if (done) {
                    return;
                }

                if (item == item.parent) {
                    break;
                }
            }
        }
    }

    if (done) {
        return;
    }

    NSArray *actions = [self.actions
                        actionsForKey:[TriggerActionManager
                                       triggerForGesture:gesture
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

    NSString *trigger = [TriggerActionManager triggerForDictionary:dictionary];
    MethodAction *action = [self methodActionForJSValue:function
                                             dictionary:dictionary];

    if ([action.target isKindOfClass:[Item class]]) {
        NSString *itemName = dictionary[@"item"];
        Item *item = [self.scene itemNamed:itemName];

        [self addMethodAction:action
                       toItem:item
                   forTrigger:trigger];
    }
    else {
        [self addMethodAction:action
                   forTrigger:trigger];
    }
}

+ (NSString *)triggerForDictionary:(NSDictionary *)dictionary {
    NSString *gestureString = dictionary[@"gesture"];

    if (gestureString) {
        UIGestures gesture = [Gestures gestureForString:gestureString];

        UIGestureRecognizerState state = [Gestures
                                          stateForString:dictionary[@"state"]
                                          gesture:gesture];

        NSInteger touches = [Gestures
                             numberOfTouchesForNumber:dictionary[@"touches"]
                             gesture:gesture];

        NSString *trigger = [self triggerForGesture:gesture
                                              state:state
                                            touches:touches];
        return trigger;
    }
    else {
        return nil;
    }
}

- (MethodAction *)methodActionForJSValue:(JSValue *)function
                              dictionary:(NSDictionary *)dictionary {
    NSString *itemName = dictionary[@"item"];
    Item *item = [self.scene itemNamed:itemName];

    if (item) {
        id argument = function.toObject;
        NSString *methodName;

        if ([argument isKindOfClass:[NSDictionary class]] &&
            ((NSDictionary *)argument).count == 0) {
            argument = [[FunctionAction alloc] initWithJSValue:function
                                                     arguments:nil];
            methodName = dictionary[@"action"];
        }
        else {
            argument = dictionary[@"argument"];
            methodName = function.toString;
        }



        MethodAction *action = [[MethodAction alloc]
                                initWithTarget:item
                                methodName:methodName
                                arguments:argument];
        return action;
    }
    else {
        FunctionAction *action = [[FunctionAction alloc]
                                  initWithJSValue:function
                                  arguments:nil];
        return action;
    }
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Export

- (NSString *)writeToFile {

    NSArray *statements = [self.actions javaScriptStrings];

    NSString *result = [statements join:@"\n"];

    NSLog(@"\n\n%@", result);

    return result;
}

+ (NSString *)writingStringForState:(UIGestureRecognizerState)state
                            gesture:(UIGestures)gesture {
    if (gesture == TapGesture || gesture == SwipeGesture) {
        return nil;
    }
    else {
        if (state == UIGestureRecognizerStateChanged) {
            return nil;
        }
    }

    return [Gestures stringForState:state
                            gesture:gesture];
}

+ (void)addOptionsToDictionary:(NSMutableDictionary *)options
                    forTrigger:(NSString *)trigger {

    if ([trigger containsString:@"Gesture"]) {
        NSRange range = [trigger rangeOfString:@"Gesture"];
        NSString *info = [trigger
                          substringFromIndex:range.location + range.length];

        NSArray *separatedInfo = [info split:@"-"];

        UIGestures gesture = ((NSString *)separatedInfo[0]).integerValue;
        UIGestureRecognizerState state;
        state = ((NSString *)separatedInfo[1]).integerValue;
        NSInteger touches = ((NSString *)separatedInfo[2]).integerValue;

        options[@"gesture"] = [Gestures stringForGesture:gesture];

        NSString *stateString = [TriggerActionManager
                                 writingStringForState:state
                                 gesture:gesture];
        if (stateString) {
            options[@"state"] = stateString;
        }

        NSString *touchesString = [Gestures stringForTouches:touches
                                                     gesture:gesture];
        if (touchesString) {
            options[@"touches"] = touchesString;
        }
    }
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Interface

+ (NSString *)triggerForGesture:(UIGestures)gesture
                          state:(UIGestureRecognizerState)state
                        touches:(NSInteger)touches {
    touches = [Gestures numberOfTouchesForNumber:@(touches) gesture:gesture];

    return [NSString stringWithFormat:@"triggerGesture%d-%d-%d",
            gesture, state, touches];
}

- (MethodAction *)actionNamed:(NSString *)name
                   forTrigger:(NSString *)trigger {

    JSValue *value = self.context[name];
    MethodAction *action = [self methodActionForJSValue:value
                                             dictionary:nil];

    return action;
}

- (void)addActionNamed:(NSString *)name
  forTriggerDictionary:(NSDictionary *)dictionary {

    JSValue *value = self.context[name];
    MethodAction *action = [self methodActionForJSValue:value
                                             dictionary:dictionary];

    NSString *trigger = [TriggerActionManager triggerForDictionary:dictionary];

    [self addMethodAction:action forTrigger:trigger];
}

- (void)addActionNamed:(NSString *)name
            forTrigger:(NSString *)trigger {

    MethodAction *action = [self actionNamed:name forTrigger:trigger];

    [self addMethodAction:action forTrigger:trigger];
}

- (void)addActionNamed:(NSString *)name
                toItem:(Item *)item
  forTriggerDictionary:(NSDictionary *)dictionary {
    JSValue *value = self.context[name];
    MethodAction *action = [self methodActionForJSValue:value
                                             dictionary:dictionary];

    NSString *trigger = [TriggerActionManager triggerForDictionary:dictionary];

    while (![item isEqual:item.parent]) {
        item = item.parent;
    }

    [item addAction:action forKey:trigger];
}

- (void)addActionNamed:(NSString *)name
                toItem:(Item *)item
            forTrigger:(NSString *)trigger {
    JSValue *value = self.context[name];
    MethodAction *action = [self methodActionForJSValue:value
                                             dictionary:nil];

    while (![item isEqual:item.parent]) {
        item = item.parent;
    }

    [item addAction:action forKey:trigger];
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
    [item addAction:action forKey:trigger];
}


@end
