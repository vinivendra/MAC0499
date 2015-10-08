// TODO: Add a pinch gesture for zoom.

#import "TriggerActionManager.h"

#import <JavaScriptCore/JavaScriptCore.h>

#import "NSArray+Extension.h"
#import "NSNumber+Extension.h"
#import "SCNScene+Extension.h"
#import "ObjectiveSugar.h"

#import "SceneManager.h"

#import "MethodAction.h"
#import "FunctionAction.h"


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

        NSString *itemName = dictionary[@"item"];
        Item *item = [[SceneManager currentSceneManager].scene
                      itemNamed:itemName];
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

            [self addMethodAction:action
                           toItem:item
                       forTrigger:trigger];
        }
        else {
            [self addJSValue:function forTrigger:trigger];
        }
    }
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Export

- (NSString *)writeToFile {

    NSMutableArray *statements = [NSMutableArray new];

    [self addWritingStringsForActionCollection:self.actions
                                       inArray:statements];

    for (id<NSCopying> key in self.items) {
        ActionCollection *actions = self.items[key];
        [self addWritingStringsForActionCollection:actions
                                           inArray:statements];
    }

    NSString *result = [statements join:@"\n"];

    NSLog(@"\n\n%@", result);

    return result;
}

- (void)addWritingStringsForActionCollection:(ActionCollection *)actions
                                     inArray:(NSMutableArray *)statements {
    NSMutableDictionary *arrays = actions.arrays;
    for (NSString *key in arrays) {
        NSMutableArray *array = arrays[key];
        for (MethodAction *action in array) {
            [statements addObject:[self writingStringForAction:action
                                                           key:key]];
        }
    }
}

- (NSString *)writingStringForAction:(MethodAction *)action
                               key:(NSString *)key {
    NSString *statement = action.JSString;
    NSString *triggerString = [self writingStringForTrigger:key];

    statement = [NSString stringWithFormat:@"%@%@});",
                 statement, triggerString];

    return statement;
}

- (NSString *)writingStringForTrigger:(NSString *)trigger {

    if ([trigger containsString:@"Gesture"]) {
        NSRange range = [trigger rangeOfString:@"Gesture"];
        NSString *info = [trigger
                          substringFromIndex:range.location + range.length];

        NSArray *separatedInfo = [info split:@"-"];

        UIGestures gesture = ((NSString *)separatedInfo[0]).integerValue;
        UIGestureRecognizerState state;
        state = ((NSString *)separatedInfo[1]).integerValue;
        NSInteger touches = ((NSString *)separatedInfo[2]).integerValue;

        NSString *gestureString = [NSString
                                   stringWithFormat:@"\"gesture\": \"%@\"",
                                   [Gestures stringForGesture:gesture]];

        NSString *stateString = [Gestures stringForState:state
                                                 gesture:gesture];
        if (stateString) {
            stateString = [NSString stringWithFormat:@", \"state\": \"%@\"",
                           stateString];
        }

        NSString *touchesString = [Gestures stringForTouches:touches
                                                     gesture:gesture];
        if (touchesString) {
            touchesString = [NSString stringWithFormat:@", \"touches\": \"%@\"",
                             touchesString];
        }

        NSString *result = gestureString;
        if (stateString) {
            result = [result stringByAppendingString:stateString];
        }
        if (touchesString) {
            result = [result stringByAppendingString:touchesString];
        }

        return result;
    }

    return nil;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Interface

- (NSString *)triggerForGesture:(UIGestures)gesture
                          state:(UIGestureRecognizerState)state
                        touches:(NSInteger)touches {
    touches = [Gestures numberOfTouchesForNumber:@(touches) gesture:gesture];

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
