

#import "Plane.h"


@implementation Plane

- (NSArray <NSString *>*)numericProperties {
    return @[@"width",
             @"height"];
}

+ (instancetype)plane {
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
    self.plane = [SCNPlane new];
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

- (NSMutableArray *)propertyStringsBasedOnTemplate:(Plane *)template {
    NSMutableArray *statements = [NSMutableArray new];

    if (![self.width isEqual:template.width]) {
        [statements addObject:[NSString stringWithFormat:@"width is %@",
                               self.width]];
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

- (void)setPlane:(SCNPlane *)plane {
    self.geometry = plane;
}

- (SCNPlane *)plane {
    return (SCNPlane *)self.geometry;
}


- (void)setWidth:(NSNumber *)width {
    self.plane.width = width.doubleValue;
}

- (NSNumber *)width {
    return @(self.plane.width);
}

- (void)setHeight:(NSNumber *)height {
    self.plane.height = height.doubleValue;
}

- (NSNumber *)height {
    return @(self.plane.height);
}

@end
