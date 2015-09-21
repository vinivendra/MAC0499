

#import "SCN+Exports.h"

#import "SCNNode+Extension.h"


@implementation SCNHitTestResult (Export)

- (Item *)item {
    return self.node.item;
}

- (Vector *)itemPoint {
    return [[Vector alloc] initWithSCNVector3:self.localCoordinates];
}

- (Vector *)point {
    return [[Vector alloc] initWithSCNVector3:self.worldCoordinates];
}

- (Vector *)itemNormal {
    return [[Vector alloc] initWithSCNVector3:self.localNormal];
}

- (Vector *)normal {
    return [[Vector alloc] initWithSCNVector3:self.worldNormal];
}

@end
