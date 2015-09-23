#ifndef Enums_h
#define Enums_h

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIType) {
    Button = 0,
    Slider,
    UITypeCount
};

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


@protocol CallbackDelegate <NSObject>
- (void)callGestureCallbackForGesture:(UIGestures)gesture
                                state:(UIGestureRecognizerState)state
                        withArguments:(NSArray *)arguments;
- (void)callUICallbackForView:(UIView *)view
                       ofType:(UIType)type;
@end


@protocol Action <NSObject>
- (void)callWithArguments:(NSArray *)arguments;
@end

#endif /* Enums_h */
