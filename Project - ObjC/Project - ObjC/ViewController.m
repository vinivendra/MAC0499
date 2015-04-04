
// TODO: Consider changing asserts() into exceptions


#import "ViewController.h"

#import "Physics.h"
#import "JavaScript.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SCNView *sceneView;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Physics *physics = [Physics shared];
    JavaScript *javaScript = [JavaScript shared];

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

//    Sphere *ball = [Sphere create];
//    ball.color = @"red";
//    ball.physics = @"dynamic";
//    ball.velocity = @[@0, @3, @0];
//    
//    Pyramid *floor = [Pyramid create];
//    floor.color = @"orange";
//    floor.width *= 2;
//    floor.length *= 2;
//    floor.height *= 2;
//    floor.position = @[@-0.25, @-3, @0];
//    floor.physics = @"static";
}

@end
