
// TODO: Consider changing asserts() into exceptions


#import "ViewController.h"

#import "Physics.h"
#import "JavaScript.h"


static Sphere *ball;


@interface ViewController ()
@property (weak, nonatomic) IBOutlet SCNView *sceneView;
@property (weak, nonatomic) IBOutlet UIView *controlView;
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


    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"BOTAO" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(20, 20, 100, 50);

    [self.controlView addSubview:btn];


    ball = [Sphere create];
    ball.color = @"red";
    ball.position = @[@1, @1, @0];
}

- (void)btnPressed:(id)sender {
    NSLog(@"HUE");
    Vector *v = ball.position;
    Vector *r = [v plus:[[Vector alloc] initWithObject:@[@-0.1, @-0.1, @0]]];
    ball.position = r;
}

@end
