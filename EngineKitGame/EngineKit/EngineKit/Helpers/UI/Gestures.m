// TODO: export directions enum to js


#import "Gestures.h"

#import "JavaScript.h"

#import "Vector.h"

#import "ObjectiveSugar.h"

#import "SCNNode+Extension.h"


@interface Gestures ()
@property (nonatomic, strong) Vector *lastPanPoint;
@property (nonatomic, strong) Vector *lastLongPressPoint;
@property (nonatomic) CGFloat lastPinchValue;
@property (nonatomic) CGFloat lastRotationValue;

@property (nonatomic, strong) NSArray *classes;
@property (nonatomic, strong) NSArray *selectors;
@property (nonatomic, strong) NSMutableArray *options;
@end


@implementation Gestures

+ (Gestures *)shared {
    static Gestures *singleton;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      singleton = [self new];
                  });

    return singleton;
}

- (instancetype)init {
    if (self = [super init]) {
        self.options =
            [[NSMutableArray alloc] initWithCapacity:GestureRecognizersCount];
        for (int i = 0; i < GestureRecognizersCount; i++) {
            [self.options push:@(NO)];
        }
    }
    return self;
}

#pragma mark - Setup

- (void)setupGestures {
    for (int i = 0; i < GestureRecognizersCount; i++) {
        if (((NSNumber *)self.options[i]).boolValue) {
            Class class = self.classes[i];
            SEL handler = NSSelectorFromString(self.selectors[i]);

            UIGestureRecognizer *gesture = [class new];
            [gesture addTarget:self action:handler];

            if (i <= SwipeUp)
                ((UISwipeGestureRecognizer *)gesture).direction = 1 << i;

            [self.gesturesView addGestureRecognizer:gesture];
        }
    }
}

#pragma mark - Handlers

- (void)handleTap:(UITapGestureRecognizer *)sender {

    if (sender.state == UIGestureRecognizerStateRecognized) {
        CGPoint location = [sender locationInView:self.sceneView];
        NSArray *hits = [self.sceneView hitTest:location options:nil];
        NSMutableArray *validHits = [NSMutableArray new];
        NSMutableArray *items = [NSMutableArray new];
        for (SCNHitTestResult *hit in hits) {
            [validHits push:hit];
            [items push:hit.node.item];
        }
        [[JavaScript shared].tapCallback
            callWithArguments:@[ items, validHits ]];
    }
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)sender {

    if (sender.state == UIGestureRecognizerStateRecognized) {
        CGPoint location = [sender locationInView:self.sceneView];
        NSArray *swipes = [self.sceneView hitTest:location options:nil];
        NSMutableArray *hits = [NSMutableArray new];
        NSMutableArray *items = [NSMutableArray new];
        for (SCNHitTestResult *swipe in swipes) {
            [hits push:swipe];
            [items push:swipe.node.item];
        }
        [[JavaScript shared].swipeCallback
            callWithArguments:@[ @(sender.direction), items, hits ]];
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)sender {

    if (sender.state == UIGestureRecognizerStateBegan) {
        self.lastPanPoint = [Vector origin];
    }
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [sender translationInView:self.sceneView];
        Vector *currentPoint = [[Vector alloc] initWithCGPoint:translation];
        Vector *relativeTranslation = [currentPoint minus:self.lastPanPoint];
        [[JavaScript shared].panCallback
            callWithArguments:@[ relativeTranslation ]];
        self.lastPanPoint = currentPoint;
    }
}

- (void)handlePinch:(UIPinchGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.lastPinchValue = 1.0f;
    }
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGFloat scale = sender.scale;
        CGFloat relativeScale = scale / self.lastPinchValue;
        [[JavaScript shared].pinchCallback
            callWithArguments:@[ @(relativeScale) ]];
        self.lastPinchValue = scale;
    }
}

- (void)handleRotation:(UIRotationGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.lastRotationValue = 0.0f;
    }
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGFloat angle = sender.rotation;
        CGFloat relativeAngle = self.lastRotationValue - angle;
        [[JavaScript shared].rotationCallback
            callWithArguments:@[ @(relativeAngle) ]];
        self.lastRotationValue = angle;
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint startingLocation = [sender locationInView:self.sceneView];
        self.lastLongPressPoint =
            [[Vector alloc] initWithCGPoint:startingLocation];
    }
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint location = [sender locationInView:self.sceneView];
        Vector *currentPoint = [[Vector alloc] initWithCGPoint:location];
        Vector *relativeTranslation =
            [currentPoint minus:self.lastLongPressPoint];
        [[JavaScript shared].longPressCallback
            callWithArguments:@[ relativeTranslation ]];
        self.lastLongPressPoint = currentPoint;
    }
}


#pragma mark - Property Overriding

- (NSArray *)classes {
    static NSArray *singleton;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      singleton = @[
                          [UISwipeGestureRecognizer class],
                          [UISwipeGestureRecognizer class],
                          [UISwipeGestureRecognizer class],
                          [UISwipeGestureRecognizer class],
                          [UITapGestureRecognizer class],
                          [UIPanGestureRecognizer class],
                          [UIPinchGestureRecognizer class],
                          [UIRotationGestureRecognizer class],
                          [UILongPressGestureRecognizer class]
                      ];
                  });

    return singleton;
}

- (NSArray *)selectors {
    static NSArray *singleton;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      singleton = @[
                          @"handleSwipe:",
                          @"handleSwipe:",
                          @"handleSwipe:",
                          @"handleSwipe:",
                          @"handleTap:",
                          @"handlePan:",
                          @"handlePinch:",
                          @"handleRotation:",
                          @"handleLongPress:"
                      ];
                  });

    return singleton;
}


@end
