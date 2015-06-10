

#import "Rotation.h"

#import "NSArray+Extension.h"
#import "NSDictionary+Extension.h"
#import "NSString+Extension.h"

#import "ObjectiveSugar.h"


@interface Rotation ()
@property (nonatomic, strong) Axis *axis;
@property (nonatomic, strong) Angle *angle;
@end


@implementation Rotation

//------------------------------------------------------------------------------
#pragma mark - Initializing Rotation objects
//------------------------------------------------------------------------------

- (instancetype)initWithSCNVector4:(SCNVector4)vector {
    self = [self initWithAxis:[[Axis alloc] initWithSCNVector4:vector]
                        angle:[[Angle alloc] initWithRadians:vector.w]];
    return self;
}

- (instancetype)initWithX:(CGFloat)x
                        Y:(CGFloat)y
                        Z:(CGFloat)z
                    Angle:(CGFloat)angle {
    if (self = [super init]) {
        self.axis = [[Axis alloc] initWithX:x Y:y Z:z];
        self.angle = [[Angle alloc] initWithRadians:angle];
    }
    return self;
}

- (instancetype)initWithAxis:(Axis *)axis angle:(Angle *)angle {
    if (self = [super init]) {
        self.axis = axis;
        self.angle = angle;
    }
    return self;
}

- (instancetype)initWithString:(NSString *)string {
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSCharacterSet *numbers =
        [NSCharacterSet characterSetWithCharactersInString:@"-0123456789."];

    NSMutableArray *array = [NSMutableArray array];

    BOOL done = NO;
    int contents = 0;

    until(done || contents == 4) {
        NSString *number;

        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];

        done = ![scanner scanCharactersFromSet:numbers intoString:&number];

        if (number) {
            [array push:number.numberValue];
            contents++;
        }
    }

    self = [self initWithArray:array];

    return self;
}

- (instancetype)initWithArray:(NSArray *)array {
    if (array.count > 0) {
        if (![array[0] isKindOfClass:[NSNumber class]]) {
            Axis *axis = [[Axis alloc] initWithObject:array[0]];
            Angle *angle = [[Angle alloc] initWithRadians:[array floatAtIndex:1]];
            self = [self initWithAxis:axis angle:angle];
            return self;
        }
    }

    Axis *axis = [[Axis alloc] initWithObject:array];
    Angle *angle = [[Angle alloc] initWithRadians:[array floatAtIndex:3]];
    self = [self initWithAxis:axis angle:angle];

    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {

    CGFloat radians = [dictionary floatForStringKey:@"a"];
    if (radians == 0.0)
        radians = [dictionary floatForStringKey:@"w"];
    if (radians == 0.0)
        radians = [dictionary floatForStringKey:@"3"];

    Angle *angle = [[Angle alloc] initWithRadians:radians];
    Axis *axis = [[Axis alloc] initWithDictionary:dictionary];
    self = [self initWithAxis:axis angle:angle];
    return self;
}

- (instancetype)initWithRotation:(Rotation *)rotation {
    self = [self initWithAxis:rotation.axis angle:rotation.angle];
    return self;
}

- (instancetype)initWithObject:(id)object {

    if ([object isKindOfClass:[NSArray class]]) {
        self = [self initWithArray:object];
    } else if ([object isKindOfClass:[NSDictionary class]]) {
        self = [self initWithDictionary:object];
    } else if ([object isKindOfClass:[NSValue class]]) {
        SCNVector4 vector = ((NSValue *)object).SCNVector4Value;
        self = [self initWithSCNVector4:vector];
    } else if ([object isKindOfClass:[NSString class]]) {
        self = [self initWithString:object];
    } else if ([object isKindOfClass:[Rotation class]]) {
        self = [self initWithRotation:object];
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

- (SCNVector4)toSCNQuaternion {
    CGFloat halfAngle = self.angle.toRadians / 2;
    CGFloat cosine = cos(halfAngle);
    CGFloat sine = sin(halfAngle);
    return SCNVector4Make(sine * self.axis.x,
                          sine * self.axis.y,
                          sine * self.axis.z,
                          cosine);
}

- (Vector *)rotate:(id)vector {
    Vector *v = [[Vector alloc] initWithObject:vector];
    SCNQuaternion q = self.toSCNQuaternion;

    SCNQuaternion p = SCNVector4Make(q.w * v.x + q.y * v.z - q.z * v.y,
                                     q.w * v.y - q.x * v.z + q.z * v.x,
                                     q.w * v.z + q.x * v.y - q.y * v.x,
                                     -q.x * v.x - q.y * v.y - q.z * v.z);

    q.x *= -1;
    q.y *= -1;
    q.z *= -1;

    SCNVector3 result
        = SCNVector3Make(p.w * q.x + p.x * q.w + p.y * q.z - p.z * q.y,
                         p.w * q.y - p.x * q.z + p.y * q.w + p.z * q.x,
                         p.w * q.z + p.x * q.y - p.y * q.x + p.z * q.w);

    return [[Vector alloc] initWithSCNVector3:result];
}

- (SCNMatrix4)toSCNMatrix {
    return SCNMatrix4MakeRotation(self.a, self.x, self.y, self.z);
}

- (SCNMatrix4)rotateMatrix:(SCNMatrix4)matrix {
    return SCNMatrix4Rotate(matrix, self.a, self.x, self.y, self.z);
}

//------------------------------------------------------------------------------
#pragma mark - Overriding
//------------------------------------------------------------------------------

- (NSString *)description {
    return [NSString stringWithFormat:@"(x = %lf, y = %lf, z = %lf | a = %lf)",
                                      self.axis.x,
                                      self.axis.y,
                                      self.axis.z,
                                      self.angle.toRadians];
}

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
