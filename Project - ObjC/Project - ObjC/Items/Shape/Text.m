

#import "Text.h"


@implementation Text

+ (instancetype)text {
    return [self create];
}

- (instancetype)init {
    if (self = [super init]) {
        self.text = [SCNText new];
    }
    return self;
}

- (instancetype)initWithString:(id)string depth:(CGFloat)depth {
    if (self = [super init]) {
        self.text = [SCNText textWithString:string extrusionDepth:depth];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setText:(SCNText *)text {
    self.geometry = text;
}

- (SCNText *)text {
    return (SCNText *)self.geometry;
}


- (void)setString:(id)string {
    [self assertTheresNoPhysicsBody];
    self.text.string = string;
}

- (id)string {
    return self.text.string;
}

- (void)setDepth:(CGFloat)depth {
    [self assertTheresNoPhysicsBody];
    self.text.extrusionDepth = depth;
}

- (CGFloat)depth {
    return self.text.extrusionDepth;
}

- (SCNPhysicsBodyType)physicsBodyType {
    return SCNPhysicsBodyTypeStatic;
}

@end
