

#import "Item.h"

#import "SCNScene+Extension.h"
#import "SCNNode+Extension.h"
#import "NSArray+Extension.h"

#import "NSMutableArray+ObjectiveSugar.h"

#import "Common.h"

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
    [[SCNScene currentScene] addItem:newItem];
    return newItem;
}

- (instancetype)create {
    Item *newItem = [self deepCopy];
    [[SCNScene currentScene] addItem:newItem];
    return newItem;
}

- (instancetype)initAndAddToScene {
    if (self = [super init]) {
        [self commonInit];
        [[SCNScene currentScene] addItem:self];
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
    self.name = NSStringFromClass(self.class);
    _children = [NSMutableArray new];
}

- (NSString *)description {
    return NSStringFromClass([self class]);
}

+ (NSUInteger)newID {
    return globalID++;
}

- (void)setHidden:(BOOL)hidden {
    self.node.hidden = hidden;
}

- (BOOL)hidden {
    return self.node.hidden;
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
    }

    item.position = self.position;
    item.rotation = self.rotation;
    item.scale = self.scale;

    for (Item *child in self.children)
        [item addItem:[child deepCopy]];
}

- (void)rotate:(id)rotation {
    Rotation *rotationObject = [[Rotation alloc] initWithObject:rotation];
    Vector *position = self.position;

    SCNMatrix4 result = [position.opposite translateMatrix:self.node.transform];
    result = [rotationObject rotateMatrix:result];
    result = [position translateMatrix:result];

    self.node.transform = result;
}

- (void)rotate:(id)rotation around:(id)anchor {
    Rotation *rotationObject = [[Rotation alloc] initWithObject:rotation];
    Vector *translation = [[Vector alloc] initWithObject:anchor];

    SCNMatrix4 result =
    [translation.opposite translateMatrix:self.node.transform];
    result = [rotationObject rotateMatrix:result];
    result = [translation translateMatrix:result];

    self.node.transform = result;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Actions

- (void)setPositionX:(NSNumber *)newValue {
    Position *oldPosition = self.position;
    self.position = [[Position alloc] initWithX:newValue.doubleValue
                                              Y:oldPosition.y
                                              Z:oldPosition.z];
}

- (void)setPositionY:(NSNumber *)newValue {
    Position *oldPosition = self.position;
    self.position = [[Position alloc] initWithX:oldPosition.x
                                              Y:newValue.doubleValue
                                              Z:oldPosition.z];
}

- (void)setPositionZ:(NSNumber *)newValue {
    Position *oldPosition = self.position;
    self.position = [[Position alloc] initWithX:oldPosition.x
                                              Y:oldPosition.y
                                              Z:newValue.doubleValue];
}

- (void)setScaleX:(NSNumber *)newValue {
    Vector *oldScale = self.scale;
    self.scale = [[Vector alloc] initWithX:newValue.doubleValue
                                         Y:oldScale.y
                                         Z:oldScale.z];
}

- (void)setScaleY:(NSNumber *)newValue {
    Vector *oldScale = self.scale;
    self.scale = [[Vector alloc] initWithX:oldScale.x
                                         Y:newValue.doubleValue
                                         Z:oldScale.z];
}

- (void)setScaleZ:(NSNumber *)newValue {
    Vector *oldScale = self.scale;
    self.scale = [[Vector alloc] initWithX:oldScale.x
                                         Y:oldScale.y
                                         Z:newValue.doubleValue];
}

- (void)setRotationX:(NSNumber *)newValue {
    Rotation *oldRotation = self.rotation;
    self.rotation = [[Rotation alloc] initWithX:newValue.doubleValue
                                              Y:oldRotation.y
                                              Z:oldRotation.z
                                          Angle:oldRotation.a];
}

- (void)setRotationY:(NSNumber *)newValue {
    Rotation *oldRotation = self.rotation;
    self.rotation = [[Rotation alloc] initWithX:oldRotation.x
                                              Y:newValue.doubleValue
                                              Z:oldRotation.z
                                          Angle:oldRotation.a];
}

- (void)setRotationZ:(NSNumber *)newValue {
    Rotation *oldRotation = self.rotation;
    self.rotation = [[Rotation alloc] initWithX:oldRotation.x
                                              Y:oldRotation.y
                                              Z:newValue.doubleValue
                                          Angle:oldRotation.a];
}

- (void)setRotationA:(NSNumber *)newValue {
    Rotation *oldRotation = self.rotation;
    self.rotation = [[Rotation alloc] initWithX:oldRotation.x
                                              Y:oldRotation.y
                                              Z:oldRotation.z
                                          Angle:newValue.doubleValue];
}


- (NSNumber *)positionX {
    return @(((Position *)self.position).x);
}

- (NSNumber *)positionY {
    return @(((Position *)self.position).y);
}

- (NSNumber *)positionZ {
    return @(((Position *)self.position).z);
}

- (NSNumber *)scaleX {
    return @(((Vector *)self.scale).x);
}

- (NSNumber *)scaleY {
    return @(((Vector *)self.scale).y);
}

- (NSNumber *)scaleZ {
    return @(((Vector *)self.scale).z);
}

- (NSNumber *)rotationX {
    return @(((Rotation *)self.rotation).x);
}

- (NSNumber *)rotationY {
    return @(((Rotation *)self.rotation).y);
}

- (NSNumber *)rotationZ {
    return @(((Rotation *)self.rotation).z);
}

- (NSNumber *)rotationA {
    return @(((Rotation *)self.rotation).a);
}


- (void)addPositionX:(NSNumber *)newValue {
    Position *oldPosition = self.position;
    self.position = [[Position alloc]
                     initWithX:oldPosition.x + newValue.doubleValue
                     Y:oldPosition.y
                     Z:oldPosition.z];
}

- (void)addPositionY:(NSNumber *)newValue {
    Position *oldPosition = self.position;
    self.position = [[Position alloc]
                     initWithX:oldPosition.x
                     Y:oldPosition.y + newValue.doubleValue
                     Z:oldPosition.z];
}

- (void)addPositionZ:(NSNumber *)newValue {
    Position *oldPosition = self.position;
    self.position = [[Position alloc]
                     initWithX:oldPosition.x
                     Y:oldPosition.y
                     Z:oldPosition.z + newValue.doubleValue];
}

- (void)addScaleX:(NSNumber *)newValue {
    Vector *oldScale = self.scale;
    self.scale = [[Vector alloc]
                  initWithX:oldScale.x + newValue.doubleValue
                  Y:oldScale.y
                  Z:oldScale.z];
}

- (void)addScaleY:(NSNumber *)newValue {
    Vector *oldScale = self.scale;
    self.scale = [[Vector alloc]
                  initWithX:oldScale.x
                  Y:oldScale.y + newValue.doubleValue
                  Z:oldScale.z];
}

- (void)addScaleZ:(NSNumber *)newValue {
    Vector *oldScale = self.scale;
    self.scale = [[Vector alloc]
                  initWithX:oldScale.x
                  Y:oldScale.y
                  Z:oldScale.z + newValue.doubleValue];
}

- (void)addRotationX:(NSNumber *)newValue {
    Rotation *oldRotation = self.rotation;
    self.rotation = [[Rotation alloc]
                     initWithX:oldRotation.x + newValue.doubleValue
                     Y:oldRotation.y
                     Z:oldRotation.z
                     Angle:oldRotation.a];
}

- (void)addRotationY:(NSNumber *)newValue {
    Rotation *oldRotation = self.rotation;
    self.rotation = [[Rotation alloc]
                     initWithX:oldRotation.x
                     Y:oldRotation.y + newValue.doubleValue
                     Z:oldRotation.z
                     Angle:oldRotation.a];
}

- (void)addRotationZ:(NSNumber *)newValue {
    Rotation *oldRotation = self.rotation;
    self.rotation = [[Rotation alloc]
                     initWithX:oldRotation.x
                     Y:oldRotation.y
                     Z:oldRotation.z + newValue.doubleValue
                     Angle:oldRotation.a];
}

- (void)addRotationA:(NSNumber *)newValue {
    Rotation *oldRotation = self.rotation;
    self.rotation = [[Rotation alloc]
                     initWithX:oldRotation.x
                     Y:oldRotation.y
                     Z:oldRotation.z
                     Angle:oldRotation.a + newValue.doubleValue];
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
