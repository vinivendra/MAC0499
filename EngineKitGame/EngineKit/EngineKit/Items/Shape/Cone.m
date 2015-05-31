

#import "Cone.h"


@implementation Cone

+ (instancetype)cone {
    return [self new];
}

- (instancetype)init {
    if (self = [super initAndAddToScene]) {
        self.cone = [SCNCone new];
    }
    return self;
}

- (instancetype)initWithTopRadius:(CGFloat)topRadius
                     bottomRadius:(CGFloat)bottomRadius
                           height:(CGFloat)height {
    if (self = [super initAndAddToScene]) {
        self.cone = [SCNCone coneWithTopRadius:topRadius
                                  bottomRadius:bottomRadius
                                        height:height];
    }
    return self;
}

- (Item *)deepCopy {
    Shape *newItem = [[self class] new];
    [self copyInfoTo:newItem];
    [super copyPhysicsTo:newItem];
    return newItem;
}

- (void)copyInfoTo:(Cone *)item {
    [super copyInfoTo:item];
    
    item.bottomRadius = self.bottomRadius;
    item.topRadius = self.topRadius;
    item.height = self.height;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setCone:(SCNCone *)cone {
    self.geometry = cone;
}

- (SCNCone *)cone {
    return (SCNCone *)self.geometry;
}


- (void)setRadius:(NSNumber *)radius {
    [self assertTheresNoPhysicsBody];
    self.cone.bottomRadius = radius.doubleValue;
}

- (NSNumber *)radius {
    return @(self.cone.bottomRadius);
}

- (void)setBottomRadius:(NSNumber *)radius {
    [self assertTheresNoPhysicsBody];
    self.radius = radius;
}

- (NSNumber *)bottomRadius {
    return self.radius;
}

- (void)setTopRadius:(NSNumber *)radius {
    [self assertTheresNoPhysicsBody];
    self.cone.topRadius = radius.doubleValue;
}

- (NSNumber *)topRadius {
    return @(self.cone.topRadius);
}

- (void)setHeight:(NSNumber *)height {
    [self assertTheresNoPhysicsBody];
    self.cone.height = height.doubleValue;
}

- (NSNumber *)height {
    return @(self.cone.height);
}

@end
