

#import "Physics.h"


@interface Physics ()
@property (nonatomic, strong) Scene *scene;
@end


@implementation Physics

@synthesize gravity = _gravity;

///////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (SCNScene *)scene {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      _scene = [Scene shared];
                  });

    return _scene;
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
