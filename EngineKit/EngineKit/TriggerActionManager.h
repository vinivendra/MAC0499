

#import "Gestures.h"
#import "Common.h"
#import "ActionCollection.h"
#import "Item.h"


@protocol TriggerActionManagerExport <JSExport>
@property (nonatomic, strong) ActionCollection *actions;
- (void)addAction:(JSValue *)function forTrigger:(NSDictionary *)dictionary;
- (void)registerAction:(JSValue *)function;
@end


@interface TriggerActionManager : NSObject <CallbackDelegate,
TriggerActionManagerExport>
// TODO: doc
@property (nonatomic, strong) ActionCollection *actions;
@property (nonatomic, strong) NSMutableDictionary <id<NSCopying>,
ActionCollection *> *items;

- (NSArray *)actionsForItem:(Item *)item
                    gesture:(UIGestures)gesture
                      state:(UIGestureRecognizerState)state
                    touches:(NSInteger)touches;
- (NSArray *)actionsForGesture:(UIGestures)gesture
                         state:(UIGestureRecognizerState)state
                       touches:(NSInteger)touches;

- (NSString *)writeToFile;

- (void)addAction:(JSValue *)function forTrigger:(NSDictionary *)dictionary;

- (NSString *)triggerForGesture:(UIGestures)gesture
                          state:(UIGestureRecognizerState)state
                        touches:(int)touches;

- (void)addJSValue:(JSValue *)value
        forTrigger:(NSString *)trigger;
- (void)addMethodAction:(MethodAction *)action
             forTrigger:(NSString *)trigger;
- (void)addMethodAction:(MethodAction *)action
                 toItem:(Item *)item
             forTrigger:(NSString *)trigger;

- (void)registerAction:(JSValue *)function;
+ (NSArray *)registeredActions;

// TODO: fix this doc
/*!
 Calls the calback function for handling the given `gesture` in javascript.

 The function name is built based on the name of the gesture. Some gestures have
 longer durations (i.e. pans, that can last several seconds, as opposed to taps,
 which only last an instant). In those cases, three funtions may be createdto
 reflect the change in state.

 - `tap()`

 - `swipe(direction)`

 - `panBegan(translation)`

 - `pan(translation)`

 - `panEnded(translation)`

 - `pinchBegan(scale)`

 - `pinch(scale)`

 - `pinchEnded(scale)`

 - `rotateBegan(angle)`

 - `rotate(angle)`

 - `rotateEnded(angle)`

 - `longPressBegan(translation)`

 - `longPress(translation)`

 - `longPressEnded(translation)`

 The `direction` parameter is an integer and may be one of either `up`, `down`,
 `left` or `right`. The `translation` parameter is a Vector and measures how
 many screen points the finger has moved since the last call to that function.
 The `scale` parameter is a floating point number and measures the ratio of the
 distance between the fingers now and at the moment of the last call to that
 function. The `angle` parameter is a floating point number and measures, in
 radians, how much the fingers have rotated since the last call to that
 function.

 The above functions may also add other parameters after the ones mentioned
 above, as follows in the example:

 - `swipe(direction, items, numberOfTouches, hits)`

 Not all paramaters need to be added, but a parameter can't be added without the
 ones before it being added as well. The `items` parameter is an array of `Item`
 objects representing the `Item`s that are in the center of the gesture. The
 numberOfTouches parameter is an integer representing how many fingers are on
 the screen. The `hits` parameter is an array of `SCNHitTestResult` objects,
 which may give more information on where and how the `Item`s were hit by the
 gesture.
 */
- (void)callGestureCallbackForGesture:(UIGestures)gesture
                                state:(UIGestureRecognizerState)state
                              touches:(int)touches
                        withArguments:(NSArray *)arguments;
- (void)callUICallbackForView:(UIView *)view
                       ofType:(UIType)type;
@end
