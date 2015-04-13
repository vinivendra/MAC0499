// TODO: refactor SCNGeometry's initForCopy, turn it into a deepCopy; do the
// same for SCNSphere and Sphere. Test template copying.

#import "SCNNode+Extension.h"
#import <objc/runtime.h>


@implementation SCNNode (Extension)

- (void)setItem:(Item *)item {
    objc_setAssociatedObject(self,
                             @"node_item",
                             item,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (Item *)item {
    return objc_getAssociatedObject(self, @"node_item");
}

@end
