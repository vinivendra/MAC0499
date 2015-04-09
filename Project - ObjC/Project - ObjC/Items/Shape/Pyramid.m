

#import "Pyramid.h"


@implementation Pyramid

+ (instancetype)pyramid {
    return [self create];
}

- (instancetype)init {
    if (self = [super init]) {
        self.pyramid = [SCNPyramid new];
    }
    return self;
}

- (instancetype)initWithWidth:(CGFloat)width
                       height:(CGFloat)height
                       length:(CGFloat)length {
    if (self = [super init]) {
        self.pyramid =
            [SCNPyramid pyramidWithWidth:width height:height length:length];
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

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setPyramid:(SCNPyramid *)pyramid {
    self.geometry = pyramid;
}

- (SCNPyramid *)pyramid {
    return (SCNPyramid *)self.geometry;
}


- (void)setWidth:(NSNumber *)width {
    [self assertTheresNoPhysicsBody];
    self.pyramid.width = width.doubleValue;
}

- (NSNumber *)width {
    return @(self.pyramid.width);
}

- (void)setHeight:(NSNumber *)height {
    [self assertTheresNoPhysicsBody];
    self.pyramid.height = height.doubleValue;
}

- (NSNumber *)height {
    return @(self.pyramid.height);
}

- (void)setLength:(NSNumber *)length {
    [self assertTheresNoPhysicsBody];
    self.pyramid.length = length.doubleValue;
}

- (NSNumber *)length {
    return @(self.pyramid.length);
}

@end
