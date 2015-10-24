

#import "Torus.h"


@implementation Torus

- (NSArray <NSString *>*)numericProperties {
    return @[@"ringRadius",
             @"pipeRadius"];
}

+ (instancetype)torus {
    return [self new];
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initAndAddToScene {
    if (self = [super initAndAddToScene]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.torus = [SCNTorus new];
    self.color = @"lightGray";
}

- (instancetype)initWithRingRadius:(CGFloat)ringRadius
                        pipeRadius:(CGFloat)pipeRadius {
    if (self = [super initAndAddToScene]) {
        self.torus =
        [SCNTorus torusWithRingRadius:ringRadius pipeRadius:pipeRadius];
        self.color = @"lightGray";
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

- (NSMutableArray *)propertyStringsBasedOnTemplate:(Torus *)template {
    NSMutableArray *statements = [NSMutableArray new];

    if (![self.ringRadius isEqual:template.ringRadius]) {
        [statements addObject:[NSString stringWithFormat:@"ringRadius is %@",
                               self.ringRadius]];
    }
    if (![self.pipeRadius isEqual:template.pipeRadius]) {
        [statements addObject:[NSString stringWithFormat:@"pipeRadius is %@",
                               self.pipeRadius]];
    }

    NSMutableArray *superStatements;
    superStatements = [super propertyStringsBasedOnTemplate:template];
    statements = [[statements arrayByAddingObjectsFromArray:superStatements]
                  mutableCopy];
    return statements;
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
    self.torus.pipeRadius = pipeRadius.doubleValue;
}

- (NSNumber *)pipeRadius {
    return @(self.torus.pipeRadius);
}

- (void)setRingRadius:(NSNumber *)ringRadius {
    self.torus.ringRadius = ringRadius.doubleValue;
}

- (NSNumber *)ringRadius {
    return @(self.torus.ringRadius);
}


@end
