

#import "SCNPhysicsContact+Extension.h"


@implementation SCNPhysicsContact (Extension)

- (Item *)firstItem {
    return self.nodeA.item;
}

- (Item *)secondItem {
    return self.nodeB.item;
}

- (Position *)point {
    return [[Position alloc] initWithSCNVector:self.contactPoint];
}

- (Vector *)normal {
    return [[Vector alloc] initWithSCNVector:self.contactNormal];
}

- (NSNumber *)impulse {
    return @(self.collisionImpulse);
}

- (NSNumber *)overlap {
    return @(self.penetrationDistance);
}

@end
