

#import "Sphere.h"


@implementation Sphere

+ (instancetype)sphere {
    return [self new];
}

- (instancetype)init {
    if (self = [super init]) {
        self.sphere = [SCNSphere new];
    }
    return self;
}

- (instancetype)initAndAddToScene {
    if (self = [super initAndAddToScene]) {
        self.sphere = [SCNSphere new];
    }
    return self;
}

- (instancetype)initWithRadius:(CGFloat)radius {
    if (self = [super initAndAddToScene]) {
        self.sphere = [SCNSphere sphereWithRadius:radius];
    }
    return self;
}

- (Item *)deepCopy {
    Shape *newItem = [[self class] new];
    [self copyInfoTo:newItem];
    [super copyPhysicsTo:newItem];
    return newItem;
}

- (void)copyInfoTo:(Sphere *)item {
    [super copyInfoTo:item];
    
    item.radius = self.radius;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setSphere:(SCNSphere *)sphere {
    self.geometry = sphere;
}

- (SCNSphere *)sphere {
    return (SCNSphere *)self.geometry;
}


- (void)setRadius:(NSNumber *)radius {
    [self assertTheresNoPhysicsBody];
    self.sphere.radius = radius.doubleValue;
}

- (NSNumber *)radius {
    return @(self.sphere.radius);
}

@end
