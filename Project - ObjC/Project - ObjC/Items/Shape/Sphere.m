

#import "Sphere.h"


@implementation Sphere

+ (instancetype)sphere {
    return [self create];
}

- (instancetype)init {
    if (self = [super init]) {
        self.sphere = [SCNSphere new];
    }
    return self;
}

- (instancetype)initWithRadius:(CGFloat)radius {
    if (self = [super init]) {
        self.sphere = [SCNSphere sphereWithRadius:radius];
    }
    return self;
}

- (void)copyInfoTo:(Sphere *)item {
    item.sphere = [SCNSphere sphereWithRadius:self.radius];
    
    [super copyInfoTo:item];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setSphere:(SCNSphere *)sphere {
    self.geometry = sphere;
}

- (SCNSphere *)sphere {
    return (SCNSphere *)self.geometry;
}


- (void)setRadius:(CGFloat)radius {
    [self assertTheresNoPhysicsBody];
    self.sphere.radius = radius;
}

- (CGFloat)radius {
    return self.sphere.radius;
}

@end
