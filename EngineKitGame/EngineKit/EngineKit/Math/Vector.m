

#import "Vector.h"

#import "ObjectiveSugar.h"

#import "NSString+Extension.h"
#import "NSNumber+Extension.h"
#import "NSArray+Extension.h"
#import "NSDictionary+Extension.h"


@interface Vector ()
@property (nonatomic) SCNVector3 vector;
@end


@implementation Vector

+ (instancetype)origin {
    __block Vector *origin;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      origin = [Vector vectorWithX:0 Y:0 Z:0];
                  });

    return origin;
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

    SCNVector3 vector;

    vector.x = [array floatAtIndex:0];
    vector.y = [array floatAtIndex:1];
    vector.z = [array floatAtIndex:2];

    if (self = [super init]) {
        self.vector = vector;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    SCNVector3 vector;

    vector.x = [dictionary floatForStringKey:@"x"];
    if (vector.x == 0.0)
        vector.x = [dictionary floatForStringKey:@"0"];

    vector.y = [dictionary floatForStringKey:@"y"];
    if (vector.y == 0.0)
        vector.y = [dictionary floatForStringKey:@"1"];

    vector.z = [dictionary floatForStringKey:@"z"];
    if (vector.z == 0.0)
        vector.z = [dictionary floatForStringKey:@"2"];

    if (self = [super init]) {
        self.vector = vector;
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

    until(done || contents == 3) {
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

- (instancetype)initWithObject:(id)object {
    if ([object isKindOfClass:[NSNumber class]]) {
        self = [self initUniformWithNumber:((NSNumber *)object).doubleValue];
    } else if ([object isKindOfClass:[NSArray class]]) {
        self = [self initWithArray:object];
    } else if ([object isKindOfClass:[NSValue class]]) {
        self = [self initWithSCNVector:((NSValue *)object).SCNVector3Value];
    } else if ([object isKindOfClass:[NSString class]]) {
        self = [self initWithString:(NSString *)object];
    } else if ([object isKindOfClass:[NSDictionary class]]) {
        self = [self initWithDictionary:(NSDictionary *)object];
    } else if ([object isKindOfClass:[Vector class]]) {
        self = [self initWithVector:object];
    } else {
        assert(false);
        return nil;
    }
    return self;
}

+ (Vector *)vectorWithUniformWithNumber:(CGFloat)x {
    return [[Vector alloc] initUniformWithNumber:x];
}

+ (Vector *)vectorWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z {
    return [[Vector alloc] initWithX:x Y:y Z:z];
}

+ (Vector *)vectorWithSCNVector:(SCNVector3)newValue {
    return [[Vector alloc] initWithSCNVector:newValue];
}

+ (Vector *)vectorWithCGPoint:(CGPoint)newValue {
    return [[Vector alloc] initWithCGPoint:newValue];
}

+ (Vector *)vectorWithSCNVector4:(SCNVector4)newValue {
    return [[Vector alloc] initWithSCNVector4:newValue];
}

+ (Vector *)vectorWithCIVector:(CIVector *)newValue {
    return [[Vector alloc] initWithCIVector:newValue];
}

+ (Vector *)vectorWithVector:(Vector *)vector {
    return vector;
}

+ (Vector *)vectorWithArray:(NSArray *)array {
    return [[Vector alloc] initWithArray:array];
}

+ (Vector *)vectorWithDictionary:(NSDictionary *)dictionary {
    return [[Vector alloc] initWithDictionary:dictionary];
}

+ (Vector *)vectorWithString:(NSString *)string {
    return [[Vector alloc] initWithString:string];
}

+ (Vector *)vectorWithObject:(id)object {
    if ([object isKindOfClass:[Vector class]])
        return [Vector vectorWithVector:object];
    else
        return [[Vector alloc] initWithObject:object];
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

    return [Vector vectorWithX:self.x * scalar
                             Y:self.y * scalar
                             Z:self.z * scalar];
}

- (Vector *)over:(CGFloat)scalar {
    return [Vector vectorWithX:self.x / scalar
                             Y:self.y / scalar
                             Z:self.z / scalar];
}

- (Vector *)plus:(id)object {
    Vector *vector = [Vector vectorWithObject:object];
    return [Vector vectorWithX:self.x + vector.x
                             Y:self.y + vector.y
                             Z:self.z + vector.z];
}

- (Vector *)minus:(id)object {
    Vector *vector = [Vector vectorWithObject:object];
    return [Vector vectorWithX:self.x - vector.x
                             Y:self.y - vector.y
                             Z:self.z - vector.z];
}

- (Vector *)opposite {
    return [Vector vectorWithX:-self.x Y:-self.y Z:-self.z];
}

- (CGFloat)dot:(id)object {
    Vector *vector = [Vector vectorWithObject:object];
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

- (Vector *)translate:(id)object {
    Vector *vector = [Vector vectorWithObject:object];
    return [vector plus:self];
}

- (Vector *)scale:(CGFloat)scale {
    return [self times:scale];
}

- (SCNMatrix4)translateMatrix:(SCNMatrix4)matrix {
    return SCNMatrix4Translate(matrix, self.x, self.y, self.z);
}

- (SCNMatrix4)scaleMatrix:(SCNMatrix4)matrix {
    return SCNMatrix4Scale(matrix, self.x, self.y, self.z);
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (Vector *)setNewX:(CGFloat)x {
    return [Vector vectorWithX:x Y:self.vector.y Z:self.vector.z];
}

- (CGFloat)x {
    return self.vector.x;
}

- (Vector *)setNewY:(CGFloat)y {
    return [Vector vectorWithX:self.vector.x Y:y Z:self.vector.z];
}

- (CGFloat)y {
    return self.vector.y;
}

- (Vector *)setNewZ:(CGFloat)z {
    return [Vector vectorWithX:self.vector.x Y:self.vector.y Z:z];
}

- (CGFloat)z {
    return self.vector.z;
}

@end
