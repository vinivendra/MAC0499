

#import "Pyramid.h"


@implementation Pyramid

- (NSArray <NSString *>*)numericProperties {
    return @[@"width",
             @"height",
             @"length"];
}

+ (instancetype)pyramid {
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
    self.pyramid = [SCNPyramid new];
    self.color = @"lightGray";
}

- (instancetype)initWithWidth:(CGFloat)width
                       height:(CGFloat)height
                       length:(CGFloat)length {
    if (self = [super initAndAddToScene]) {
        self.pyramid =
        [SCNPyramid pyramidWithWidth:width height:height length:length];
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

- (void)copyInfoTo:(Pyramid *)item {
    [super copyInfoTo:item];
    
    item.width = self.width;
    item.height = self.height;
    item.length = self.length;
}

- (NSMutableArray *)propertyStringsBasedOnTemplate:(Pyramid *)template {
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

- (void)setPyramid:(SCNPyramid *)pyramid {
    self.geometry = pyramid;
}

- (SCNPyramid *)pyramid {
    return (SCNPyramid *)self.geometry;
}


- (void)setWidth:(NSNumber *)width {
    self.pyramid.width = width.doubleValue;
}

- (NSNumber *)width {
    return @(self.pyramid.width);
}

- (void)setHeight:(NSNumber *)height {
    self.pyramid.height = height.doubleValue;
}

- (NSNumber *)height {
    return @(self.pyramid.height);
}

- (void)setLength:(NSNumber *)length {
    self.pyramid.length = length.doubleValue;
}

- (NSNumber *)length {
    return @(self.pyramid.length);
}

@end
