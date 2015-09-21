

#import "ViewController.h"
#import <EngineKit/EngineKit.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet SCNView *sceneView;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Physics *physics = [Physics shared];

    SCNScene *scene = physics.scene;
    self.sceneView.scene = scene;

    SCNNode *node;

    SCNLight *light = [SCNLight new];
    light.color = [UIColor colorWithWhite:1.0 alpha:1.0];
    node = [SCNNode new];
    node.light = light;
    node.position = SCNVector3Make(3, 3, 3);
    [scene.rootNode addChildNode:node];

    light = [SCNLight new];
    light.color = [UIColor colorWithWhite:0.7 alpha:1.0];
    node = [SCNNode new];
    node.light = light;
    node.position = SCNVector3Make(-3, -3, -3);
    [scene.rootNode addChildNode:node];

    light = [SCNLight new];
    light.color = [UIColor colorWithWhite:0.4 alpha:1.0];
    light.type = SCNLightTypeAmbient;
    node = [SCNNode new];
    node.light = light;
    node.position = SCNVector3Make(-3, -3, -3);
    [scene.rootNode addChildNode:node];

    //
    //    UI.shared().view = self.controlView // TODO: Property
    //

    JavaScript *javaScript = [JavaScript new];
    [javaScript load];
    [javaScript update];

    Gestures *gestures = [Gestures shared];
    gestures.sceneView = self.sceneView;
    gestures.gesturesView = self.sceneView;

    gestures.options[@(PanRecognizer)] = @YES;
    gestures.options[@(TapRecognizer)] = @YES;

    gestures.delegate = [JavaScript shared];

    [gestures setupGestures];
}


@end
