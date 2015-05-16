

#import "Position.h"


@interface Position ()
@property (nonatomic) SCNVector3 vector;
@end


@implementation Position


//------------------------------------------------------------------------------
#pragma mark - Common Vector constants
//------------------------------------------------------------------------------

+ (instancetype)origin {
    return [Position positionWithVector:[Vector origin]];
}


//------------------------------------------------------------------------------
#pragma mark - Creating Position objects
//------------------------------------------------------------------------------

+ (Position *)position {
    return [Position positionWithVector:[Vector vector]];
}

+ (Position *)positionWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z {
    return [Position positionWithVector:[Vector vectorWithX:x Y:y Z:z]];
}

+ (Position *)positionWithUniformWithNumber:(CGFloat)s {
    return [Position positionWithVector:[Vector vectorWithUniformWithNumber:s]];
}

+ (Position *)positionWithCGPoint:(CGPoint)newValue {
    return [Position positionWithVector:[Vector vectorWithCGPoint:newValue]];
}

+ (Position *)positionWithCIVector:(CIVector *)newValue {
    return [Position positionWithVector:[Vector vectorWithCIVector:newValue]];
}

+ (Position *)positionWithSCNVector3:(SCNVector3)newValue {
    return [Position positionWithVector:[Vector vectorWithSCNVector3:newValue]];
}

+ (Position *)positionWithSCNVector4:(SCNVector4)newValue {
    return [Position positionWithVector:[Vector vectorWithSCNVector4:newValue]];
}

+ (Position *)positionWithNSValue:(NSValue *)newValue {
    return [Position
        positionWithVector:[Vector
                               vectorWithSCNVector3:newValue.SCNVector3Value]];
}

+ (Position *)positionWithArray:(NSArray *)array {
    return [Position positionWithVector:[Vector vectorWithArray:array]];
}

+ (Position *)positionWithDictionary:(NSDictionary *)dictionary {
    return
        [Position positionWithVector:[Vector vectorWithDictionary:dictionary]];
}

+ (Position *)positionWithString:(NSString *)string {
    return [Position positionWithVector:[Vector vectorWithString:string]];
}

+ (Position *)positionWithVector:(Vector *)vector {
    return [[Position alloc] initWithVector:vector];
}

+ (Position *)positionWithPosition:(Position *)position {
    return position;
}

+ (Position *)positionWithObject:(id)object {
    return [Position positionWithVector:[Vector vectorWithObject:object]];
}


//------------------------------------------------------------------------------
#pragma mark - Initializing Position objects
//------------------------------------------------------------------------------

- (instancetype)initWithVector:(Vector *)vector {
    self = [self initWithSCNVector3:vector.toSCNVector3];
    return self;
}

@end
