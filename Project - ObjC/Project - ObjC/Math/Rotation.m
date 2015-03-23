

#import "Rotation.h"

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
        self.angle =
        [Angle angleWithRadians:vector.w];
    }
    return self;
}

- (instancetype)initWithArray:(NSArray *)array {
    if (self = [super init]) {
        self.axis = [[Axis alloc] initWithArray:array];
        self.angle =
            [Angle angleWithRadians:((NSNumber *)array[3]).doubleValue];
    }
    return self;
}

- (instancetype)initWithObject:(id)object {
    
    if (self = [super init]) {
        if ([object isKindOfClass:[NSArray class]]) {
            self = [self initWithArray:object];
        }
        else if ([object isKindOfClass:[NSValue class]]) {
            SCNVector4 vector = ((NSValue *)object).SCNVector4Value;
            self = [self initWithSCNVector4:vector];
        }
        else {
            assert(false);
            return nil;
        }
    }
    return self;
}


- (SCNVector4)toSCNVector {
    return SCNVector4Make(
        self.axis.x, self.axis.y, self.axis.z, [self.angle toRadians]);
}

@end
