

#import "Physics.h"
#import "Contact.h"

#import "SCNScene+Extension.h"

#import "EngineKit.h"


@implementation Physics

@synthesize gravity = _gravity;

+ (Physics *)shared {
    static Physics *singleton;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      singleton = [self new];
                  });

    return singleton;
}

- (instancetype)initWithScene:(SCNScene *)scene {
    if (self = [super init]) {
        _scene = scene;
        self.scene.physicsWorld.contactDelegate = self;
    }
    return self;
}

- (void)physicsWorld:(SCNPhysicsWorld *)world
     didBeginContact:(SCNPhysicsContact *)contact {
    [Contact triggerActionForContact:contact];
}

- (void)physicsWorld:(SCNPhysicsWorld *)world
    didUpdateContact:(SCNPhysicsContact *)contact {
}

- (void)physicsWorld:(SCNPhysicsWorld *)world
       didEndContact:(SCNPhysicsContact *)contact {
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setGravity:(id)gravity {
    Vector *vector;
    if ([gravity isKindOfClass:[NSNumber class]]) {
        vector = [[Vector alloc] initWithX:0
                                         Y:-((NSNumber *)gravity).doubleValue
                                         Z:0];
        self.scene.physicsWorld.gravity = [vector toSCNVector3];
    } else {
        vector = [[Vector alloc] initWithObject:gravity];
        self.scene.physicsWorld.gravity = [vector toSCNVector3];
    }

    _gravity = vector;
}

- (id)gravity {
    if (!_gravity) {
        _gravity =
            [[Vector alloc] initWithSCNVector3:self.scene.physicsWorld.gravity];
    }
    return _gravity;
}

- (void)setAddContact:(id)contact {
    [Contact registerContact:contact];
}

- (id)addContact {
    assert(false); // This property is meant to be used only for its setter.
}

@end
