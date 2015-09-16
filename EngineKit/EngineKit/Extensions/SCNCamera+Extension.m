

#import "SCNCamera+Extension.h"


@implementation SCNCamera (Extension)

+ (Item *)shared {
    static Item *singleton;

    static dispatch_once_t onceToken;
    dispatch_once( &onceToken,
                  ^{
                      singleton = [Item new];
                      singleton.node.camera = [SCNCamera new];
                      singleton.position = @[@0, @0, @10];

                      SCNNode *originNode = [SCNNode node];
                      originNode.position = SCNVector3Make(0, 0, 0);

                      SCNLookAtConstraint *constraint = [SCNLookAtConstraint lookAtConstraintWithTarget:originNode];
                      constraint.gimbalLockEnabled = YES;

                      NSMutableArray *newConstraints = [NSMutableArray arrayWithArray:singleton.node.constraints];
                      [newConstraints addObject:constraint];
                      singleton.node.constraints = newConstraints;
                  } );

    return singleton;
}

@end
