

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

- (Item *)deepCopy {
    Shape *newItem = [[self class] new];
    [self copyInfoTo:newItem];
    [super copyPhysicsTo:newItem];
    return newItem;
}

- (void)copyInfoTo:(Text *)item {
    [super copyInfoTo:item];

    item.depth = self.depth;
    item.string = self.string;
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

- (void)setDepth:(NSNumber *)depth {
    [self assertTheresNoPhysicsBody];
    self.text.extrusionDepth = depth.doubleValue;
}

- (NSNumber *)depth {
    return @(self.text.extrusionDepth);
}

@end
