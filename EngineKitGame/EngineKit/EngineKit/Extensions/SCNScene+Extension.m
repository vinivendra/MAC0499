

#import "SCNScene+Extension.h"

#import "SCNCamera+Extension.h"

#import "Camera.h"


@implementation SCNScene (Extension)
+ (SCNScene *)shared {
    static SCNScene *singleton;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      singleton = [self new];
                      [singleton addItem:[Camera shared]];
                  });

    return singleton;
}

- (void)addItem:(Item *)item {
    [self.rootNode addChildNode:item.node];
    item.parent = item;
}
@end

