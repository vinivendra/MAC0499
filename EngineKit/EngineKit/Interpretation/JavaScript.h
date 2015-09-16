

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

#import "Gestures.h"
#import "UI.h"
#import "Camera.h"


/*!
 A JavaScript manager class, used to handle the interaction between the
 Objective-C game architecture and the JavaScript code.
 */
@interface JavaScript : NSObject <GestureDelegate, UICallbackHandler>
// TODO: doc
/*!
 Initializes all needed JavaScript data and runs the file determined by the
 given @p filename, executing the code in its global scope and setting up
 default functions (such as @p load and @p update).
 @param filename A path to the file, relative to the project's folder. If the
 file is in the project's folder itself, this string would only be the file's
 name.
 @return An initialized JavaScript object set up to handle the given file.
 */
- (instancetype)initWithFile:(NSString *)filename camera:(Camera *)camera UI:(UI *)ui;
@property (nonatomic, weak) UI *ui;
/*!
 Sets up the framework for use in the Javascript code, runs the global code and
 loads the necessary functions (such as @p load and @p update) so that they are
 ready to be called.
 @warning this method is called automatically by @p -initWithFile and @p -init,
 so there should be no need to call it manually.
 */
- (void)setup;
/*!
 Calls the @p load function in the JavaScript code, if it exists.
 */
- (void)load;
/*!
 Calls the @p update function in the JavaSript code, if it exists.
 */
- (void)update;
/*!
 Returns the current callback function for contact handling in javascript. It
 should be a function called "contact" or a variable, with the same name, that
 contains the function to be called.
 @return An JSValue, hopefully containing the callback function to be called (if
 the JavaScript code is correct); if there is no such function or variable, the
 JSValue returned will be undefined.
 */
@property (nonatomic, readonly, strong) JSValue *contactCallback;
/*!
 Returns the current callback function for handling button presses in
 javascript. It should be a function called "button" or a variable, with the
 same name, that contains the function to be called.
 @return An JSValue, hopefully containing the callback function to be called (if
 the JavaScript code is correct); if there is no such function or variable, the
 JSValue returned will be undefined.
 */
@property (nonatomic, readonly, strong) JSValue *buttonCallback;
/*!
 Returns the current callback function for handling slider value changes in
 javascript. It should be a function called "slider" or a variable, with the
 same name, that contains the function to be called.
 @return An JSValue, hopefully containing the callback function to be called (if
 the JavaScript code is correct); if there is no such function or variable, the
 JSValue returned will be undefined.
 */
@property (nonatomic, readonly, strong) JSValue *sliderCallback;
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
                        withArguments:(NSArray *)arguments;
@end
