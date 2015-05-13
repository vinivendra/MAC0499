// TODO: add initWithDictionary
// TODO: flatten array for initWithArray

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

+ (instancetype)rotationWithSCNVector4:(SCNVector4)vector {
    return [[Rotation alloc] initWithSCNVector4:vector];
}

+ (instancetype)rotationWithAxis:(Axis *)axis angle:(Angle *)angle {
    return [[Rotation alloc] initWithAxis:axis angle:angle];
}

+ (instancetype)rotationWithString:(NSString *)string {
    return [[Rotation alloc] initWithString:string];
}

+ (instancetype)rotationWithArray:(NSArray *)array {
    return [[Rotation alloc] initWithArray:array];
}

+ (instancetype)rotationWithDictionary:(NSDictionary *)dictionary {
    return [[Rotation alloc] initWithDictionary:dictionary];
}

+ (instancetype)rotationWithRotation:(Rotation *)rotation {
    return rotation;
}

+ (instancetype)rotationWithObject:(id)object {
    if ([object isKindOfClass:[Rotation class]])
        return [Rotation rotationWithRotation:object];
    else
        return [[Rotation alloc] initWithObject:object];
}

- (instancetype)initWithSCNVector4:(SCNVector4)vector {
    if (self = [super init]) {
        self.axis = [[Axis alloc] initWithSCNVector4:vector];
        self.angle = [Angle angleWithRadians:vector.w];
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
    if (self = [super init]) {
        self.axis = [[Axis alloc] initWithArray:array];

        self.angle = [Angle angleWithRadians:[array floatAtIndex:3]];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {

    CGFloat radians = [dictionary floatForStringKey:@"a"];
    if (radians == 0.0)
        radians = [dictionary floatForStringKey:@"w"];
    if (radians == 0.0)
        radians = [dictionary floatForStringKey:@"3"];

    Angle *angle = [Angle angleWithRadians:radians];
    Axis *axis = [[Axis alloc] initWithDictionary:dictionary];
    self = [self initWithAxis:axis angle:angle];
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
