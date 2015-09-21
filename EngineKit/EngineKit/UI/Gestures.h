

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>


typedef NS_ENUM(NSUInteger, UIGestures) {
    SwipeGesture,
    TapGesture,
    PanGesture,
    PinchGesture,
    RotateGesture,
    LongPressGesture,

    UIGesturesCount
};

typedef NS_ENUM(NSUInteger, GestureRecognizers) {
    SwipeDownRecognizer = 0,
    SwipeLeftRecognizer,
    SwipeRightRecognizer,
    SwipeUpRecognizer,
    TapRecognizer,
    PanRecognizer,
    PinchRecognizer,
    RotateRecognizer,
    LongPressRecognizer,

    GestureRecognizersCount
};


@protocol GestureDelegate <NSObject>
- (void)callGestureCallbackForGesture:(UIGestures)gesture
                                state:(UIGestureRecognizerState)state
                        withArguments:(NSArray *)arguments;
@end


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
@property (nonatomic, weak) id<GestureDelegate> delegate;
@end
