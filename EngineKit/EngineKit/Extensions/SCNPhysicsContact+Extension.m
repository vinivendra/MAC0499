

#import "SCNPhysicsContact+Extension.h"

#import "SCNNode+Extension.h"


@implementation SCNPhysicsContact (Extension)

- (Item *)firstItem {
    return self.nodeA.item;
}

- (Item *)secondItem {
    return self.nodeB.item;
}

- (Position *)point {
    return [[Position alloc] initWithSCNVector3:self.contactPoint];
}

- (Vector *)normal {
    return [[Vector alloc] initWithSCNVector3:self.contactNormal];
}

- (NSNumber *)impulse {
    return @(self.collisionImpulse);
}

- (NSNumber *)overlap {
    return @(self.penetrationDistance);
}

@end
