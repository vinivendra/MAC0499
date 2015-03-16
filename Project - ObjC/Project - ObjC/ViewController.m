

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <SceneKit/SceneKit.h>

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
    
    SCNCamera *camera = [SCNCamera new];
    SCNNode *node = [SCNNode new];
    node.position = SCNVector3Make(0, 0, 2);
    node.camera = camera;
    [self.sceneView.scene.rootNode addChildNode:node];
    
    SCNLight *light = [SCNLight light];
    light.color = [Color colorWithWhite:1.0 alpha:1.0];
    node = [SCNNode new];
    node.light = light;
    node.position = SCNVector3Make(3, 3, 3);
    [self.sceneView.scene.rootNode addChildNode:node];
    
    light = [SCNLight light];
    light.color = [Color colorWithWhite:0.7 alpha:1.0];
    node = [SCNNode new];
    node.light = light;
    node.position = SCNVector3Make(-3, -3, -3);
    [self.sceneView.scene.rootNode addChildNode:node];
    
    light = [SCNLight light];
    light.color = [Color colorWithWhite:0.4 alpha:1.0];
    light.type = SCNLightTypeAmbient;
    node = [SCNNode new];
    node.light = light;
    node.position = SCNVector3Make(-3, -3, -3);
    [self.sceneView.scene.rootNode addChildNode:node];
    
    Sphere *sphere = [Sphere new];
    sphere.color = [UIColor orangeColor];
    sphere.position = SCNVector3Make(0, 0, -2);
}

@end

