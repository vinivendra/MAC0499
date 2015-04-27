// TODO: export directions enum to js

#import "Gestures.h"
#import "JavaScript.h"


static Vector *lastPanPoint = nil;


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

#pragma mark - Setup

- (void)setupTaps {
    UITapGestureRecognizer *tapGesture = [UITapGestureRecognizer new];
    [tapGesture addTarget:self action:@selector(handleTap:)];
    [self.gesturesView addGestureRecognizer:tapGesture];
}

- (void)setupSwipes {
    UISwipeGestureRecognizer *swipeGestureRight =
        [UISwipeGestureRecognizer new];
    swipeGestureRight.direction = UISwipeGestureRecognizerDirectionRight;
    [swipeGestureRight addTarget:self action:@selector(handleSwipeRight:)];
    [self.gesturesView addGestureRecognizer:swipeGestureRight];

    UISwipeGestureRecognizer *swipeGestureLeft = [UISwipeGestureRecognizer new];
    swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [swipeGestureLeft addTarget:self action:@selector(handleSwipeLeft:)];
    [self.gesturesView addGestureRecognizer:swipeGestureLeft];

    UISwipeGestureRecognizer *swipeGestureDown = [UISwipeGestureRecognizer new];
    swipeGestureDown.direction = UISwipeGestureRecognizerDirectionDown;
    [swipeGestureDown addTarget:self action:@selector(handleSwipeDown:)];
    [self.gesturesView addGestureRecognizer:swipeGestureDown];

    UISwipeGestureRecognizer *swipeGestureUp = [UISwipeGestureRecognizer new];
    swipeGestureUp.direction = UISwipeGestureRecognizerDirectionUp;
    [swipeGestureUp addTarget:self action:@selector(handleSwipeUp:)];
    [self.gesturesView addGestureRecognizer:swipeGestureUp];
}

- (void)setupPans {
    UIPanGestureRecognizer *panGesture = [UIPanGestureRecognizer new];
    [panGesture addTarget:self action:@selector(handlePan:)];
    [self.gesturesView addGestureRecognizer:panGesture];
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

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)sender {
    [self handleSwipe:sender
          inDirection:UISwipeGestureRecognizerDirectionRight];
}

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)sender {
    [self handleSwipe:sender inDirection:UISwipeGestureRecognizerDirectionLeft];
}

- (void)handleSwipeDown:(UISwipeGestureRecognizer *)sender {
    [self handleSwipe:sender inDirection:UISwipeGestureRecognizerDirectionDown];
}

- (void)handleSwipeUp:(UISwipeGestureRecognizer *)sender {
    [self handleSwipe:sender inDirection:UISwipeGestureRecognizerDirectionUp];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)sender
        inDirection:(UISwipeGestureRecognizerDirection)direction {

    if (sender.state == UIGestureRecognizerStateRecognized) {
        CGPoint location = [sender locationInView:self.sceneView];
        NSArray *swipes = [self.sceneView hitTest:location options:nil];
        NSMutableArray *validSwipes = [NSMutableArray new];
        NSMutableArray *directions = [NSMutableArray new];
        NSMutableArray *items = [NSMutableArray new];
        for (SCNHitTestResult *swipe in swipes) {
            [validSwipes push:swipe];
            [directions push:@(direction)];
            [items push:swipe.node.item];
        }
        [[JavaScript shared].swipeCallback
            callWithArguments:@[ items, directions, validSwipes ]];
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)sender {

    if (sender.state == UIGestureRecognizerStateBegan) {
        lastPanPoint = [Vector origin];
    }
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [sender translationInView:self.sceneView];
        Vector *currentPoint = [[Vector alloc] initWithCGPoint:translation];
        Vector *relativeTranslation = [currentPoint minus:lastPanPoint];
        [[JavaScript shared].panCallback
            callWithArguments:@[ relativeTranslation ]];
        lastPanPoint = currentPoint;
    }
}


@end
