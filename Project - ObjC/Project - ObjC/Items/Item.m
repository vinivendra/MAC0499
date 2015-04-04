

#import "Item.h"


static NSUInteger globalID = 0;


@implementation Item

+ (NSMutableDictionary *)items {
    static NSMutableDictionary *items;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      items = [NSMutableDictionary new];
                  });

    return items;
}


+ (instancetype)create {
    return [self new];
}

- (instancetype)init {
    if (self = [super init]) {
        self.node = [SCNNode node];
        self.node.item = self;
        self.ID = [Item newID];

        [[SCNScene shared] addItem:self];
    }
    return self;
}

+ (NSUInteger)newID {
    return globalID++;
}

// FIXME: Destroying an item should free its memory.
- (void)destroy {
    self.node.hidden = YES;
    self.node.position = SCNVector3Make(FLT_MAX, FLT_MAX, FLT_MAX);
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setPosition:(id)position {
    self.node.position =
        [[[Position alloc] initWithObject:position] toSCNVector];
}

- (id)position {
    return [[Position alloc] initWithSCNVector:self.node.position];
}

- (void)setRotation:(id)rotation {
    self.node.rotation =
        [[[Rotation alloc] initWithObject:rotation] toSCNVector];
}

- (id)rotation {
    return [[Rotation alloc] initWithSCNVector4:self.node.rotation];
}

- (void)setScale:(id)scale {
    self.node.scale = [[Vector alloc] initWithObject:scale].toSCNVector;
}

- (id)scale {
    return [[Vector alloc] initWithSCNVector:self.node.scale];
}

- (void)setGeometry:(SCNGeometry *)geometry {
    self.node.geometry = geometry;
}

- (SCNGeometry *)geometry {
    return self.node.geometry;
}

@end
