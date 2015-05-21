

#import <XCTest/XCTest.h>

#import "NSDictionary+Extension.h"
#import "ObjectiveSugar.h"
#import "Vector.h"


NSString *stringForSCNVector3(SCNVector3 vector) {
    return [NSString
        stringWithFormat:@"(%lf %lf %lf)", vector.x, vector.y, vector.z];
}


@interface VectorTests : XCTestCase
@property (nonatomic, strong) NSMutableArray *standardArrays;
@property (nonatomic, strong) NSMutableArray *standardVectors;
@end


CGFloat randomFloat() {
    CGFloat f = ((double)rand() / rand()) - ((double)rand() / rand());
    return f * f * f;
}


@implementation VectorTests


- (void)setUp {
    [super setUp];

    NSDateComponents *components = [[NSCalendar currentCalendar]
        components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
          fromDate:[NSDate date]];

    unsigned int seed = (unsigned int)components.day
                        + (unsigned int)components.month * 31
                        + (unsigned int)components.year * 12 * 31;

    srand(seed);

    self.standardArrays = [NSMutableArray array];
    [self.standardArrays push:@[ @0, @0, @0 ]];
    [self.standardArrays push:@[ @1, @0, @0 ]];
    [self.standardArrays push:@[ @0, @-1, @0 ]];
    [self.standardArrays push:@[ @0, @0, @2 ]];

    for (int i = 0; i < 10; i++)
        [self.standardArrays
            push:@[ @(randomFloat()), @(randomFloat()), @(randomFloat()) ]];

    self.standardVectors = [NSMutableArray array];

    for (NSArray *vector in self.standardArrays) {
        [self.standardVectors
            push:[Vector vectorWithX:((NSNumber *)vector[0]).doubleValue
                                   Y:((NSNumber *)vector[1]).doubleValue
                                   Z:((NSNumber *)vector[2]).doubleValue]];
    }
}

//------------------------------------------------------------------------------
#pragma mark - Basis
//------------------------------------------------------------------------------

- (void)testVectorWithXYZAndEquals {
    for (int i = 0; i < self.standardArrays.count; i++) {
        // Bijection
        NSArray *vectorArray = self.standardArrays[i];
        NSArray *nextVectorArray
            = self.standardArrays[(i + 1) % self.standardArrays.count];

        Vector *vector1 =
            [Vector vectorWithX:((NSNumber *)vectorArray[0]).doubleValue
                              Y:((NSNumber *)vectorArray[1]).doubleValue
                              Z:((NSNumber *)vectorArray[2]).doubleValue];

        Vector *vector2 =
            [Vector vectorWithX:((NSNumber *)vectorArray[0]).doubleValue
                              Y:((NSNumber *)vectorArray[1]).doubleValue
                              Z:((NSNumber *)vectorArray[2]).doubleValue];

        Vector *vector3 =
            [Vector vectorWithX:((NSNumber *)nextVectorArray[0]).doubleValue
                              Y:((NSNumber *)nextVectorArray[1]).doubleValue
                              Z:((NSNumber *)nextVectorArray[2]).doubleValue];

        XCTAssert([vector1 isEqual:vector2]);
        XCTAssert([vector1 isEqualToVector:vector2.toSCNVector3]);
        XCTAssertEqualObjects(vector1, vector2);

        XCTAssertNotEqualObjects(vector1, vector3);
        XCTAssertFalse([vector1 isEqual:vector3]);
        XCTAssertFalse([vector1 isEqualToVector:vector3.toSCNVector3]);
    }
}

//
- (void)testEqualsToObject {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Results and comparisons
        Vector *result;

        NSDictionary *dictionary = @{
            @"x" : @(standard.x),
            @"y" : @(standard.y),
            @"z" : @(standard.z)
        };
        result = [[Vector alloc] initWithObject:dictionary];
        XCTAssertEqualObjects(result, dictionary);

        NSString *string = [NSString stringWithFormat:@"%lf %lf %lf",
                                                      standard.x,
                                                      standard.y,
                                                      standard.z];
        result = [[Vector alloc] initWithObject:string];
        XCTAssertEqualObjects(result, string);

        NSValue *value = [NSValue valueWithSCNVector3:standard.toSCNVector3];
        result = [[Vector alloc] initWithObject:value];
        XCTAssertEqualObjects(result, value);

        result = [[Vector alloc] initWithObject:standard.toArray];
        XCTAssertEqualObjects(result, standard.toArray);

        result = [[Vector alloc] initWithObject:@(standard.x)];
        standard = [Vector vectorWithUniformNumbers:standard.x];
        XCTAssertEqualObjects(result, @(standard.x));
    }
}


//------------------------------------------------------------------------------
#pragma mark - Extracting data
//------------------------------------------------------------------------------

//
- (void)testXYZ {
    for (int i = 0; i < self.standardArrays.count; i++) {
        // Gold standard
        NSArray *vectorArray = self.standardArrays[i];
        CGFloat xStandard = ((NSNumber *)vectorArray[0]).doubleValue;
        CGFloat yStandard = ((NSNumber *)vectorArray[1]).doubleValue;
        CGFloat zStandard = ((NSNumber *)vectorArray[2]).doubleValue;

        // Actual result
        Vector *vector = self.standardVectors[i];
        CGFloat xResult = vector.x;
        CGFloat yResult = vector.y;
        CGFloat zResult = vector.z;

        // Comparison
        XCTAssertEqualWithAccuracy(xStandard,
                                   xResult,
                                   fabs(xStandard / 100));
        XCTAssertEqualWithAccuracy(yStandard,
                                   yResult,
                                   fabs(yStandard / 100));
        XCTAssertEqualWithAccuracy(zStandard,
                                   zResult,
                                   fabs(zStandard / 100));
    }
}

// x, y, z
- (void)testToArray {
    for (Vector *vector in self.standardVectors) {
        XCTAssertEqual(vector.x, ((NSNumber *)vector.toArray[0]).doubleValue);
        XCTAssertEqual(vector.y, ((NSNumber *)vector.toArray[1]).doubleValue);
        XCTAssertEqual(vector.z, ((NSNumber *)vector.toArray[2]).doubleValue);
        XCTAssertNil(vector[3]);
    }
}

//
- (void)testToSCNVector3 {
    for (int i = 0; i < self.standardArrays.count; i++) {
        // Gold standard
        NSArray *vectorArray = self.standardArrays[i];

        SCNVector3 standard
            = SCNVector3Make(((NSNumber *)vectorArray[0]).doubleValue,
                             ((NSNumber *)vectorArray[1]).doubleValue,
                             ((NSNumber *)vectorArray[2]).doubleValue);

        // Actual result
        SCNVector3 result = ((Vector *)self.standardVectors[i]).toSCNVector3;

        // Comparison
        XCTAssert(SCNVector3EqualToVector3(standard, result));
    }
}

//
- (void)testToNSValue {
    for (int i = 0; i < self.standardArrays.count; i++) {
        // Gold standard
        NSArray *vectorArray = self.standardArrays[i];

        SCNVector3 standard
            = SCNVector3Make(((NSNumber *)vectorArray[0]).doubleValue,
                             ((NSNumber *)vectorArray[1]).doubleValue,
                             ((NSNumber *)vectorArray[2]).doubleValue);

        // Actual result
        NSValue *value = ((Vector *)self.standardVectors[i]).toNSValue;
        SCNVector3 result = value.SCNVector3Value;


        // Comparison
        XCTAssert(SCNVector3EqualToVector3(standard, result));
    }
}

// x, y, z
- (void)testObjectAtIndexedSubscript {
    for (Vector *vector in self.standardVectors) {
        XCTAssertEqual(vector.x, vector[0].doubleValue);
        XCTAssertEqual(vector.y, vector[1].doubleValue);
        XCTAssertEqual(vector.z, vector[2].doubleValue);
        XCTAssertNil(vector[3]);
    }
}

//------------------------------------------------------------------------------
#pragma mark - Creation
//------------------------------------------------------------------------------

//
- (void)testOrigin {

    // Gold standard
    Vector *standard = [Vector vectorWithX:0 Y:0 Z:0];

    // Actual result
    Vector *result = [Vector origin];

    // Comparison
    XCTAssertEqualObjects(standard, result);
}

//
- (void)testVector {
    XCTAssertNotNil([Vector vector]);
}

//
- (void)testVectorWithCGPoint {
    for (NSArray *array in self.standardArrays) {
        // Gold standard
        CGPoint point = CGPointMake(((NSNumber *)array[0]).doubleValue,
                                    ((NSNumber *)array[1]).doubleValue);

        Vector *standard = [Vector vectorWithX:point.x Y:-point.y Z:0];

        // Actual result
        Vector *result = [Vector vectorWithCGPoint:point];

        // Comparison
        XCTAssertEqualObjects(standard, result);
    }
}

//
- (void)testVectorWithUniformNumbers {
    for (NSArray *array in self.standardArrays) {
        for (NSNumber *number1 in array) {
            // Gold standard
            CGFloat u = number1.doubleValue;
            Vector *standard = [Vector vectorWithX:u Y:u Z:u];

            // Acutal result
            Vector *result =
                [Vector vectorWithUniformNumbers:number1.doubleValue];

            // Comparison
            XCTAssertEqualObjects(standard, result);
        }
    }
}

//
- (void)testVectorWithCIVector {
    for (int i = 0; i < self.standardArrays.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Actual result
        NSArray *vectorArray = self.standardArrays[i];
        CIVector *civector =
            [CIVector vectorWithX:((NSNumber *)vectorArray[0]).doubleValue
                                Y:((NSNumber *)vectorArray[1]).doubleValue
                                Z:((NSNumber *)vectorArray[2]).doubleValue];
        Vector *result = [Vector vectorWithCIVector:civector];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

// toSCNVector3
- (void)testVectorWithSCNVector3 {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Actual result
        SCNVector3 vector3 = standard.toSCNVector3;
        Vector *result = [Vector vectorWithSCNVector3:vector3];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

// x, y, z
- (void)testVectorWithSCNVector4 {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Actual result
        SCNVector4 vector4
            = SCNVector4Make(standard.x, standard.y, standard.z, arc4random());
        Vector *result = [Vector vectorWithSCNVector4:vector4];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

//
- (void)testVectorWithNSValue {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Actual result
        SCNVector3 vector3 = standard.toSCNVector3;
        NSValue *value = [NSValue valueWithSCNVector3:vector3];
        Vector *result = [Vector vectorWithNSValue:value];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

// toArray
- (void)testVectorWithArray {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Actual result
        NSArray *array = standard.toArray;
        Vector *result = [Vector vectorWithArray:array];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

// x, y, z
- (void)testVectorWithDictionary {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Actual result
        NSDictionary *dictionary = @{
            @"x" : @(standard.x),
            @"y" : @(standard.y),
            @"z" : @(standard.z)
        };
        Vector *result = [Vector vectorWithDictionary:dictionary];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

// x, y, z
- (void)testVectorWithString {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Actual result
        NSArray *formats =
            @[ @"[%lf, %lf, %lf]", @"vn %lf %lf %lf", @"(%lf %lf %lf)" ];

        NSString *string = [NSString stringWithFormat:formats[i % 3],
                                                      standard.x,
                                                      standard.y,
                                                      standard.z];
        Vector *result = [Vector vectorWithString:string];

        // Comparison
        XCTAssertEqualWithAccuracy(result.x,
                                   standard.x,
                                   fabs(standard.x / 100));
        XCTAssertEqualWithAccuracy(result.y,
                                   standard.y,
                                   fabs(standard.y / 100));
        XCTAssertEqualWithAccuracy(result.z,
                                   standard.z,
                                   fabs(standard.z / 100));
    }
}

//
- (void)testVectorWithVector {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Actual result
        Vector *result = [Vector vectorWithVector:standard];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

//
- (void)testVectorWithObject {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Results and comparisons
        Vector *result;

        NSDictionary *dictionary = @{
            @"x" : @(standard.x),
            @"y" : @(standard.y),
            @"z" : @(standard.z)
        };
        result = [Vector vectorWithObject:dictionary];
        XCTAssertEqualObjects(result, standard);

        NSString *string = [NSString stringWithFormat:@"%lf %lf %lf",
                                                      standard.x,
                                                      standard.y,
                                                      standard.z];
        result = [Vector vectorWithObject:string];
        XCTAssertEqualWithAccuracy(result.x,
                                   standard.x,
                                   fabs(standard.x / 100));
        XCTAssertEqualWithAccuracy(result.y,
                                   standard.y,
                                   fabs(standard.y / 100));
        XCTAssertEqualWithAccuracy(result.z,
                                   standard.z,
                                   fabs(standard.z / 100));

        result = [Vector vectorWithObject:standard];
        XCTAssertEqualObjects(result, standard);

        NSValue *value = [NSValue valueWithSCNVector3:standard.toSCNVector3];
        result = [Vector vectorWithObject:value];
        XCTAssertEqualObjects(result, standard);

        result = [Vector vectorWithObject:standard.toArray];
        XCTAssertEqualObjects(result, standard);

        result = [Vector vectorWithObject:@(standard.x)];
        standard = [Vector vectorWithUniformNumbers:standard.x];
        XCTAssertEqualObjects(result, standard);
    }
}

// x, y, z
- (void)testInitWithXYZ {
    // Gold Standard
    for (Vector *standard in self.standardVectors) {

        // Actual result
        Vector *result =
            [[Vector alloc] initWithX:standard.x Y:standard.y Z:standard.z];

        // Comparison
        XCTAssertEqualObjects(standard, result);
    }
}

//
- (void)testInit {
    XCTAssertNotNil([[Vector alloc] init]);
}

//
- (void)testInitWithCGPoint {
    for (NSArray *array in self.standardArrays) {
        // Gold standard
        CGPoint point = CGPointMake(((NSNumber *)array[0]).doubleValue,
                                    ((NSNumber *)array[1]).doubleValue);

        Vector *standard = [Vector vectorWithX:point.x Y:-point.y Z:0];

        // Actual result
        Vector *result = [[Vector alloc] initWithCGPoint:point];

        // Comparison
        XCTAssertEqualObjects(standard, result);
    }
}

//
- (void)testInitWithUniformNumbers {
    for (NSArray *array in self.standardArrays) {
        for (NSNumber *number1 in array) {
            // Gold standard
            CGFloat u = number1.doubleValue;
            Vector *standard = [Vector vectorWithX:u Y:u Z:u];

            // Acutal result
            Vector *result =
                [[Vector alloc] initWithUniformNumbers:number1.doubleValue];

            // Comparison
            XCTAssertEqualObjects(standard, result);
        }
    }
}

//
- (void)testInitWithCIVector {
    for (int i = 0; i < self.standardArrays.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Actual result
        NSArray *vectorArray = self.standardArrays[i];
        CIVector *civector =
            [CIVector vectorWithX:((NSNumber *)vectorArray[0]).doubleValue
                                Y:((NSNumber *)vectorArray[1]).doubleValue
                                Z:((NSNumber *)vectorArray[2]).doubleValue];
        Vector *result = [[Vector alloc] initWithCIVector:civector];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

// toSCNVector3
- (void)testInitWithSCNVector3 {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Actual result
        SCNVector3 vector3 = standard.toSCNVector3;
        Vector *result = [[Vector alloc] initWithSCNVector3:vector3];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

// x, y, z
- (void)testInitWithSCNVector4 {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Actual result
        SCNVector4 vector4
            = SCNVector4Make(standard.x, standard.y, standard.z, arc4random());
        Vector *result = [[Vector alloc] initWithSCNVector4:vector4];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

//
- (void)testInitWithNSValue {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Actual result
        SCNVector3 vector3 = standard.toSCNVector3;
        NSValue *value = [NSValue valueWithSCNVector3:vector3];
        Vector *result = [[Vector alloc] initWithNSValue:value];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

// toArray
- (void)testInitWithArray {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Actual result
        NSArray *array = standard.toArray;
        Vector *result = [[Vector alloc] initWithArray:array];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

// x, y, z
- (void)testInitWithDictionary {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Actual result
        NSDictionary *dictionary = @{
            @"x" : @(standard.x),
            @"y" : @(standard.y),
            @"z" : @(standard.z)
        };
        Vector *result = [[Vector alloc] initWithDictionary:dictionary];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

// x, y, z
- (void)testInitWithString {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Actual result
        NSArray *formats =
            @[ @"[%lf, %lf, %lf]", @"vn %lf %lf %lf", @"(%lf %lf %lf)" ];

        NSString *string = [NSString stringWithFormat:formats[i % 3],
                                                      standard.x,
                                                      standard.y,
                                                      standard.z];
        Vector *result = [[Vector alloc] initWithString:string];

        // Comparison
        XCTAssertEqualWithAccuracy(result.x,
                                   standard.x,
                                   fabs(standard.x / 100));
        XCTAssertEqualWithAccuracy(result.y,
                                   standard.y,
                                   fabs(standard.y / 100));
        XCTAssertEqualWithAccuracy(result.z,
                                   standard.z,
                                   fabs(standard.z / 100));
    }
}

//
- (void)testInitWithVector {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Actual result
        Vector *result = [[Vector alloc] initWithVector:standard];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

//
- (void)testInitWithObject {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *standard = self.standardVectors[i];

        // Results and comparisons
        Vector *result;

        NSDictionary *dictionary = @{
            @"x" : @(standard.x),
            @"y" : @(standard.y),
            @"z" : @(standard.z)
        };
        result = [[Vector alloc] initWithObject:dictionary];
        XCTAssertEqualObjects(result, standard);

        NSString *string = [NSString stringWithFormat:@"%lf %lf %lf",
                                                      standard.x,
                                                      standard.y,
                                                      standard.z];
        result = [[Vector alloc] initWithObject:string];
        XCTAssertEqualWithAccuracy(result.x,
                                   standard.x,
                                   fabs(standard.x / 100));
        XCTAssertEqualWithAccuracy(result.y,
                                   standard.y,
                                   fabs(standard.y / 100));
        XCTAssertEqualWithAccuracy(result.z,
                                   standard.z,
                                   fabs(standard.z / 100));

        result = [[Vector alloc] initWithObject:standard];
        XCTAssertEqualObjects(result, standard);

        NSValue *value = [NSValue valueWithSCNVector3:standard.toSCNVector3];
        result = [[Vector alloc] initWithObject:value];
        XCTAssertEqualObjects(result, standard);

        result = [[Vector alloc] initWithObject:standard.toArray];
        XCTAssertEqualObjects(result, standard);

        result = [[Vector alloc] initWithObject:@(standard.x)];
        standard = [Vector vectorWithUniformNumbers:standard.x];
        XCTAssertEqualObjects(result, standard);
    }
}

- (void)testTimes {
    for (Vector *vector in self.standardVectors) {
        // Gold standard
        CGFloat scalar = randomFloat();
        SCNVector3 vector3 = vector.toSCNVector3;
        SCNVector3 standard = SCNVector3Make(vector3.x * scalar,
                                             vector3.y * scalar,
                                             vector3.z * scalar);

        // Actual results
        Vector *result = [[Vector vectorWithSCNVector3:vector3] times:scalar];

        // Comparison
        XCTAssert([result isEqualToVector:standard]);
    }
}

- (void)testOver {
    for (Vector *vector in self.standardVectors) {
        // Gold standard
        CGFloat scalar = randomFloat();
        SCNVector3 vector3 = vector.toSCNVector3;
        SCNVector3 standard = SCNVector3Make(vector3.x / scalar,
                                             vector3.y / scalar,
                                             vector3.z / scalar);

        // Actual results
        Vector *result = [[Vector vectorWithSCNVector3:vector3] over:scalar];

        // Comparison
        XCTAssert([result isEqualToVector:standard]);
    }
}

#warning Test these methods with multiple different objects
- (void)testPlus {
    for (int i = 0; i < self.standardVectors.count; i++) {
        Vector *vector1 = self.standardVectors[i];
        SCNVector3 scnvector1 = vector1.toSCNVector3;
        Vector *vector2
            = self.standardVectors[(i + 1) % self.standardVectors.count];
        SCNVector3 scnvector2 = vector2.toSCNVector3;

        // Gold standard
        SCNVector3 standard = SCNVector3Make(scnvector1.x + scnvector2.x,
                                             scnvector1.y + scnvector2.y,
                                             scnvector1.z + scnvector2.z);

        // Actual results
        Vector *result =
            [[Vector vectorWithSCNVector3:scnvector1] plus:vector2];

        // Comparison
        XCTAssert([result isEqualToVector:standard]);
    }
}

- (void)testMinus {
    for (int i = 0; i < self.standardVectors.count; i++) {
        Vector *vector1 = self.standardVectors[i];
        SCNVector3 scnvector1 = vector1.toSCNVector3;
        Vector *vector2
            = self.standardVectors[(i + 1) % self.standardVectors.count];
        SCNVector3 scnvector2 = vector2.toSCNVector3;

        // Gold standard
        SCNVector3 standard = SCNVector3Make(scnvector1.x - scnvector2.x,
                                             scnvector1.y - scnvector2.y,
                                             scnvector1.z - scnvector2.z);

        // Actual results
        Vector *result =
            [[Vector vectorWithSCNVector3:scnvector1] minus:vector2];

        // Comparison
        XCTAssert([result isEqualToVector:standard]);
    }
}

- (void)testOpposite {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *vector = self.standardVectors[i];
        SCNVector3 vector3 = vector.toSCNVector3;
        SCNVector3 standard
            = SCNVector3Make(-vector3.x, -vector3.y, -vector3.z);

        // Actual results
        Vector *result = [Vector vectorWithSCNVector3:vector3].opposite;

        // Comparison
        XCTAssert([result isEqualToVector:standard]);
    }
}

- (void)testDot {
    for (int i = 0; i < self.standardVectors.count; i++) {
        Vector *vector1 = self.standardVectors[i];
        SCNVector3 scnvector1 = vector1.toSCNVector3;
        Vector *vector2
            = self.standardVectors[(i + 1) % self.standardVectors.count];
        SCNVector3 scnvector2 = vector2.toSCNVector3;

        // Gold standard
        CGFloat standard = (scnvector1.x * scnvector2.x)
                           + (scnvector1.y * scnvector2.y)
                           + (scnvector1.z * scnvector2.z);

        // Actual results
        CGFloat result = [vector1 dot:vector2];

        // Comparison
        XCTAssertEqualWithAccuracy(standard, result, fabs(standard / 100));
    }
}

@end
