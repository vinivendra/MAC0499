

#import "Cylinder.h"


@implementation Cylinder

+ (instancetype)cylinder {
    return [self create];
}

- (instancetype)init {
    if (self = [super init]) {
        self.cylinder = [SCNCylinder new];
    }
    return self;
}

- (instancetype)initWithRadius:(CGFloat)radius height:(CGFloat)height {
    if (self = [super init]) {
        self.cylinder = [SCNCylinder cylinderWithRadius:radius height:height];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setCylinder:(SCNCylinder *)cylinder {
    self.geometry = cylinder;
}

- (SCNCylinder *)cylinder {
    return (SCNCylinder *)self.geometry;
}


- (void)setRadius:(CGFloat)radius {
    self.cylinder.radius = radius;
}

- (CGFloat)radius {
    return self.cylinder.radius;
}

- (void)setHeight:(CGFloat)height {
    self.cylinder.height = height;
}

- (CGFloat)height {
    return self.cylinder.height;
}

@end
