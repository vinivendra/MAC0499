

#import "Physics.h"
#import "Contact.h"


@interface Physics ()
@property (nonatomic, strong) Scene *scene;
@end


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

- (instancetype)init {
    if (self = [super init]) {
        self.scene.physicsWorld.contactDelegate = self;
    }
    return self;
}

- (void)physicsWorld:(SCNPhysicsWorld *)world
     didBeginContact:(SCNPhysicsContact *)contact {
    NSLog(@"Begin");
}

- (void)physicsWorld:(SCNPhysicsWorld *)world
    didUpdateContact:(SCNPhysicsContact *)contact {
    NSLog(@"Update");
}

- (void)physicsWorld:(SCNPhysicsWorld *)world
       didEndContact:(SCNPhysicsContact *)contact {
    NSLog(@"End");
}



///////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (SCNScene *)scene {
    return [Scene shared];
}

- (void)setGravity:(id)gravity {
    Vector *vector;
    if ([gravity isKindOfClass:[NSNumber class]]) {
        vector = [[Vector alloc] initWithX:0
                                         Y:-((NSNumber *)gravity).doubleValue
                                         Z:0];
        self.scene.physicsWorld.gravity = [vector toSCNVector];
    } else {
        vector = [[Vector alloc] initWithObject:gravity];
        self.scene.physicsWorld.gravity = [vector toSCNVector];
    }

    _gravity = vector;
}

- (id)gravity {
    if (!_gravity) {
        _gravity =
            [[Vector alloc] initWithSCNVector:self.scene.physicsWorld.gravity];
    }
    return _gravity;
}

@end
