

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

- (instancetype)initWithAxis:(Axis *)axis angle:(Angle *)angle {
    if (self = [super init]) {
        self.axis = axis;
        self.angle = angle;
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

- (SCNVector4)toSCNVector {
    return SCNVector4Make(
        self.axis.x, self.axis.y, self.axis.z, [self.angle toRadians]);
}

@end
