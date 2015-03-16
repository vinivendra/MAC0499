

#import "Sphere.h"


@implementation Sphere

- (instancetype)init {
    if ( self = [super init] ) {
        self.sphere = [SCNSphere new];
    }
    return self;
}

- (instancetype)initWithRadius:(CGFloat)radius {
    if ( self = [super init] ) {
        self.sphere = [SCNSphere new];
        self.sphere.radius = radius;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setSphere:(SCNSphere *)sphere {
    self.geometry = sphere;
}

- (SCNSphere *)sphere {
    return (SCNSphere *)self.geometry;
}


- (void)setRadius:(CGFloat)radius {
    self.sphere.radius = radius;
}

- (CGFloat)radius {
    return self.sphere.radius;
}

@end
