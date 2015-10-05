

#import "Tube.h"


@implementation Tube

+ (instancetype)tube {
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
    self.tube = [SCNTube new];
    self.color = @"lightGray";
}

- (instancetype)initWithInnerRadius:(CGFloat)innerRadius
                        outerRadius:(CGFloat)outerRadius
                             height:(CGFloat)height {
    if (self = [super initAndAddToScene]) {
        self.tube = [SCNTube tubeWithInnerRadius:innerRadius
                                     outerRadius:outerRadius
                                          height:height];
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

- (void)copyInfoTo:(Tube *)item {
    [super copyInfoTo:item];

    item.outerRadius = self.outerRadius;
    item.innerRadius = self.innerRadius;
    item.height = self.height;
}

- (NSMutableArray *)propertyStringsBasedOnTemplate:(Tube *)template {
    NSMutableArray *statements = [NSMutableArray new];

    if (![self.innerRadius isEqual:template.innerRadius]) {
        [statements addObject:[NSString stringWithFormat:@"innerRadius is %@",
                               self.innerRadius]];
    }
    if (![self.outerRadius isEqual:template.outerRadius]) {
        [statements addObject:[NSString stringWithFormat:@"outerRadius is %@",
                               self.outerRadius]];
    }
    if (![self.height isEqual:template.height]) {
        [statements addObject:[NSString stringWithFormat:@"height is %@",
                               self.height]];
    }

    NSMutableArray *superStatements;
    superStatements = [super propertyStringsBasedOnTemplate:template];
    statements = [[statements arrayByAddingObjectsFromArray:superStatements]
                  mutableCopy];
    return statements;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setTube:(SCNTube *)tube {
    self.geometry = tube;
}

- (SCNTube *)tube {
    return (SCNTube *)self.geometry;
}


- (void)setRadius:(NSNumber *)radius {
    [self assertTheresNoPhysicsBody];

    CGFloat currentRadius = (self.tube.outerRadius + self.tube.innerRadius) / 2;
    CGFloat ratio = radius.doubleValue / currentRadius;

    self.tube.innerRadius *= ratio;
    self.tube.outerRadius *= ratio;
}

- (NSNumber *)radius {
    return @((self.tube.outerRadius + self.tube.innerRadius) / 2);
}

- (void)setInnerRadius:(NSNumber *)innerRadius {
    [self assertTheresNoPhysicsBody];
    self.tube.innerRadius = innerRadius.doubleValue;
}

- (NSNumber *)innerRadius {
    return @(self.tube.innerRadius);
}

- (void)setOuterRadius:(NSNumber *)outerRadius {
    [self assertTheresNoPhysicsBody];
    self.tube.outerRadius = outerRadius.doubleValue;
}

- (NSNumber *)outerRadius {
    return @(self.tube.outerRadius);
}

- (void)setHeight:(NSNumber *)height {
    [self assertTheresNoPhysicsBody];
    self.tube.height = height.doubleValue;
}

- (NSNumber *)height {
    return @(self.tube.height);
}

- (void)setThickness:(NSNumber *)thickness {
    [self assertTheresNoPhysicsBody];

    CGFloat currentRadius = (self.tube.outerRadius + self.tube.innerRadius) / 2;
    self.tube.innerRadius = currentRadius - thickness.doubleValue/2;
    self.tube.outerRadius = currentRadius + thickness.doubleValue/2;
}

- (NSNumber *)thickness {
    return @(self.tube.outerRadius - self.tube.innerRadius);
}

@end
