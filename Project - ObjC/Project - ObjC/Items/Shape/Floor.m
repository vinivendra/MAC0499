

#import "Floor.h"


@implementation Floor

+ (instancetype)floor {
    return [self create];
}

- (instancetype)init {
    if (self = [super init]) {
        self.floor = [SCNFloor new];
    }
    return self;
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
