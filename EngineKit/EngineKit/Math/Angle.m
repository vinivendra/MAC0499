
#import "Angle.h"

#import "NSNumber+Extension.h"


CGFloat toRadians(CGFloat degrees) {
    return degrees / 180.0 * M_PI;
}

CGFloat toDegrees(CGFloat radians) {
    return radians / M_PI * 180.0;
}


@interface Angle ()
@property (nonatomic) CGFloat angle;
@end


@implementation Angle

- (instancetype)init {
    if (self = [self initWithDegrees:0]) {
    }
    return self;
}

- (instancetype)initWithPiTimes:(CGFloat)ratio {
    self = [self initWithRadians:ratio * M_PI];
    return self;
}

- (instancetype)initWithRadians:(CGFloat)radians {
    if (self = [super init]) {
        self.angle = radians;
    }
    return self;
}

- (instancetype)initWithDegrees:(CGFloat)degrees {
    if (self = [super init]) {
        self.angle = toRadians(degrees);
    }
    return self;
}

- (instancetype)initWithObject:(id)object {
    if (self = [super init]) {
        NSNumber *result = [NSNumber numberWithObject:object];
        self.angle = result.doubleValue;
    }
    return self;
}

- (CGFloat)toRadians {
    return self.angle;
}

- (CGFloat)toDegrees {
    return toDegrees(self.angle);
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[Angle class]]) {
        return self.angle == ((Angle *)object).toRadians;
    }
    if ([object isKindOfClass:[NSNumber class]]) {
        return self.angle == ((NSNumber *)object).doubleValue;
    }
    return NO;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%lf", self.angle];
}

@end
