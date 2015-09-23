

#import "Item.h"

#import "SCNScene+Extension.h"
#import "SCNNode+Extension.h"
#import "NSArray+Extension.h"

#import "NSMutableArray+ObjectiveSugar.h"

#import "Position.h"


@interface ConstantAction : NSObject
@property (nonatomic) SEL selector;
@property (nonatomic, strong) id arguments;
@end
@implementation ConstantAction
@end

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

    item.actions = [self copyActions];

    for (Item *child in self.children)
        [item addItem:[child deepCopy]];
}

- (NSMutableDictionary *)copyActions {
    NSMutableDictionary *newDictionary = [NSMutableDictionary new];

    NSEnumerator *enumerator = self.actions.keyEnumerator;

    NSNumber *key;

    while ((key = enumerator.nextObject)) {
        NSMutableArray *array = self.actions[key];
        newDictionary[key] = array.copy;
    }

    return newDictionary;
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

- (void)addAction:(NSArray *)action
       forTrigger:(NSNumber *)trigger
    withArguments:(id)arguments {

    SEL selector = [self actionForArray:action];

    ConstantAction *constantAction = [ConstantAction new];
    constantAction.selector = selector;
    constantAction.arguments = arguments;

    [self addAction:constantAction forTrigger:trigger];
}

- (SEL)actionForArray:(NSArray *)array {
    return NSSelectorFromString([[array joinInCamelCase] stringByAppendingString:@":"]);
}

- (void)addAction:(ConstantAction *)action forTrigger:(NSNumber *)trigger {
    NSMutableArray *array = self.actions[trigger];
    if (!array) {
        array = [NSMutableArray array];
        self.actions[trigger] = array;
    }
    [array addObject:action];
}

- (void)callActionForTrigger:(UIGestures)gesture {
    NSMutableArray *array = self.actions[@(gesture)];

    for (ConstantAction *action in array) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:action.selector withObject:action.arguments];
#pragma clang diagnostic pop
    }
}

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
    self.position = [[Position alloc] initWithX:oldPosition.z
                                              Y:oldPosition.y
                                              Z:newValue.doubleValue];
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

- (NSMutableDictionary<NSNumber *,NSMutableArray *> *)actions {
    if (!_actions) {
        _actions = [NSMutableDictionary dictionary];
    }
    return _actions;
}

@end
