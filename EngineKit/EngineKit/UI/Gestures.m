// TODO: Rotate around the center of the screen, not the center of the world.


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

@property (nonatomic, strong) NSArray *selectedItems;
@property (nonatomic, strong) NSArray *selectedHits;

@property (nonatomic, strong) NSArray *classes;
@property (nonatomic, strong) NSArray *selectors;
@property (nonatomic, strong) NSMutableDictionary *options;
@end


@implementation Gestures

- (instancetype)init {
    if (self = [super init]) {
        self.options =
            [[NSMutableDictionary alloc] initWithCapacity:GestureRecognizersCount];
    }
    return self;
}

#pragma mark - Setup

- (void)setupGestures {
    for (int i = 0; i < GestureRecognizersCount; i++) {
        if (((NSNumber *)self.options[@(i)]).boolValue) {
            Class class = self.classes[i];
            SEL handler = NSSelectorFromString(self.selectors[i]);

            UIGestureRecognizer *gesture = [class new];
            [gesture addTarget:self action:handler];

            if (i <= SwipeUpRecognizer)
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
        NSArray *items = [hits valueForKeyPath:@"node.item"];
        [self.delegate
            callGestureCallbackForGesture:TapGesture
                                    state:UIGestureRecognizerStateRecognized
                            withArguments:
                                @[ items, @(sender.numberOfTouches), hits ]];
    }
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)sender {

    if (sender.state == UIGestureRecognizerStateRecognized) {
        CGPoint location = [sender locationInView:self.sceneView];
        NSArray *hits = [self.sceneView hitTest:location options:nil];
        NSArray *items = [hits valueForKeyPath:@"node.item"];
        [self.delegate
            callGestureCallbackForGesture:SwipeGesture
                                    state:UIGestureRecognizerStateRecognized
                            withArguments:@[
                                @(sender.direction),
                                items,
                                @(sender.numberOfTouches),
                                hits
                            ]];
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)sender {

    Vector *translation;

    if (sender.state == UIGestureRecognizerStateBegan) {
        self.lastPanPoint = [Vector origin];

        CGPoint location = [sender locationInView:self.sceneView];
        self.selectedHits = [self.sceneView hitTest:location options:nil];

        self.selectedItems = [self.selectedHits valueForKeyPath:@"node.item"];

        translation = [Vector origin];
    }
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint absoluteTranslation = [sender translationInView:self.sceneView];
        Vector *currentPoint =
            [[Vector alloc] initWithCGPoint:absoluteTranslation];
        translation = [currentPoint minus:self.lastPanPoint];
        self.lastPanPoint = currentPoint;
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        self.selectedItems = @[];
        self.selectedHits = @[];

        translation = [Vector origin];
    }

    [self.delegate
        callGestureCallbackForGesture:PanGesture
                                state:UIGestureRecognizerStateChanged
                        withArguments:@[
                            translation,
                            self.selectedItems,
                            @(sender.numberOfTouches),
                            self.selectedHits
                        ]];
}

- (void)handlePinch:(UIPinchGestureRecognizer *)sender {

    CGFloat scale = 1.0;

    if (sender.state == UIGestureRecognizerStateBegan) {
        self.lastPinchValue = 1.0f;

        CGPoint location = [sender locationInView:self.sceneView];
        self.selectedHits = [self.sceneView hitTest:location options:nil];
        self.selectedItems = [self.selectedHits valueForKeyPath:@"node.item"];
    }
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGFloat absoluteScale = sender.scale;
        scale = absoluteScale / self.lastPinchValue;
        self.lastPinchValue = absoluteScale;
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        self.selectedItems = @[];
        self.selectedHits = @[];
    }

    [self.delegate
        callGestureCallbackForGesture:PinchGesture
                                state:UIGestureRecognizerStateChanged
                        withArguments:@[
                            @(scale),
                            self.selectedItems,
                            @(sender.numberOfTouches),
                            self.selectedHits
                        ]];
}

- (void)handleRotation:(UIRotationGestureRecognizer *)sender {

    CGFloat angle = 0.0;

    if (sender.state == UIGestureRecognizerStateBegan) {
        self.lastRotationValue = 0.0f;

        CGPoint location = [sender locationInView:self.sceneView];
        self.selectedHits = [self.sceneView hitTest:location options:nil];
        self.selectedItems = [self.selectedHits valueForKeyPath:@"node.item"];
    }
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGFloat absoluteAngle = sender.rotation;
        angle = self.lastRotationValue - absoluteAngle;
        self.lastRotationValue = absoluteAngle;
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        self.selectedItems = @[];
        self.selectedHits = @[];
    }

    [self.delegate
        callGestureCallbackForGesture:RotateGesture
                                state:UIGestureRecognizerStateChanged
                        withArguments:@[
                            @(angle),
                            self.selectedItems,
                            @(sender.numberOfTouches),
                            self.selectedHits
                        ]];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)sender {

    Vector *translation;

    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint startingLocation = [sender locationInView:self.sceneView];
        self.lastLongPressPoint =
            [[Vector alloc] initWithCGPoint:startingLocation];

        CGPoint location = [sender locationInView:self.sceneView];
        self.selectedHits = [self.sceneView hitTest:location options:nil];
        self.selectedItems = [self.selectedHits valueForKeyPath:@"node.item"];

        translation = [Vector origin];
    }
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint location = [sender locationInView:self.sceneView];
        Vector *currentPoint = [[Vector alloc] initWithCGPoint:location];
        translation = [currentPoint minus:self.lastLongPressPoint];
        self.lastLongPressPoint = currentPoint;
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        self.selectedItems = @[];
        self.selectedHits = @[];

        translation = [Vector origin];
    }

    [self.delegate
        callGestureCallbackForGesture:LongPressGesture
                                state:UIGestureRecognizerStateChanged
                        withArguments:@[
                            translation,
                            self.selectedItems,
                            @(sender.numberOfTouches),
                            self.selectedHits
                        ]];
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
