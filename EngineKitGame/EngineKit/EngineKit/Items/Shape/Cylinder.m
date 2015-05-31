

#import "Cylinder.h"


@implementation Cylinder

+ (instancetype)cylinder {
    return [self new];
}

- (instancetype)init {
    if (self = [super init]) {
        self.cylinder = [SCNCylinder new];
    }
    return self;
}

- (instancetype)initAndAddToScene {
    if (self = [super initAndAddToScene]) {
        self.cylinder = [SCNCylinder new];
    }
    return self;
}

- (instancetype)initWithRadius:(CGFloat)radius height:(CGFloat)height {
    if (self = [super initAndAddToScene]) {
        self.cylinder = [SCNCylinder cylinderWithRadius:radius height:height];
    }
    return self;
}

- (Item *)deepCopy {
    Shape *newItem = [[self class] new];
    [self copyInfoTo:newItem];
    [super copyPhysicsTo:newItem];
    return newItem;
}

- (void)copyInfoTo:(Cylinder *)item {
    [super copyInfoTo:item];

    item.radius = self.radius;
    item.height = self.height;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setCylinder:(SCNCylinder *)cylinder {
    self.geometry = cylinder;
}

- (SCNCylinder *)cylinder {
    return (SCNCylinder *)self.geometry;
}


- (void)setRadius:(NSNumber *)radius {
    [self assertTheresNoPhysicsBody];
    self.cylinder.radius = radius.doubleValue;
}

- (NSNumber *)radius {
    return @(self.cylinder.radius);
}

- (void)setHeight:(NSNumber *)height {
    [self assertTheresNoPhysicsBody];
    self.cylinder.height = height.doubleValue;
}

- (NSNumber *)height {
    return @(self.cylinder.height);
}

@end
