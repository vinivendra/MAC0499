

#import "Camera.h"


@interface Camera ()
@property (nonatomic, strong) SCNNode *lookAtNode;
@property (nonatomic, strong) SCNLookAtConstraint *lookAtConstraint;
@end


@implementation Camera

- (instancetype)init {
    if (self = [super init]) {
        [self addSCNCamera];
    }
    return self;
}

- (instancetype)initAndAddToScene {
    if (self = [super initAndAddToScene]) {
        [self addSCNCamera];
    }
    return self;
}

- (void)addSCNCamera {
    self.node.camera = [SCNCamera new];
    self.position = [[Position alloc] initWithX:0 Y:0 Z:10];
}

- (void)lookAt:(id)object {
    self.lookAtNode.position = [[Vector alloc] initWithObject:object].toSCNVector3;
}

@end
