

#import "SCNScene+Extension.h"
#import "SCNNode+Extension.h"
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

- (void)deepCopyToScene:(SCNScene *)scene {
    for (int i = 0; i < self.rootNode.childNodes.count; i++) {
        SCNNode *node = self.rootNode.childNodes[i];

        Item *item = node.item;

        Item *copy = item.deepCopy;

        [scene addItem:copy];
    }
}

- (Item *)itemNamed:(NSString *)name {
    for (SCNNode *node in self.rootNode.childNodes) {
        Item *item = node.item;
        if ([item.name isEqualToString:name]) {
            return item;
        }
    }
    return nil;
}

@end

