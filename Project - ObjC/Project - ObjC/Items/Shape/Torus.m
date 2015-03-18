

#import "Torus.h"


@implementation Torus

+ (instancetype)torus {
    return [self create];
}

- (instancetype)init {
    if (self = [super init]) {
        self.torus = [SCNTorus new];
    }
    return self;
}

- (instancetype)initWithRingRadius:(CGFloat)ringRadius pipeRadius:(CGFloat)pipeRadius {
    if (self = [super init]) {
        self.torus = [SCNTorus torusWithRingRadius:ringRadius pipeRadius:pipeRadius];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setTorus:(SCNTorus *)torus {
    self.geometry = torus;
}

- (SCNTorus *)torus {
    return (SCNTorus *)self.geometry;
}


- (void)setPipeRadius:(CGFloat)pipeRadius {
    self.torus.pipeRadius = pipeRadius;
}

- (CGFloat)pipeRadius {
    return self.torus.pipeRadius;
}

- (void)setRingRadius:(CGFloat)ringRadius {
    self.torus.ringRadius = ringRadius;
}

- (CGFloat)ringRadius {
    return self.torus.ringRadius;
}

@end
