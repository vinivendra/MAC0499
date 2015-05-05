

#import "SCN+Exports.h"

#import "SCNNode+Extension.h"


@implementation SCNHitTestResult (Export)

- (Item *)item {
    return self.node.item;
}

- (Vector *)itemPoint {
    return [[Vector alloc] initWithSCNVector:self.localCoordinates];
}

- (Vector *)point {
    return [[Vector alloc] initWithSCNVector:self.worldCoordinates];
}

- (Vector *)itemNormal {
    return [[Vector alloc] initWithSCNVector:self.localNormal];
}

- (Vector *)normal {
    return [[Vector alloc] initWithSCNVector:self.worldNormal];
}

@end
