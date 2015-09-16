

#import "SCNScene+Extension.h"

#import "SCNCamera+Extension.h"

#import "Camera.h"


static SCNScene *currentScene;

@implementation SCNScene (Extension)
+ (SCNScene *)currentScene {
    return currentScene;
}

- (void)makeCurrentScene {
    currentScene = self;
}

- (void)addItem:(Item *)item {
    [self.rootNode addChildNode:item.node];
    item.parent = item;
}
@end

