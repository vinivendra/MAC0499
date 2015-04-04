

#import "Plane.h"


@implementation Plane

+ (instancetype)plane {
    return [self create];
}

- (instancetype)init {
    if (self = [super init]) {
        self.plane = [SCNPlane new];
    }
    return self;
}

- (instancetype)initWithWidth:(CGFloat)width
                       height:(CGFloat)height {
    if (self = [super init]) {
        self.plane = [SCNPlane planeWithWidth:width height:height];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setPlane:(SCNPlane *)plane {
    self.geometry = plane;
}

- (SCNPlane *)plane {
    return (SCNPlane *)self.geometry;
}


- (void)setWidth:(CGFloat)width {
    [self assertTheresNoPhysicsBody];
    self.plane.width = width;
}

- (CGFloat)width {
    return self.plane.width;
}

- (void)setHeight:(CGFloat)height {
    [self assertTheresNoPhysicsBody];
    self.plane.height = height;
}

- (CGFloat)height {
    return self.plane.height;
}

@end
