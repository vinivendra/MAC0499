

/*!
 A JavaScript manager class, used to handle the interaction between the
 Objective-C game architecture and the JavaScript code.
 */
@interface JavaScript : NSObject
/*!
 The singleton instance of the JavaScript class. The class is meant to be used
 as a singleton and deals with other singleton instances, such as the SCNScene
 and the JSContext singletons.
 @return A singleton instance of the JavaScript class.
 */
+ (JavaScript *)shared;
/*!
 Initializes all needed JavaScript data and runs the file determined by the
 given @p filename, executing the code in its global scope and setting up
 default functions (such as @p load and @p update).
 @param filename A path to the file, relative to the project's folder. If the
 file is in the project's folder itself, this string would only be the file's
 name.
 @return An initialized JavaScript object set up to handle the given file.
 */
- (instancetype)initWithFile:(NSString *)filename;

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
- (JSValue *)contactCallback;
/*!
 Returns the current callback function for handling button presses in
 javascript. It should be a function called "button" or a variable, with the
 same name, that contains the function to be called.
 @return An JSValue, hopefully containing the callback function to be called (if
 the JavaScript code is correct); if there is no such function or variable, the
 JSValue returned will be undefined.
 */
- (JSValue *)buttonCallback;
/*!
 Returns the current callback function for handling slider value changes in
 javascript. It should be a function called "slider" or a variable, with the
 same name, that contains the function to be called.
 @return An JSValue, hopefully containing the callback function to be called (if
 the JavaScript code is correct); if there is no such function or variable, the
 JSValue returned will be undefined.
 */
- (JSValue *)sliderCallback;
/*!
 Returns the current callback function for handling taps in javascript. It
 should be a function called "tap" or a variable, with the same name, that
 contains the function to be called.
 @return An JSValue, hopefully containing the callback function to be called (if
 the JavaScript code is correct); if there is no such function or variable, the
 JSValue returned will be undefined.
 */
- (JSValue *)tapCallback;
/*!
 Returns the current callback function for handling swipes in javascript. It
 should be a function called "swipe" or a variable, with the same name, that
 contains the function to be called.
 @return An JSValue, hopefully containing the callback function to be called (if
 the JavaScript code is correct); if there is no such function or variable, the
 JSValue returned will be undefined.
 */
- (JSValue *)swipeCallback;
/*!
 Returns the current callback function for handling pans in javascript. It
 should be a function called "pan" or a variable, with the same name, that
 contains the function to be called.
 @return An JSValue, hopefully containing the callback function to be called (if
 the JavaScript code is correct); if there is no such function or variable, the
 JSValue returned will be undefined.
 */
- (JSValue *)panCallback;
/*!
 Returns the current callback function for handling pinches in javascript. It
 should be a function called "pinches" or a variable, with the same name, that
 contains the function to be called.
 @return An JSValue, hopefully containing the callback function to be called (if
 the JavaScript code is correct); if there is no such function or variable, the
 JSValue returned will be undefined.
 */
- (JSValue *)pinchCallback;
/*!
 Returns the current callback function for handling rotations in javascript. It
 should be a function called "rotation" or a variable, with the same name, that
 contains the function to be called.
 @return An JSValue, hopefully containing the callback function to be called (if
 the JavaScript code is correct); if there is no such function or variable, the
 JSValue returned will be undefined.
 */
- (JSValue *)rotationCallback;
/*!
 Returns the current callback function for handling long presses in javascript.
 It should be a function called "longPress" or a variable, with the same name,
 that contains the function to be called.
 @return An JSValue, hopefully containing the callback function to be called (if
 the JavaScript code is correct); if there is no such function or variable, the
 JSValue returned will be undefined.
 */
- (JSValue *)longPressCallback;
@end
