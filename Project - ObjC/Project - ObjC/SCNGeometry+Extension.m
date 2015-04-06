

#import "SCNGeometry+Extension.h"


@implementation SCNGeometry (Extension)
- (SCNGeometry *)deepCopy {
    SCNGeometry *newGeometry = [SCNGeometry new];
    [self deepCopyTo:newGeometry];
    return newGeometry;
}
- (void)deepCopyTo:(SCNGeometry *)geometry {
    geometry.materials = self.materials.copy;
}
@end


@implementation SCNSphere (Extension)
- (SCNSphere *)deepCopy {
    SCNSphere *newSphere = [SCNSphere sphereWithRadius:self.radius];
    [self deepCopyTo:newSphere];
    return newSphere;
}
@end
