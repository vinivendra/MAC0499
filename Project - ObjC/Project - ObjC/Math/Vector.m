

#import "Vector.h"


@interface Vector ()
@end


bool vectorsAreEqual(SCNVector3 vector1, SCNVector3 vector2) {
    return vector1.x == vector2.x && vector1.y == vector2.y
           && vector1.z == vector2.z;
}


@implementation Vector

+ (instancetype)vectorWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z {
    Vector *vector = [Vector new];
    vector.vector = SCNVector3Make(x, y, z);
    return vector;
}

+ (instancetype)vectorWithVector:(SCNVector3)newValue {
    Vector *vector = [Vector new];
    vector.vector = newValue;
    return vector;
}

+ (instancetype)vectorWithArray:(NSArray *)array {
    Vector *vector = [Vector new];
    vector.vector = SCNVector3Make(((NSNumber *)array[0]).doubleValue,
                                   ((NSNumber *)array[1]).doubleValue,
                                   ((NSNumber *)array[2]).doubleValue);
    ;
    return vector;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[Vector class]])
        return NO;

    Vector *other = (Vector *)object;
    return vectorsAreEqual(self.vector, other.vector);
}

- (BOOL)isEqualToVector:(SCNVector3)vector {
    return vectorsAreEqual(self.vector, vector);
}

- (SCNVector3)toSCNVector {
    return self.vector;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(x = %lf, y = %lf, z = %lf)",
                                      self.vector.x,
                                      self.vector.y,
                                      self.vector.z];
}

///////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (Vector *)setNewX:(CGFloat)x {
    return [Vector vectorWithX:x Y:self.vector.y Z:self.vector.z];
}

- (CGFloat)x {
    return self.vector.x;
}

- (Vector *)setNewY:(CGFloat)y {
    return [Vector vectorWithX:self.vector.x Y:y Z:self.vector.z];
}

- (CGFloat)y {
    return self.vector.y;
}

- (Vector *)setNewZ:(CGFloat)z {
    return [Vector vectorWithX:self.vector.x Y:self.vector.y Z:z];
}

- (CGFloat)z {
    return self.vector.z;
}

@end
