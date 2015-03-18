
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
    
    SCNText *sphere = [SCNText textWithString:@"AAAA" extrusionDepth:4.0];
    
    SCNMaterial *material = [SCNMaterial new];
    material.ambient.contents = [Color orangeColor];
    material.diffuse.contents = [Color orangeColor];
    material.specular.contents = [Color orangeColor];

    sphere.materials = @[material];
    
    node = [SCNNode nodeWithGeometry:sphere];
    node.scale = SCNVector3Make(0.1, 0.1, 0.1);
    node.position = [[Vector alloc] initWithX:0 Y:0 Z:0].toSCNVector;
    [scene.rootNode addChildNode:node];
}

@end
