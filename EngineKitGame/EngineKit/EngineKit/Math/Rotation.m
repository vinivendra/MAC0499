
// TODO: Add a -numberWithArray:position: to NSNumber, use it in the
// initWithArray methods.

#import "Rotation.h"

#import "NSArray+Extension.h"


@interface Rotation ()
@property (nonatomic, strong) Axis *axis;
@property (nonatomic, strong) Angle *angle;
@end


@implementation Rotation

+ (instancetype)rotationWithAxis:(Axis *)axis angle:(Angle *)angle {
    return [[Rotation alloc] initWithAxis:axis angle:angle];
}

+ (instancetype)rotationWithArray:(NSArray *)array {
    return [[Rotation alloc] initWithArray:array];
}

+ (instancetype)rotationWithObject:(id)object {
    return [[Rotation alloc] initWithObject:object];
}

+ (instancetype)rotationWithSCNVector4:(SCNVector4)vector {
    return [[Rotation alloc] initWithSCNVector4:vector];
}

- (instancetype)initWithAxis:(Axis *)axis angle:(Angle *)angle {
    if (self = [super init]) {
        self.axis = axis;
        self.angle = angle;
    }
    return self;
}

- (instancetype)initWithSCNVector4:(SCNVector4)vector {
    if (self = [super init]) {
        self.axis = [[Axis alloc] initWithSCNVector4:vector];
        self.angle = [Angle angleWithRadians:vector.w];
    }
    return self;
}

- (instancetype)initWithArray:(NSArray *)array {
    if (self = [super init]) {
        self.axis = [[Axis alloc] initWithArray:array];

        self.angle = [Angle angleWithRadians:[array floatAtIndex:3]];
    }
    return self;
}

- (instancetype)initWithRotation:(Rotation *)rotation {
    if (self = [super init]) {
        self.axis = rotation.axis;
        self.angle = rotation.angle;
    }
    return self;
}

- (instancetype)initWithObject:(id)object {

    if ([object isKindOfClass:[Rotation class]]) {
        self = [self initWithRotation:object];
    } else if ([object isKindOfClass:[NSArray class]]) {
        self = [self initWithArray:object];
    } else if ([object isKindOfClass:[NSValue class]]) {
        SCNVector4 vector = ((NSValue *)object).SCNVector4Value;
        self = [self initWithSCNVector4:vector];
    } else {
        assert(false);
        return nil;
    }

    return self;
}

- (SCNVector4)toSCNVector {
    return SCNVector4Make(self.axis.x,
                          self.axis.y,
                          self.axis.z,
                          [self.angle toRadians]);
}

- (SCNMatrix4)toSCNMatrix {
    return SCNMatrix4MakeRotation(self.a, self.x, self.y, self.z);
}

- (SCNMatrix4)rotateMatrix:(SCNMatrix4)matrix {
    return SCNMatrix4Rotate(matrix, self.a, self.x, self.y, self.z);
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (CGFloat)x {
    return self.axis.x;
}

- (CGFloat)y {
    return self.axis.y;
}

- (CGFloat)z {
    return self.axis.z;
}

- (CGFloat)a {
    return self.angle.toRadians;
}

- (Axis *)axis {
    return _axis;
}

- (Angle *)angle {
    return _angle;
}

@end
