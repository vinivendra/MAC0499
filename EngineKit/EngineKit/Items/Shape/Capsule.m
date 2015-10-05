

#import "Capsule.h"


@implementation Capsule

+ (instancetype)capsule {
    return [self new];
}

- (instancetype)init {
    if (self = [super init]) {
        self.capsule = [SCNCapsule new];
    }
    return self;
}

- (instancetype)initAndAddToScene {
    if (self = [super initAndAddToScene]) {
        self.capsule = [SCNCapsule new];
    }
    return self;
}

- (instancetype)initWithRadius:(CGFloat)radius height:(CGFloat)height {
    if (self = [super initAndAddToScene]) {
        self.capsule = [SCNCapsule capsuleWithCapRadius:radius height:height];
    }
    return self;
}

- (Item *)deepCopy {
    Shape *newItem = [[self class] new];
    [self copyInfoTo:newItem];
    [super copyPhysicsTo:newItem];
    return newItem;
}

- (void)copyInfoTo:(Capsule *)item {
    [super copyInfoTo:item];
    
    item.radius = self.radius;
    item.height = self.height;
}

- (NSMutableArray *)propertyStringsBasedOnTemplate:(Capsule *)template {
    NSMutableArray *statements = [NSMutableArray new];

    if (![self.radius isEqual:template.radius]) {
        [statements addObject:[NSString stringWithFormat:@"radius is %@",
                               self.radius]];
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

- (void)setCapsule:(SCNCapsule *)capsule {
    self.geometry = capsule;
}

- (SCNCapsule *)capsule {
    return (SCNCapsule *)self.geometry;
}


- (void)setRadius:(NSNumber *)radius {
    [self assertTheresNoPhysicsBody];
    self.capsule.capRadius = radius.doubleValue;
}

- (NSNumber *)radius {
    return @(self.capsule.capRadius);
}

- (void)setHeight:(NSNumber *)height {
    [self assertTheresNoPhysicsBody];
    self.capsule.height = height.doubleValue;
}

- (NSNumber *)height {
    return @(self.capsule.height);
}

@end
