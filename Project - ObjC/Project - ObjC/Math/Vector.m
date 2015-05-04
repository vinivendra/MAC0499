

#import "Vector.h"


@interface Vector ()
@end


@implementation Vector

+ (instancetype)origin {
    return [[Vector alloc] initWithX:0 Y:0 Z:0];
}

- (instancetype)initUniformWithNumber:(CGFloat)x {
    self = [self initWithX:x Y:x Z:x];
    return self;
}

- (instancetype)initWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z {
    if (self = [super init]) {
        self.vector = SCNVector3Make(x, y, z);
    }
    return self;
}

- (instancetype)initWithSCNVector:(SCNVector3)newValue {
    if (self = [super init]) {
        self.vector = newValue;
    }
    return self;
}

- (instancetype)initWithCGPoint:(CGPoint)newValue {
    self = [self initWithX:newValue.x Y:-newValue.y Z:0];
    return self;
}

- (instancetype)initWithSCNVector4:(SCNVector4)newValue {
    if (self = [super init]) {
        self.vector = SCNVector3Make(newValue.x, newValue.y, newValue.z);
    }
    return self;
}

- (instancetype)initWithCIVector:(CIVector *)newValue {
    if (self = [super init]) {
        self.vector = SCNVector3Make(newValue.X, newValue.Y, newValue.Z);
    }
    return self;
}

- (instancetype)initWithVector:(Vector *)vector {
    if (self = [super init]) {
        self.vector = [vector toSCNVector];
    }
    return self;
}

- (instancetype)initWithArray:(NSArray *)array {
    if (self = [super init]) {
        CGFloat z = array.count == 2 ? 0 : ((NSNumber *)array[2]).doubleValue;
        self.vector = SCNVector3Make(((NSNumber *)array[0]).doubleValue,
                                     ((NSNumber *)array[1]).doubleValue,
                                     z);
    }
    return self;
}

- (instancetype)initWithObject:(id)object {
    if ([object isKindOfClass:[NSNumber class]]) {
        self = [self initUniformWithNumber:((NSNumber *)object).doubleValue];
    } else if ([object isKindOfClass:[NSArray class]]) {
        self = [self initWithArray:object];
    } else if ([object isKindOfClass:[Vector class]]) {
        self = [self initWithVector:object];
    } else if ([object isKindOfClass:[NSValue class]]) {
        self = [self initWithSCNVector:((NSValue *)object).SCNVector3Value];
    } else {
        assert(false);
        return nil;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[Vector class]])
        return NO;

    Vector *other = (Vector *)object;

    return [self isEqualToVector:other.vector];
}

- (BOOL)isEqualToVector:(SCNVector3)vector {
    return SCNVector3EqualToVector3(self.vector, vector);
}

- (SCNVector3)toSCNVector {
    return self.vector;
}

- (NSValue *)toValue {
    return [NSValue valueWithSCNVector3:self.vector];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(x = %lf, y = %lf, z = %lf)",
                                      self.vector.x,
                                      self.vector.y,
                                      self.vector.z];
}

- (Vector *)times:(CGFloat)scalar {
    return [[Vector alloc] initWithX:self.x * scalar
                                   Y:self.y * scalar
                                   Z:self.z * scalar];
}

- (Vector *)over:(CGFloat)scalar {
    return [[Vector alloc] initWithX:self.x / scalar
                                   Y:self.y / scalar
                                   Z:self.z / scalar];
}

- (Vector *)plus:(Vector *)vector {
    return [[Vector alloc] initWithX:self.x + vector.x
                                   Y:self.y + vector.y
                                   Z:self.z + vector.z];
}

- (Vector *)minus:(Vector *)vector {
    return [[Vector alloc] initWithX:self.x - vector.x
                                   Y:self.y - vector.y
                                   Z:self.z - vector.z];
}

- (Vector *)opposite {
    return [[Vector alloc] initWithX:-self.x
                                   Y:-self.y
                                   Z:-self.z];
}

- (CGFloat)dot:(Vector *)vector {
    return self.x * vector.x + self.y * vector.y + self.z * vector.z;
}

- (CGFloat)normSquared {
    return [self dot:self];
}

- (CGFloat)norm {
    return sqrt([self normSquared]);
}

- (Vector *)normalize {
    return [self over:[self norm]];
}

- (SCNMatrix4)translateMatrix:(SCNMatrix4)matrix {
    return SCNMatrix4Translate(matrix, self.x, self.y, self.z);
}

///////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (Vector *)setNewX:(CGFloat)x {
    return [[Vector alloc] initWithX:x Y:self.vector.y Z:self.vector.z];
}

- (CGFloat)x {
    return self.vector.x;
}

- (Vector *)setNewY:(CGFloat)y {
    return [[Vector alloc] initWithX:self.vector.x Y:y Z:self.vector.z];
}

- (CGFloat)y {
    return self.vector.y;
}

- (Vector *)setNewZ:(CGFloat)z {
    return [[Vector alloc] initWithX:self.vector.x Y:self.vector.y Z:z];
}

- (CGFloat)z {
    return self.vector.z;
}

@end
