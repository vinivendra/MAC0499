

#import "Item.h"


@implementation Item

+ (instancetype)create {
    return [self new];
}

- (instancetype)init {
    if (self = [super init]) {
        self.node = [SCNNode node];
        [[SCNScene shared] addItem:self];
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setPosition:(id)position {
    self.node.position =
        [[[Position alloc] initWithObject:position] toSCNVector];
}

- (id)position {
    return [[Position alloc] initWithSCNVector:self.node.position];
}

- (void)setRotation:(id)rotation {
    self.node.rotation =
        [[[Rotation alloc] initWithObject:rotation] toSCNVector];
}

- (id)rotation {
    return [[Rotation alloc] initWithSCNVector4:self.node.rotation];
}

- (void)setScale:(id)scale {
    self.node.scale = [[Vector alloc] initWithObject:scale].toSCNVector;
}

- (id)scale {
    return [[Vector alloc] initWithSCNVector:self.node.scale];
}

- (void)setGeometry:(SCNGeometry *)geometry {
    self.node.geometry = geometry;
}

- (SCNGeometry *)geometry {
    return self.node.geometry;
}

@end
