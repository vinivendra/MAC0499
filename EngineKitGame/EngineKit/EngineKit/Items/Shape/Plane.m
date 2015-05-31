

#import "Plane.h"


@implementation Plane

+ (instancetype)plane {
    return [self new];
}

- (instancetype)init {
    if (self = [super initAndAddToScene]) {
        self.plane = [SCNPlane new];
    }
    return self;
}

- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height {
    if (self = [super initAndAddToScene]) {
        self.plane = [SCNPlane planeWithWidth:width height:height];
    }
    return self;
}

- (Item *)deepCopy {
    Shape *newItem = [[self class] new];
    [self copyInfoTo:newItem];
    [super copyPhysicsTo:newItem];
    return newItem;
}

- (void)copyInfoTo:(Plane *)item {
    [super copyInfoTo:item];
    
    item.width = self.width;
    item.height = self.height;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setPlane:(SCNPlane *)plane {
    self.geometry = plane;
}

- (SCNPlane *)plane {
    return (SCNPlane *)self.geometry;
}


- (void)setWidth:(NSNumber *)width {
    [self assertTheresNoPhysicsBody];
    self.plane.width = width.doubleValue;
}

- (NSNumber *)width {
    return @(self.plane.width);
}

- (void)setHeight:(NSNumber *)height {
    [self assertTheresNoPhysicsBody];
    self.plane.height = height.doubleValue;
}

- (NSNumber *)height {
    return @(self.plane.height);
}

@end
