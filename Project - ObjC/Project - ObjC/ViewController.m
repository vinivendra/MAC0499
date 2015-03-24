
// TODO: Consider changing asserts() into exceptions


#import "ViewController.h"

#import "JavaScript.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SCNView *sceneView;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    JavaScript *javaScript = [JavaScript shared];

    [javaScript load];
    [javaScript update];

    self.sceneView.scene = [Scene shared];

    SCNScene *scene = self.sceneView.scene;

    SCNCamera *camera = [SCNCamera new];
    SCNNode *node = [SCNNode new];
    node.position = SCNVector3Make(0, 0, 10);
    node.camera = camera;
    [scene.rootNode addChildNode:node];

    SCNLight *light = [SCNLight light];
    light.color = [Color colorWithWhite:1.0 alpha:1.0];
    node = [SCNNode new];
    node.light = light;
    node.position = SCNVector3Make(3, 3, 3);
    [scene.rootNode addChildNode:node];

    light = [SCNLight light];
    light.color = [Color colorWithWhite:0.7 alpha:1.0];
    node = [SCNNode new];
    node.light = light;
    node.position = SCNVector3Make(-3, -3, -3);
    [scene.rootNode addChildNode:node];

    light = [SCNLight light];
    light.color = [Color colorWithWhite:0.4 alpha:1.0];
    light.type = SCNLightTypeAmbient;
    node = [SCNNode new];
    node.light = light;
    node.position = SCNVector3Make(-3, -3, -3);
    [scene.rootNode addChildNode:node];

//    Sphere *ball = [Sphere sphere];
//    ball.color = [Color redColor];
//    SCNPhysicsShape *shape = [SCNPhysicsShape
//        shapeWithNode:ball.node
//              options:@{SCNPhysicsShapeScaleKey : [ball.scale toValue]}];
//    SCNPhysicsBody *body =
//        [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeDynamic shape:shape];
//    ball.node.physicsBody = body;
//
//    Pyramid *floor = [Pyramid pyramid];
//    floor.color = [Color orangeColor];
//
//    floor.width = floor.width * 2;
//    floor.length = floor.length * 2;
//    floor.height = floor.height * 2;
//    body = [SCNPhysicsBody staticBody];
//    floor.node.physicsBody = body;
//
//    floor.position = [[Position alloc] initWithX:-0.25 Y:-3 Z:0];
//    floor.rotation = [Rotation rotationWithAxis:[Axis y] angle:[Angle angleWithRadians:0.2]];
}

@end
