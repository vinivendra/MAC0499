

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

#import "Common.h"
#import "TriggerActionManager.h"

#import "UI.h"
#import "Camera.h"
#import "Physics.h"

/*!
 A JavaScript manager class, used to handle the interaction between the
 Objective-C game architecture and the JavaScript code.
 */
@interface JavaScript : NSObject
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
- (instancetype)initWithCamera:(Camera *)camera
                            UI:(UI *)ui
                       physics:(Physics *)physics;
- (instancetype)initWithFile:(NSString *)filename
                      camera:(Camera *)camera
                          UI:(UI *)ui
                     physics:(Physics *)physics;
- (instancetype)initWithScriptFile:(NSString *)scriptFilename
                         sceneFile:(NSString *)sceneFilename
                            camera:(Camera *)camera
                                UI:(UI *)ui
                           physics:(Physics *)physics;
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
// TODO: doc
@property (nonatomic, strong) TriggerActionManager *triggerActionManager;
@property (nonatomic, strong) JSContext *context;
@end
