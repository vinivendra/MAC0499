

#import "Position.h"


@implementation Position

+ (instancetype)positionWithVector:(Vector *)vector {
    Position *position = [Position new];
    position.vector = [vector toSCNVector];
    return position;
}

+ (instancetype)positionWithSCNVector:(SCNVector3)vector {
    return [self positionWithVector:[Vector vectorWithVector:vector]];
}

+ (instancetype)positionWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z {
    return [self positionWithVector:[Vector vectorWithX:x Y:y Z:z]];
}

+ (instancetype)positionArray:(NSArray *)array {
    return [self positionWithVector:[Vector vectorWithArray:array]];
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[Vector class]]) {
        return NO;
    }
    
    SCNVector3 vector = ((Position *)object).vector;
    
    return vectorsAreEqual(self.vector, vector);
}

@end
