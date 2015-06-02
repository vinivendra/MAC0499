

#import "Camera.h"


@interface Camera ()
@property (nonatomic, strong) SCNNode *lookAtNode;
@property (nonatomic, strong) SCNLookAtConstraint *lookAtConstraint;
@end


@implementation Camera

+ (Camera *)shared {
    static Camera *singleton;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      singleton = [self new];

                      singleton.node.camera = [SCNCamera new];
                      singleton.position = @[@0, @0, @10];

//                      singleton.lookAtNode = [SCNNode node];
//                      singleton.lookAtConstraint = [SCNLookAtConstraint
//                          lookAtConstraintWithTarget:singleton.lookAtNode];
//                      singleton.node.constraints =
//                          @[ singleton.lookAtConstraint ];
                  });

    return singleton;
}

- (void)lookAt:(id)object {
    self.lookAtNode.position = [Vector vectorWithObject:object].toSCNVector3;
}

@end
