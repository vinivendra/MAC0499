
// TODO: Consider changing asserts() into exceptions


#import "ViewController.h"

#import "Physics.h"
#import "JavaScript.h"
#import "Gestures.h"


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

    Gestures *gestures = [Gestures shared];
    gestures.gesturesView = self.controlView;
    gestures.sceneView = self.sceneView;
    [gestures setupTaps];
    [gestures setupSwipes];
}

@end
