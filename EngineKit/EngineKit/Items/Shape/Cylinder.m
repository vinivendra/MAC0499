

#import "Cylinder.h"


@implementation Cylinder

+ (instancetype)cylinder {
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
    self.cylinder = [SCNCylinder new];
    self.color = @"lightGray";
}

- (instancetype)initWithRadius:(CGFloat)radius height:(CGFloat)height {
    if (self = [super initAndAddToScene]) {
        self.cylinder = [SCNCylinder cylinderWithRadius:radius height:height];
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

- (void)copyInfoTo:(Cylinder *)item {
    [super copyInfoTo:item];

    item.radius = self.radius;
    item.height = self.height;
}

- (NSMutableArray *)propertyStringsBasedOnTemplate:(Cylinder *)template {
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
