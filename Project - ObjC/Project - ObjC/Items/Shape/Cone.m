

#import "Cone.h"


@implementation Cone

+ (instancetype)cone {
    return [self create];
}

- (instancetype)init {
    if (self = [super init]) {
        self.cone = [SCNCone new];
    }
    return self;
}

- (instancetype)initWithTopRadius:(CGFloat)topRadius
                     bottomRadius:(CGFloat)bottomRadius
                           height:(CGFloat)height {
    if (self = [super init]) {
        self.cone = [SCNCone coneWithTopRadius:topRadius
                                  bottomRadius:bottomRadius
                                        height:height];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setCone:(SCNCone *)cone {
    self.geometry = cone;
}

- (SCNCone *)cone {
    return (SCNCone *)self.geometry;
}


- (void)setRadius:(CGFloat)radius {
    [self assertTheresNoPhysicsBody];
    self.cone.bottomRadius = radius;
}

- (CGFloat)radius {
    return self.cone.bottomRadius;
}

- (void)setBottomRadius:(CGFloat)radius {
    [self assertTheresNoPhysicsBody];
    self.radius = radius;
}

- (CGFloat)bottomRadius {
    return self.radius;
}

- (void)setTopRadius:(CGFloat)radius {
    [self assertTheresNoPhysicsBody];
    self.cone.topRadius = radius;
}

- (CGFloat)topRadius {
    return self.cone.topRadius;
}

- (void)setHeight:(CGFloat)height {
    [self assertTheresNoPhysicsBody];
    self.cone.height = height;
}

- (CGFloat)height {
    return self.cone.height;
}

@end
