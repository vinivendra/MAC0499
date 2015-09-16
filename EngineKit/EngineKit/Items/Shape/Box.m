

#import "Box.h"


@implementation Box

+ (instancetype)box {
    return [self new];
}

- (instancetype)init {
    if (self = [super init]) {
        self.box = [SCNBox new];
    }
    return self;
}

- (instancetype)initAndAddToScene {
    if (self = [super initAndAddToScene]) {
        self.box = [SCNBox new];
    }
    return self;
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
