

#import "Vector.h"

#import "ObjectiveSugar.h"

#import "NSString+Extension.h"
#import "NSNumber+Extension.h"
#import "NSArray+Extension.h"
#import "NSDictionary+Extension.h"


@interface Vector ()
@property (nonatomic) SCNVector3 vector;
@end


unsigned long mutationsCounter;


@implementation Vector


//------------------------------------------------------------------------------
#pragma mark Getting the Vector's information
//------------------------------------------------------------------------------

// unavailable
- (NSNumber *)objectAtIndexedSubscript:(NSUInteger)index {
    switch (index) {
    case 0:
        return @(self.x);
        break;
    case 1:
        return @(self.y);
        break;
    case 2:
        return @(self.z);
        break;
    default:
        return nil;
        break;
    }

    return nil;
}

- (SCNVector3)toSCNVector3 {
    return self.vector;
}

- (SCNVector4)toSCNVector4 {
    return SCNVector4Make(self.x, self.y, self.z, 1.0);
}

- (NSValue *)toNSValue {
    return [NSValue valueWithSCNVector3:self.vector];
}

- (NSArray *)toArray {
    return @[ @(self.x), @(self.y), @(self.z) ];
}

- (BOOL)notZero {
    return !(self.x == 0 && self.y == 0 && self.z == 0);
}

//------------------------------------------------------------------------------
#pragma mark - Common Vector constants
//------------------------------------------------------------------------------

+ (instancetype)origin {
    static Vector *origin;

    if (!origin)
        origin = [[[self class] alloc] initWithX:0 Y:0 Z:0];

    return origin;
}


//------------------------------------------------------------------------------
#pragma mark - Creating Vector objects
//------------------------------------------------------------------------------

- (instancetype)init {
    self = [self initWithX:0 Y:0 Z:0];
    return self;
}

- (instancetype)initWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z {
    if (self = [super init]) {
        self.vector = SCNVector3Make(x, y, z);
    }
    return self;
}

- (instancetype)initWithUniformNumbers:(CGFloat)x {
    self = [self initWithX:x Y:x Z:x];
    return self;
}

- (instancetype)initWithCGPoint:(CGPoint)newValue {
    self = [self initWithX:newValue.x Y:-newValue.y Z:0];
    return self;
}

- (instancetype)initWithCIVector:(CIVector *)newValue {
    self = [self initWithX:newValue.X Y:newValue.Y Z:newValue.Z];
    return self;
}

- (instancetype)initWithSCNVector3:(SCNVector3)newValue {
    self = [self initWithX:newValue.x Y:newValue.y Z:newValue.z];
    return self;
}

- (instancetype)initWithSCNVector4:(SCNVector4)newValue {
    self = [self initWithX:newValue.x Y:newValue.y Z:newValue.z];

    return self;
}

- (instancetype)initWithArray:(NSArray *)array {

    SCNVector3 vector;

    vector.x = [array floatAtIndex:0];
    vector.y = [array floatAtIndex:1];
    vector.z = [array floatAtIndex:2];

    self = [self initWithSCNVector3:vector];

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

    self = [self initWithSCNVector3:vector];

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


- (instancetype)initWithVector:(Vector *)vector {
    self = [self initWithSCNVector3:[vector toSCNVector3]];

    return self;
}

- (instancetype)initWithObject:(id)object {
    if ([object isKindOfClass:[NSNumber class]]) {
        self = [self initWithUniformNumbers:((NSNumber *)object).doubleValue];
    } else if ([object isKindOfClass:[NSArray class]]) {
        self = [self initWithArray:object];
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


//------------------------------------------------------------------------------
#pragma mark - Comparing objects
//------------------------------------------------------------------------------

- (BOOL)isEqual:(id)object {
    return [self isEqualToVector:[[Vector alloc] initWithObject:object].vector];
}

- (BOOL)isEqualToVector:(SCNVector3)vector {
    return SCNVector3EqualToVector3(self.vector, vector);
}


//------------------------------------------------------------------------------
#pragma mark - Operations with Vectors
//------------------------------------------------------------------------------

- (Vector *)times:(CGFloat)scalar {

    return [[[self class] alloc] initWithX:self.x * scalar
                                   Y:self.y * scalar
                                   Z:self.z * scalar];
}

- (Vector *)over:(CGFloat)scalar {
    scalar = scalar ?: 1;
    return [[[self class] alloc] initWithX:self.x / scalar
                                   Y:self.y / scalar
                                   Z:self.z / scalar];
}

- (Vector *)plus:(Vector *)vector {
    return [[[self class] alloc] initWithX:self.x + vector.x
                                   Y:self.y + vector.y
                                   Z:self.z + vector.z];
}

- (Vector *)minus:(Vector *)vector {
    return [[[self class] alloc] initWithX:self.x - vector.x
                                   Y:self.y - vector.y
                                   Z:self.z - vector.z];
}

- (Vector *)opposite {
    return [[[self class] alloc] initWithX:-self.x Y:-self.y Z:-self.z];
}

- (CGFloat)dot:(id)object {
    Vector *vector = [[Vector alloc] initWithObject:object];
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
    Vector *vector = [[[self class] alloc] initWithObject:object];
    return [vector plus:self];
}

- (Vector *)scale:(Vector *)vector {
    return [[[self class] alloc] initWithX:self.x * vector.x
                                   Y:self.y * vector.y
                                   Z:self.z * vector.z];
}

- (SCNMatrix4)translateMatrix:(SCNMatrix4)matrix {
    return SCNMatrix4Translate(matrix, self.x, self.y, self.z);
}

- (SCNMatrix4)scaleMatrix:(SCNMatrix4)matrix {
    return SCNMatrix4Scale(matrix, self.x, self.y, self.z);
}

//------------------------------------------------------------------------------
#pragma mark - Overriding
//------------------------------------------------------------------------------

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ %@",
            [NSString stringFromFloat:self.vector.x],
            [NSString stringFromFloat:self.vector.y],
            [NSString stringFromFloat:self.vector.z]];

//    return [NSString stringWithFormat:@"(x = %lf, y = %lf, z = %lf)",
//                                      self.vector.x,
//                                      self.vector.y,
//                                      self.vector.z];
}

- (Vector *)setNewX:(CGFloat)x {
    return [[[self class] alloc] initWithX:x Y:self.vector.y Z:self.vector.z];
}

- (CGFloat)x {
    return self.vector.x;
}

- (Vector *)setNewY:(CGFloat)y {
    return [[[self class] alloc] initWithX:self.vector.x Y:y Z:self.vector.z];
}

- (CGFloat)y {
    return self.vector.y;
}

- (Vector *)setNewZ:(CGFloat)z {
    return [[[self class] alloc] initWithX:self.vector.x Y:self.vector.y Z:z];
}

- (CGFloat)z {
    return self.vector.z;
}

@end
