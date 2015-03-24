

#import "Tube.h"


@implementation Tube

+ (instancetype)tube {
    return [self create];
}

- (instancetype)init {
    if (self = [super init]) {
        self.tube = [SCNTube new];
    }
    return self;
}

- (instancetype)initWithInnerRadius:(CGFloat)innerRadius
                        outerRadius:(CGFloat)outerRadius
                             height:(CGFloat)height {
    if (self = [super init]) {
        self.tube = [SCNTube tubeWithInnerRadius:innerRadius
                                     outerRadius:outerRadius
                                          height:height];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setTube:(SCNTube *)tube {
    self.geometry = tube;
}

- (SCNTube *)tube {
    return (SCNTube *)self.geometry;
}


- (void)setRadius:(CGFloat)radius {
    [self assertTheresNoPhysicsBody];
    self.tube.outerRadius = radius;
}

- (CGFloat)radius {
    return self.tube.outerRadius;
}

- (void)setInnerRadius:(CGFloat)innerRadius {
    [self assertTheresNoPhysicsBody];
    self.tube.innerRadius = innerRadius;
}

- (CGFloat)innerRadius {
    return self.tube.innerRadius;
}

- (void)setOuterRadius:(CGFloat)outerRadius {
    [self assertTheresNoPhysicsBody];
    self.tube.outerRadius = outerRadius;
}

- (CGFloat)outerRadius {
    return self.tube.outerRadius;
}

- (void)setHeight:(CGFloat)height {
    [self assertTheresNoPhysicsBody];
    self.tube.height = height;
}

- (CGFloat)height {
    return self.tube.height;
}

@end
