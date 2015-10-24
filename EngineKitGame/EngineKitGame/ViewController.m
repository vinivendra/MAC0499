

#import "ViewController.h"
#import <EngineKit/EngineKit.h>


@interface ViewController ()
@property (weak, nonatomic) IBOutlet SCNView *sceneView;
@property (nonatomic, strong) SceneManager *sceneManager;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.sceneManager = [SceneManager new];

    [self.sceneManager runOnSceneView:self.sceneView];
}


@end

