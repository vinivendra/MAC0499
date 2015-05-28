// TODO: add axisWith... methods

#import "Axis.h"

#import "ObjectiveSugar.h"

#import "NSString+Extension.h"


@implementation Axis

//------------------------------------------------------------------------------
#pragma mark - Common Axis constants
//------------------------------------------------------------------------------

+ (instancetype)x {
    return [[self alloc] initWithX:1 Y:0 Z:0];
}

+ (instancetype)y {
    return [[self alloc] initWithX:0 Y:1 Z:0];
}

+ (instancetype)z {
    return [[self alloc] initWithX:0 Y:0 Z:1];
}


//------------------------------------------------------------------------------
#pragma mark - Creating Axis objects
//------------------------------------------------------------------------------

+ (Axis *)axisWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z {
    Axis *newAxis = [Axis axisWithVector:[Vector vectorWithX:x Y:y Z:z]];
    assert(newAxis.notZero);
    return newAxis;
}

+ (Axis *)axisWithUniformNumbers:(CGFloat)s {
    Axis *newAxis = [Axis axisWithVector:[Vector vectorWithUniformNumbers:s]];
    assert(newAxis.notZero);
    return newAxis;
}

+ (Axis *)axisWithCIVector:(CIVector *)newValue {
    Axis *newAxis = [Axis axisWithVector:[Vector vectorWithCIVector:newValue]];
    assert(newAxis.notZero);
    return newAxis;
}

+ (Axis *)axisWithSCNVector3:(SCNVector3)newValue {
    Axis *newAxis =
        [Axis axisWithVector:[Vector vectorWithSCNVector3:newValue]];
    assert(newAxis.notZero);
    return newAxis;
}

+ (Axis *)axisWithSCNVector4:(SCNVector4)newValue {
    Axis *newAxis =
        [Axis axisWithVector:[Vector vectorWithSCNVector4:newValue]];
    assert(newAxis.notZero);
    return newAxis;
}

+ (Axis *)axisWithNSValue:(NSValue *)newValue {
    Axis *newAxis = [Axis
        axisWithVector:[Vector vectorWithSCNVector3:newValue.SCNVector3Value]];
    assert(newAxis.notZero);
    return newAxis;
}

+ (Axis *)axisWithArray:(NSArray *)array {
    Axis *newAxis = [Axis axisWithVector:[Vector vectorWithArray:array]];
    assert(newAxis.notZero);
    return newAxis;
}

+ (Axis *)axisWithDictionary:(NSDictionary *)dictionary {
    Axis *newAxis =
        [Axis axisWithVector:[Vector vectorWithDictionary:dictionary]];
    assert(newAxis.notZero);
    return newAxis;
}

+ (Axis *)axisWithString:(NSString *)string {
    Axis *newAxis = [[Axis alloc] initWithString:string];
    assert(newAxis.notZero);
    return newAxis;
}

+ (Axis *)axisWithVector:(Vector *)vector {
    Axis *newAxis = [[Axis alloc] initWithVector:vector];
    assert(newAxis.notZero);
    return newAxis;
}

+ (Axis *)axisWithAxis:(Axis *)axis {
    Axis *newAxis = [[Axis alloc] initWithVector:axis];
    assert(newAxis.notZero);
    return newAxis;
}

+ (Axis *)axisWithObject:(id)object {
    Axis *newAxis = [Axis axisWithVector:[Vector vectorWithObject:object]];
    assert(newAxis.notZero);
    return newAxis;
}

- (instancetype)initWithString:(NSString *)string {
    if ([string isEqualToString:@"x"] || [string isEqualToString:@"X"]) {
        self = [super initWithX:1 Y:0 Z:0];
    } else if ([string isEqualToString:@"y"] || [string isEqualToString:@"Y"]) {
        self = [super initWithX:0 Y:1 Z:0];
    } else if ([string isEqualToString:@"z"] || [string isEqualToString:@"Z"]) {
        self = [super initWithX:0 Y:0 Z:1];
    } else {
        self = [super initWithString:string];
    }

    return self;
}


@end
