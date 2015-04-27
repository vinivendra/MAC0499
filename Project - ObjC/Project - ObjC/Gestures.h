

@interface Gestures : NSObject
/*!
 The singleton instance of the Gestures class. The class is meant to be used as
 a singleton may deal with other singleton instances.
 @return A singleton instance of the Gestures class.
 */
+ (Gestures *)shared;
/*!
 The view to which the Gestures object should add the Gesture Recognizers.
 Ideally, this should be either the sceneView itself or a view above the scene
 view, one that has no views above it to intercept touch events.
 */
@property (nonatomic, weak) UIView *gesturesView;
/*!
 The scene view used to test hits on taps and other similar gestures.
 */
@property (nonatomic, weak) SCNView *sceneView;
/*!
 Tells the Gestures object to add a gesture recognizer for taps, which
 automatically starts sending messages to the Javascript tap callback function
 whenever taps occur in the gestureView.
 */
- (void)setupTaps;
/*!
 Tells the Gestures object to add a gesture recognizer for swipes, which
 automatically starts sending messages to the Javascript swipe callback function
 whenever swipes occur in the gestureView.
 */
- (void)setupSwipes;
@end
