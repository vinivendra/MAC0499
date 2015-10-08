

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>

#import "Common.h"


@interface Gestures : NSObject
/*!
 The view to which the Gestures object should add the Gesture Recognizers.
 Ideally, this should be either the sceneView itself or a view in front of the 
 scene view, one that has no views in front of it to intercept touch events.
 */
@property (nonatomic, weak) UIView *gesturesView;
/*!
 The scene view used to test hits on taps and other similar gestures.
 */
@property (nonatomic, weak) SCNView *sceneView;
// TODO: Fix this doc
/*!
 Tells the Gestures object to add the gesture recognizers the user opted to
 have, which automatically starts sending messages to the Javascript tap
 callback function, whenever the gestures get recognized in the gestureView.

 To opt into having a gesture recognizer, simply set the appropriate index of
 this object's @p options array to @(YES). The indexes are based on the
 GestureRecognizers enum.
 */
- (void)setupGestures;
// TODO: Add this doc
@property (nonatomic, weak) id<CallbackDelegate> delegate;
- (void)pauseGestures;
- (void)resumeGestures;

+ (NSDictionary <NSString *, NSNumber *> *)possibleStatesForGesture:(UIGestures)gesture;
+ (UIGestureRecognizerState)defaultStateForGesture:(UIGestures)gesture;

+ (NSArray <NSNumber *> *)possibleTouchesForGesture:(UIGestures)gesture;
+ (NSInteger)defaultNumberOfTouchesForGesture:(UIGestures)gesture;


+ (UIGestures)gestureForString:(NSString *)string;
+ (NSString *)stringForGesture:(UIGestures)gesture;

+ (UIGestureRecognizerState)stateForString:(NSString *)string
                                   gesture:(UIGestures)gesture;
+ (NSString *)stringForState:(UIGestureRecognizerState)state
                     gesture:(UIGestures)gesture;

+ (NSInteger)numberOfTouchesForNumber:(NSNumber *)object
                              gesture:(UIGestures)gesture;
+ (NSString *)stringForTouches:(NSInteger)touches
                       gesture:(UIGestures)gesture;

@end
