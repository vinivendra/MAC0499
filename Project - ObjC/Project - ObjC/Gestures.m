

#import "Gestures.h"
#import "JavaScript.h"


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

@end
