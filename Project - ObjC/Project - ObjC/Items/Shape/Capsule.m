

#import "Capsule.h"


@implementation Capsule

+ (instancetype)capsule {
    return [self create];
}

- (instancetype)init {
    if (self = [super init]) {
        self.capsule = [SCNCapsule new];
    }
    return self;
}

- (instancetype)initWithRadius:(CGFloat)radius height:(CGFloat)height {
    if (self = [super init]) {
        self.capsule = [SCNCapsule capsuleWithCapRadius:radius height:height];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setCapsule:(SCNCapsule *)capsule {
    self.geometry = capsule;
}

- (SCNCapsule *)capsule {
    return (SCNCapsule *)self.geometry;
}


- (void)setRadius:(CGFloat)radius {
    [self assertTheresNoPhysicsBody];
    self.capsule.capRadius = radius;
}

- (CGFloat)radius {
    return self.capsule.capRadius;
}

- (void)setHeight:(CGFloat)height {
    [self assertTheresNoPhysicsBody];
    self.capsule.height = height;
}

- (CGFloat)height {
    return self.capsule.height;
}

@end
