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

@property (nonatomic, strong) NSMutableArray *gesturesRecognizers;
@end


@implementation Gestures

- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}

#pragma mark - Defaults

+ (UIGestureRecognizerState)defaultStateForGesture:(UIGestures)gesture {
    if (gesture == TapGesture || gesture == SwipeGesture) {
        return UIGestureRecognizerStateRecognized;
    }
    else {
        return UIGestureRecognizerStateChanged;
    }
}

+ (NSDictionary *)possibleStatesForGesture:(UIGestures)gesture {
    if (gesture == TapGesture || gesture == SwipeGesture) {
        return @{@"recognized": @YES};
    }
    else {
        return @{@"began": @YES,
                 @"changed": @YES,
                 @"ended": @YES};
    }
}

+ (NSArray *)possibleTouchesForGesture:(UIGestures)gesture {
    if (gesture == PinchGesture || gesture == RotateGesture) {
        return @[@NO, @2, @NO, @NO, @NO];
    }
    else {
        return @[@1, @2, @3, @4, @5];
    }
}

+ (NSInteger)deafultNumberOfTouchesForGesture:(UIGestures)gesture {
    if (gesture == PinchGesture || gesture == RotateGesture) {
        return 2;
    }
    else {
        return 1;
    }
}


+ (UIGestures)gestureForString:(NSString *)string {
    static NSDictionary *gestureEnumConversion;

    if (!gestureEnumConversion) {
        gestureEnumConversion = @{@"swipe": @(SwipeGesture),
                                  @"tap": @(TapGesture),
                                  @"pan": @(PanGesture),
                                  @"pinch": @(PinchGesture),
                                  @"rotate": @(RotateGesture),
                                  @"longpress": @(LongPressGesture)};
    }

    NSNumber *gestureNumber = gestureEnumConversion[string];
    UIGestures gestureEnum = gestureNumber.unsignedIntegerValue;

    return gestureEnum;
}

+ (NSString *)stringForGesture:(UIGestures)gesture {
    static NSDictionary *gestureStringConversion;

    if (!gestureStringConversion) {
        gestureStringConversion = @{@(SwipeGesture): @"swipe",
                                    @(TapGesture): @"tap",
                                    @(PanGesture): @"pan",
                                    @(PinchGesture): @"pinch",
                                    @(RotateGesture): @"rotate",
                                    @(LongPressGesture): @"longpress"};
    }

    return gestureStringConversion[@(gesture)];
}

+ (UIGestureRecognizerState)stateForString:(NSString *)string
                                   gesture:(UIGestures)gesture {
    static NSDictionary *stateEnumConversion;

    if (!stateEnumConversion) {
        stateEnumConversion = @{@"began": @(UIGestureRecognizerStateBegan),
                                @"ended": @(UIGestureRecognizerStateEnded),
                                @"recognized": @(UIGestureRecognizerStateRecognized),
                                @"changed": @(UIGestureRecognizerStateChanged)};
    }

    NSNumber *stateNumber = stateEnumConversion[string];

    UIGestureRecognizerState stateEnum;

    if (stateNumber) {
        stateEnum = stateNumber.unsignedIntegerValue;
    }
    else {
        stateEnum = [Gestures defaultStateForGesture:gesture];
    }

    return stateEnum;
}

+ (NSString *)stringForState:(UIGestureRecognizerState)state
                     gesture:(UIGestures)gesture {
    if (gesture == TapGesture || gesture == SwipeGesture) {
        return nil;
    }
    else {
        if (state == UIGestureRecognizerStateChanged) {
            return nil;
        }
    }

    static NSDictionary *stateStringConversion;
    if (!stateStringConversion) {
        stateStringConversion = @{@(UIGestureRecognizerStateBegan): @"began",
                                  @(UIGestureRecognizerStateEnded): @"ended",
                                  @(UIGestureRecognizerStateRecognized): @"recognized",
                                  @(UIGestureRecognizerStateChanged): @"changed"};
    }

    return stateStringConversion[@(state)];
}

+ (NSInteger)numberOfTouchesForNumber:(NSNumber *)object
                              gesture:(UIGestures)gesture {

    if (!object) {
        return [Gestures deafultNumberOfTouchesForGesture:gesture];
    }
    else {
        NSArray *possibleTouches = [Gestures possibleTouchesForGesture:gesture];
        NSNumber *touchIsPossible = possibleTouches[object.integerValue];
        if (touchIsPossible.boolValue) {
            return object.integerValue;
        }
        else {
            return [Gestures deafultNumberOfTouchesForGesture:gesture];
        }
    }
}


+ (NSString *)stringForTouches:(NSInteger)touches
                       gesture:(UIGestures)gesture {

    if (gesture == PinchGesture || gesture == RotateGesture) {
        return nil;
    }
    else if (touches == 1) {
        return nil;
    }
    else {
        return [NSString stringWithFormat:@"%d", touches];
    }
    
    return nil;
}

#pragma mark - Setup

- (void)setupGestures {
    self.gesturesRecognizers = [NSMutableArray new];

    for (int i = 0; i < GestureRecognizersCount; i++) {
        Class class = self.classes[i];
        SEL handler = NSSelectorFromString(self.selectors[i]);

        UIGestureRecognizer *gesture = [class new];
        [gesture addTarget:self action:handler];
        [self.gesturesRecognizers addObject:gesture];

        if (i <= SwipeUpRecognizer)
        ((UISwipeGestureRecognizer *)gesture).direction = 1 << i;

        [self.gesturesView addGestureRecognizer:gesture];
    }
}

- (void)pauseGestures {
    for (int i = 0; i < GestureRecognizersCount; i++) {
        SEL handler = NSSelectorFromString(self.selectors[i]);

        UIGestureRecognizer *gesture = self.gesturesRecognizers[i];
        [gesture removeTarget:self action:handler];

        [self.gesturesView removeGestureRecognizer:gesture];
    }

    self.gesturesRecognizers = nil;
}

- (void)resumeGestures {
    [self setupGestures];
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
         touches:sender.numberOfTouches
         withArguments:
         @[ items, hits ]];
    }
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)sender {

    static NSDictionary *directions;

    if (!directions) {
        directions = @{@(UISwipeGestureRecognizerDirectionDown):
                           [[Vector alloc] initWithCGPoint:CGPointMake(0, 1)],
                       @(UISwipeGestureRecognizerDirectionLeft):
                           [[Vector alloc] initWithCGPoint:CGPointMake(-1, 0)],
                       @(UISwipeGestureRecognizerDirectionRight):
                           [[Vector alloc] initWithCGPoint:CGPointMake(1, 0)],
                       @(UISwipeGestureRecognizerDirectionUp):
                           [[Vector alloc] initWithCGPoint:CGPointMake(0, -1)]};
    }

    if (sender.state == UIGestureRecognizerStateRecognized) {
        CGPoint location = [sender locationInView:self.sceneView];
        NSArray *hits = [self.sceneView hitTest:location options:nil];
        NSArray *items = [hits valueForKeyPath:@"node.item"];
        [self.delegate
         callGestureCallbackForGesture:SwipeGesture
         state:UIGestureRecognizerStateRecognized
         touches:sender.numberOfTouches
         withArguments:@[
                         items,
                         directions[@(sender.direction)],
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
     touches:sender.numberOfTouches
     withArguments:@[
                     self.selectedItems,
                     translation,
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
     touches:sender.numberOfTouches
     withArguments:@[
                     self.selectedItems,
                     @(scale),
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
     touches:sender.numberOfTouches
     withArguments:@[
                     self.selectedItems,
                     @(angle),
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
     touches:sender.numberOfTouches
     withArguments:@[
                     self.selectedItems,
                     translation,
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
