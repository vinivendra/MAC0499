

#import "Item.h"

#import "SCNScene+Extension.h"
#import "SCNNode+Extension.h"

#import "NSMutableArray+ObjectiveSugar.h"

#import "Position.h"


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

+ (instancetype) template {
    return [self new];
}

+ (instancetype)create {
    Item *newItem = [self new];
    [[SCNScene shared] addItem:newItem];
    return newItem;
}

- (instancetype)create {
    Item *newItem = [self deepCopy];
    [[SCNScene shared] addItem:newItem];
    return newItem;
}

- (instancetype)initAndAddToScene {
    if (self = [super init]) {
        [self commonInit];
        [[SCNScene shared] addItem:self];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.node = [SCNNode node];
    self.node.item = self;
    self.ID = [Item newID];
    self.name = @"";
    _children = [NSMutableArray new];
}

- (NSString *)description {
    return NSStringFromClass([self class]);
}

+ (NSUInteger)newID {
    return globalID++;
}

// FIXME: Destroying an item should free its memory.
- (void)destroy {
    self.node.hidden = YES;
    self.node.position = SCNVector3Make(FLT_MAX, FLT_MAX, FLT_MAX);
}

- (void)addItem:(Item *)newItem {
    [self.node addChildNode:newItem.node];
    [self.children push:newItem];
    newItem.parent = self;
}

- (void)removeFromParent {
    [self.parent.children removeObject:self];
    self.parent = nil;
}

- (Item *)deepCopy {
    Item *newItem = [[self class] new];
    [self copyInfoTo:newItem];
    return newItem;
}

- (void)copyInfoTo:(Item *)item {
    if (!item.node) {
        item.node = [SCNNode new];
        item.node.item = self;

        item.position = self.position;
        item.rotation = self.rotation;
        item.scale = self.scale;
    }

    item.position = self.position;
    item.rotation = self.rotation;
    item.scale = self.scale;

    for (Item *child in self.children)
        [item addItem:[child deepCopy]];
}

- (void)rotate:(id)rotation {
    Rotation *rotationObject = [Rotation rotationWithObject:rotation];
    Vector *position = self.position;

    SCNMatrix4 result = [position.opposite translateMatrix:self.node.transform];
    result = [rotationObject rotateMatrix:result];
    result = [position translateMatrix:result];

    self.node.transform = result;
}

- (void)rotate:(id)rotation around:(id)anchor {
    Rotation *rotationObject = [Rotation rotationWithObject:rotation];
    Vector *translation = [Vector vectorWithObject:anchor];

    SCNMatrix4 result =
        [translation.opposite translateMatrix:self.node.transform];
    result = [rotationObject rotateMatrix:result];
    result = [translation translateMatrix:result];

    self.node.transform = result;
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setPosition:(id)position {
    self.node.position =
        [[[Position alloc] initWithObject:position] toSCNVector3];
}

- (id)position {
    return [[Position alloc] initWithSCNVector3:self.node.position];
}

- (void)setRotation:(id)rotation {
    self.node.rotation =
        [[[Rotation alloc] initWithObject:rotation] toSCNVector];
}

- (id)rotation {
    return [[Rotation alloc] initWithSCNVector4:self.node.rotation];
}

- (void)setScale:(id)scale {
    self.node.scale = [[Vector alloc] initWithObject:scale].toSCNVector3;
}

- (id)scale {
    return [[Vector alloc] initWithSCNVector3:self.node.scale];
}

- (void)setGeometry:(SCNGeometry *)geometry {
    self.node.geometry = geometry;
}

- (SCNGeometry *)geometry {
    return self.node.geometry;
}


- (void)setParent:(Item *)parent {
    _parent = parent;
}

- (void)setChildren:(NSMutableArray *)children {
    _children = children;
}

@end
