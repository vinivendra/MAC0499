

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
 The singleton instance of the Gestures class. The class is meant to be used as
 a singleton may deal with other singleton instances.
 @return A singleton instance of the Gestures class.
 */
+ (Gestures *)shared;
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
/*!
 Tells the Gestures object to add the gesture recognizers the user opted to
 have, which automatically starts sending messages to the Javascript tap
 callback function, whenever the gestures get recognized in the gestureView.

 To opt into having a gesture recognizer, simply set the appropriate index of
 this object's @p options array to @(YES). The indexes are based on the
 GestureRecognizers enum.
 */
- (void)setupGestures;
// TODO: Fix this doc
/*!
 The array used to inform the Gestures object which gesture recognizers should
 be initialized and added to the @p gesturesView. This is done based on the @p
 GestureRecognizers enum, which indicates the correct indices. All objects in
 this array have value @(NO); in order to opt into a specific gesture
 recognizer, change its index's value to @(YES).
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *options;
// TODO: Add this doc
@property (nonatomic, weak) id<GestureDelegate> delegate;
@end
