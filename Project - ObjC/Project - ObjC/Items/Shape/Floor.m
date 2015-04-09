

#import "Floor.h"


@implementation Floor

+ (instancetype)floor {
    return [self create];
}

- (instancetype)init {
    if (self = [super init]) {
        self.floor = [SCNFloor floor];
    }
    return self;
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
