// WARNING: Two sceneManagers with two different Scenes may exist but only
// one may be used at any given time. This is because JavaScript creates objects
// (i.e. Contacts and UIButtons) that must associate with a SceneManager to use
// its JavaScript or UI instance (respectively), and since it's JavaScript
// creating these objects (not SceneManager) there's no way to tell which
// manager to use. Therefore, the current one is always used.


#import <SceneKit/SceneKit.h>

#import "Physics.h"
#import "JavaScript.h"
#import "UI.h"

#import "Shape.h"


@interface SceneManager : NSObject
- (void)runOnSceneView:(SCNView *)view;

+ (SceneManager *)currentSceneManager;
- (void)makeCurrentSceneManager;

@property (nonatomic, strong, readonly) SCNScene *scene;
@property (nonatomic, strong, readonly) Physics *physics;
@property (nonatomic, strong, readonly) Camera *camera;
@property (nonatomic, strong, readonly) JavaScript *javaScript;
@property (nonatomic, strong, readonly) UI *ui;
@property (nonatomic, strong, readonly) Gestures *gestures;

- (void)addItemFromTemplate:(Item *)template;
- (void)addItem:(Item *)item;
@end

