

#import "Floor.h"


@implementation Floor

+ (instancetype)floor {
    return [self new];
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initAndAddToScene {
    if (self = [super initAndAddToScene]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.floor = [SCNFloor new];
}

- (Item *)deepCopy {
    Shape *newItem = [[self class] new];
    [super copyInfoTo:newItem];
    [super copyPhysicsTo:newItem];
    return newItem;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setFloor:(SCNFloor *)floor {
    self.geometry = floor;
}

- (SCNFloor *)floor {
    return (SCNFloor *)self.geometry;
}

@end
