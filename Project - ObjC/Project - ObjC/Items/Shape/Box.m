

#import "Box.h"


@implementation Box

+ (instancetype)box {
    return [self create];
}

- (instancetype)init {
    if (self = [super init]) {
        self.box = [SCNBox new];
    }
    return self;
}

- (instancetype)initWithWidth:(CGFloat)width
                       height:(CGFloat)height
                       length:(CGFloat)length
                chamferRadius:(CGFloat)chamferRadius {
    if (self = [super init]) {
        self.box = [SCNBox boxWithWidth:width
                                 height:height
                                 length:length
                          chamferRadius:chamferRadius];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setBox:(SCNBox *)box {
    self.geometry = box;
}

- (SCNBox *)box {
    return (SCNBox *)self.geometry;
}


- (void)setWidth:(CGFloat)width {
    self.box.width = width;
}

- (CGFloat)width {
    return self.box.width;
}

- (void)setHeight:(CGFloat)height {
    self.box.height = height;
}

- (CGFloat)height {
    return self.box.height;
}

- (void)setLength:(CGFloat)length {
    self.box.length = length;
}

- (CGFloat)length {
    return self.box.length;
}

- (void)setChamferRadius:(CGFloat)chamferRadius {
    self.box.chamferRadius = chamferRadius;
}

- (CGFloat)chamferRadius {
    return self.box.chamferRadius;
}

@end
