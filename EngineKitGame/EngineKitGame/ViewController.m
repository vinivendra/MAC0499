//
//  ViewController.m
//  EngineKitGame
//
//  Created by Vinicius Vendramini on 04/05/15.
//  Copyright (c) 2015 Vinicius Vendramini. All rights reserved.
//

#import "ViewController.h"

#import <EngineKit/EngineKit.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet SCNView *sceneView;
@property (weak, nonatomic) IBOutlet UIView *controlView;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Physics *physics = [Physics shared];
    self.sceneView.scene = physics.scene;

    SCNScene *scene = self.sceneView.scene;
    SCNNode *node;

    SCNLight *light = [SCNLight light];
    light.color = [UIColor colorWithWhite:1.0 alpha:1.0];
    node = [SCNNode new];
    node.light = light;
    node.position = SCNVector3Make(3, 3, 3);
    [scene.rootNode addChildNode:node];

    light = [SCNLight light];
    light.color = [UIColor colorWithWhite:0.7 alpha:1.0];
    node = [SCNNode new];
    node.light = light;
    node.position = SCNVector3Make(-3, -3, -3);
    [scene.rootNode addChildNode:node];

    light = [SCNLight light];
    light.color = [UIColor colorWithWhite:0.4 alpha:1.0];
    light.type = SCNLightTypeAmbient;
    node = [SCNNode new];
    node.light = light;
    node.position = SCNVector3Make(-3, -3, -3);
    [scene.rootNode addChildNode:node];

    Gestures *gestures = [Gestures shared];
    gestures.gesturesView = self.controlView;
    gestures.sceneView = self.sceneView;
    gestures.options[TapRecognizer] = @(YES);
//    gestures.options[SwipeRightRecognizer] = @(YES);
//    gestures.options[SwipeLeftRecognizer] = @(YES);
//    gestures.options[SwipeDownRecognizer] = @(YES);
//    gestures.options[SwipeUpRecognizer] = @(YES);
    gestures.options[PanRecognizer] = @(YES);
    gestures.options[PinchRecognizer] = @(YES);
    gestures.options[RotateRecognizer] = @(YES);
//    gestures.options[LongPressRecognizer] = @(YES);
    [gestures setupGestures];

//    [[Parser shared] parseFile:@"scene.fmt"];

    JavaScript *javaScript = [JavaScript shared];

    [UI shared].view = self.controlView;

    [javaScript load];
    [javaScript update];
}

@end
