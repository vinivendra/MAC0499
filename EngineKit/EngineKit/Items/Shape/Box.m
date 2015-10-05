

#import "Box.h"


@implementation Box

+ (instancetype)box {
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
    self.box = [SCNBox new];
    self.color = @"lightGray";
}

- (instancetype)initWithWidth:(CGFloat)width
                       height:(CGFloat)height
                       length:(CGFloat)length
                chamferRadius:(CGFloat)chamferRadius {
    if (self = [super initAndAddToScene]) {
        self.box = [SCNBox boxWithWidth:width
                                 height:height
                                 length:length
                          chamferRadius:chamferRadius];
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

- (void)copyInfoTo:(Box *)box {
    [super copyInfoTo:box];

    box.width = self.width;
    box.height = self.height;
    box.length = self.length;
    box.chamferRadius = self.chamferRadius;
}

- (NSMutableArray *)propertyStringsBasedOnTemplate:(Box *)template {
    NSMutableArray *statements = [NSMutableArray new];

    if (![self.width isEqual:template.width]) {
        [statements addObject:[NSString stringWithFormat:@"width is %@",
                               self.width]];
    }
    if (![self.height isEqual:template.height]) {
        [statements addObject:[NSString stringWithFormat:@"height is %@",
                               self.height]];
    }
    if (![self.length isEqual:template.length]) {
        [statements addObject:[NSString stringWithFormat:@"length is %@",
                               self.length]];
    }

    NSMutableArray *superStatements;
    superStatements = [super propertyStringsBasedOnTemplate:template];
    statements = [[statements arrayByAddingObjectsFromArray:superStatements]
                  mutableCopy];
    return statements;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setBox:(SCNBox *)box {
    self.geometry = box;
}

- (SCNBox *)box {
    return (SCNBox *)self.geometry;
}


- (void)setWidth:(NSNumber *)width {
    [self assertTheresNoPhysicsBody];
    self.box.width = width.doubleValue;
}

- (NSNumber *)width {
    return @(self.box.width);
}

- (void)setHeight:(NSNumber *)height {
    [self assertTheresNoPhysicsBody];
    self.box.height = height.doubleValue;
}

- (NSNumber *)height {
    return @(self.box.height);
}

- (void)setLength:(NSNumber *)length {
    [self assertTheresNoPhysicsBody];
    self.box.length = length.doubleValue;
}

- (NSNumber *)length {
    return @(self.box.length);
}

- (void)setChamferRadius:(NSNumber *)chamferRadius {
    [self assertTheresNoPhysicsBody];
    self.box.chamferRadius = chamferRadius.doubleValue;
}

- (NSNumber *)chamferRadius {
    return @(self.box.chamferRadius);
}

@end
