

#import "SceneManager.h"

#import "EngineKitMath.h"
#import "SCNScene+Extension.h"


@class SceneManager;


static SceneManager *currentSceneManager;


@interface SceneManager ()
@property (nonatomic, strong) SCNScene *scene;
@property (nonatomic, strong) Physics *physics;
@property (nonatomic, strong) Camera *camera;
@property (nonatomic, strong) JavaScript *javaScript;
@property (nonatomic, strong) UI *ui;
@property (nonatomic, strong) Gestures *gestures;
@end


@implementation SceneManager

+ (SceneManager *)currentSceneManager {
    return currentSceneManager;
}

- (void)runOnSceneView:(SCNView *)view {
    view.scene =self.scene;

    [self makeCurrentSceneManager];

    self.gestures.sceneView = view;
    self.gestures.gesturesView = view;

    [self.gestures setupGestures];

    self.gestures.delegate = self.javaScript.triggerActionManager;

    [self.javaScript load];
}

- (void)makeCurrentSceneManager {
    currentSceneManager = self;
    [self.scene makeCurrentScene];
}

- (instancetype)init {
    if (self = [super init]) {
        self.scene = [SCNScene new];
        self.physics = [[Physics alloc] initWithScene:self.scene];
        self.camera = [[Camera alloc] init];
        self.gestures = [[Gestures alloc] init];
        self.ui = [[UI alloc] init];
        self.javaScript = [[JavaScript alloc] initWithFile:nil
                                                    camera:self.camera
                                                        UI:self.ui];

//        self.ui.delegate = self.javaScript.trigger;
        [_scene addItem:self.camera];
    }

    return self;
}

- (void)addItemFromTemplate:(Item *)template {
    Item *instance = [template create];
    [self addItem:instance];
}

- (void)addItem:(Item *)item {
    Position *position = self.camera.position;
    Rotation *rotation = [[Rotation alloc]
                          initWithSCNVector4:self.camera.node.rotation];
    Vector *defaultOrientation = [[Vector alloc] initWithX:0 Y:0 Z:-1];
    Vector *newOrientation = [rotation rotate:defaultOrientation];

    Vector *space = [newOrientation times:10];

    Vector *newPosition = [position plus:space];

    item.position = newPosition;

    [self.scene addItem:item];
}

@end


