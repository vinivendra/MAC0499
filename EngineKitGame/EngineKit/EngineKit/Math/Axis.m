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
    return [Axis axisWithVector:[Vector vectorWithX:x Y:y Z:z]];
}

+ (Axis *)axisWithUniformNumbers:(CGFloat)s {
    return [Axis axisWithVector:[Vector vectorWithUniformNumbers:s]];
}

+ (Axis *)axisWithCIVector:(CIVector *)newValue {
    return [Axis axisWithVector:[Vector vectorWithCIVector:newValue]];
}

+ (Axis *)axisWithSCNVector3:(SCNVector3)newValue {
    return [Axis axisWithVector:[Vector vectorWithSCNVector3:newValue]];
}

+ (Axis *)axisWithSCNVector4:(SCNVector4)newValue {
    return [Axis axisWithVector:[Vector vectorWithSCNVector4:newValue]];
}

+ (Axis *)axisWithNSValue:(NSValue *)newValue {
    return [Axis
            axisWithVector:[Vector
                                vectorWithSCNVector3:newValue.SCNVector3Value]];
}

+ (Axis *)axisWithArray:(NSArray *)array {
    return [Axis axisWithVector:[Vector vectorWithArray:array]];
}

+ (Axis *)axisWithDictionary:(NSDictionary *)dictionary {
    return
    [Axis axisWithVector:[Vector vectorWithDictionary:dictionary]];
}

+ (Axis *)axisWithString:(NSString *)string {
    return [[Axis alloc] initWithString:string];
}

+ (Axis *)axisWithVector:(Vector *)vector {
    return [[Axis alloc] initWithVector:vector];
}

+ (Axis *)axisWithAxis:(Axis *)axis {
    return axis;
}

+ (Axis *)axisWithObject:(id)object {
    return [Axis axisWithVector:[Vector vectorWithObject:object]];
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

