

#import "Cone.h"


@implementation Cone

- (NSArray <NSString *>*)numericProperties {
    return @[@"radius",
             @"topRadius",
             @"bottomRadius",
             @"height"];
}

+ (instancetype)cone {
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
    self.cone = [SCNCone new];
    self.color = @"lightGray";
}

- (instancetype)initWithTopRadius:(CGFloat)topRadius
                     bottomRadius:(CGFloat)bottomRadius
                           height:(CGFloat)height {
    if (self = [super initAndAddToScene]) {
        self.cone = [SCNCone coneWithTopRadius:topRadius
                                  bottomRadius:bottomRadius
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

- (void)copyInfoTo:(Cone *)item {
    [super copyInfoTo:item];
    
    item.bottomRadius = self.bottomRadius;
    item.topRadius = self.topRadius;
    item.height = self.height;
}

- (NSMutableArray *)propertyStringsBasedOnTemplate:(Cone *)template {
    NSMutableArray *statements = [NSMutableArray new];

    if (![self.radius isEqual:template.radius]) {
        [statements addObject:[NSString stringWithFormat:@"radius is %@",
                               self.radius]];
    }
    if (![self.topRadius isEqual:template.topRadius]) {
        [statements addObject:[NSString stringWithFormat:@"topRadius is %@",
                               self.topRadius]];
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

- (void)setCone:(SCNCone *)cone {
    self.geometry = cone;
}

- (SCNCone *)cone {
    return (SCNCone *)self.geometry;
}


- (void)setRadius:(NSNumber *)radius {
    self.cone.bottomRadius = radius.doubleValue;
}

- (NSNumber *)radius {
    return @(self.cone.bottomRadius);
}

- (void)setBottomRadius:(NSNumber *)radius {
    self.radius = radius;
}

- (NSNumber *)bottomRadius {
    return self.radius;
}

- (void)setTopRadius:(NSNumber *)radius {
    self.cone.topRadius = radius.doubleValue;
}

- (NSNumber *)topRadius {
    return @(self.cone.topRadius);
}

- (void)setHeight:(NSNumber *)height {
    self.cone.height = height.doubleValue;
}

- (NSNumber *)height {
    return @(self.cone.height);
}

@end
