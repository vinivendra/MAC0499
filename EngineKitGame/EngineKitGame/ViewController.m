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
    JavaScript *javaScript = [JavaScript shared];

    [UI shared].view = self.controlView;

    [javaScript load];
    [javaScript update];

    self.sceneView.scene = physics.scene;

    SCNScene *scene = self.sceneView.scene;

    SCNCamera *camera = [SCNCamera new];
    SCNNode *node = [SCNNode new];
    node.position = SCNVector3Make(0, 0, 10);
    node.camera = camera;
    [scene.rootNode addChildNode:node];

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
    gestures.options[Tap] = @(YES);
//    gestures.options[SwipeRight] = @(YES);
//    gestures.options[SwipeLeft] = @(YES);
//    gestures.options[SwipeDown] = @(YES);
//    gestures.options[SwipeUp] = @(YES);
    gestures.options[Pan] = @(YES);
    gestures.options[Pinch] = @(YES);
    gestures.options[Rotate] = @(YES);
//    gestures.options[LongPress] = @(YES);
    [gestures setupGestures];

//    [[Parser shared] parseFile:@"scene.fmt"];
}

@end
