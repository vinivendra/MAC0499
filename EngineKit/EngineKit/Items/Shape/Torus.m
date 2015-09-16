

#import "Torus.h"


@implementation Torus

+ (instancetype)torus {
    return [self new];
}

- (instancetype)init {
    if (self = [super init]) {
        self.torus = [SCNTorus new];
    }
    return self;
}

- (instancetype)initAndAddToScene {
    if (self = [super initAndAddToScene]) {
        self.torus = [SCNTorus new];
    }
    return self;
}

- (instancetype)initWithRingRadius:(CGFloat)ringRadius
                        pipeRadius:(CGFloat)pipeRadius {
    if (self = [super initAndAddToScene]) {
        self.torus =
            [SCNTorus torusWithRingRadius:ringRadius pipeRadius:pipeRadius];
    }
    return self;
}

- (Item *)deepCopy {
    Shape *newItem = [[self class] new];
    [self copyInfoTo:newItem];
    [super copyPhysicsTo:newItem];
    return newItem;
}

- (void)copyInfoTo:(Torus *)item {
    [super copyInfoTo:item];

    item.ringRadius = self.ringRadius;
    item.pipeRadius = self.pipeRadius;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setTorus:(SCNTorus *)torus {
    self.geometry = torus;
}

- (SCNTorus *)torus {
    return (SCNTorus *)self.geometry;
}


- (void)setPipeRadius:(NSNumber *)pipeRadius {
    [self assertTheresNoPhysicsBody];
    self.torus.pipeRadius = pipeRadius.doubleValue;
}

- (NSNumber *)pipeRadius {
    return @(self.torus.pipeRadius);
}

- (void)setRingRadius:(NSNumber *)ringRadius {
    [self assertTheresNoPhysicsBody];
    self.torus.ringRadius = ringRadius.doubleValue;
}

- (NSNumber *)ringRadius {
    return @(self.torus.ringRadius);
}


@end
