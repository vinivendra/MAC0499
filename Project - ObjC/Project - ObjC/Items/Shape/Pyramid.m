

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

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setPyramid:(SCNPyramid *)pyramid {
    self.geometry = pyramid;
}

- (SCNPyramid *)pyramid {
    return (SCNPyramid *)self.geometry;
}


- (void)setWidth:(CGFloat)width {
    self.pyramid.width = width;
}

- (CGFloat)width {
    return self.pyramid.width;
}

- (void)setHeight:(CGFloat)height {
    self.pyramid.height = height;
}

- (CGFloat)height {
    return self.pyramid.height;
}

- (void)setLength:(CGFloat)length {
    self.pyramid.length = length;
}

- (CGFloat)length {
    return self.pyramid.length;
}

@end
