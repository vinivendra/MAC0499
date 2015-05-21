

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
    [self.standardArrays push:@[ @0, @1, @0 ]];
    [self.standardArrays push:@[ @0, @0, @1 ]];

    for (int i = 0; i < 10; i++)
        [self.standardArrays push:@[
            @((double)rand() / rand()),
            @((double)rand() / rand()),
            @((double)rand() / rand())
        ]];

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

- (void)testVectorWithXYZAndEqual {
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

        XCTAssertEqualObjects(vector1, vector2);
        XCTAssertNotEqualObjects(vector1, vector3);
    }
}

//------------------------------------------------------------------------------
#pragma mark - Access
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
        XCTAssertEqualWithAccuracy(xStandard, xResult, 0.000001);
        XCTAssertEqualWithAccuracy(yStandard, yResult, 0.000001);
        XCTAssertEqualWithAccuracy(zStandard, zResult, 0.000001);
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
        XCTAssertEqualWithAccuracy(result.x, standard.x, 0.000001);
        XCTAssertEqualWithAccuracy(result.y, standard.y, 0.000001);
        XCTAssertEqualWithAccuracy(result.z, standard.z, 0.000001);
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
        XCTAssertEqualWithAccuracy(result.x, standard.x, 0.000001);
        XCTAssertEqualWithAccuracy(result.y, standard.y, 0.000001);
        XCTAssertEqualWithAccuracy(result.z, standard.z, 0.000001);

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
        XCTAssertEqualWithAccuracy(result.x, standard.x, 0.000001);
        XCTAssertEqualWithAccuracy(result.y, standard.y, 0.000001);
        XCTAssertEqualWithAccuracy(result.z, standard.z, 0.000001);
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
        XCTAssertEqualWithAccuracy(result.x, standard.x, 0.000001);
        XCTAssertEqualWithAccuracy(result.y, standard.y, 0.000001);
        XCTAssertEqualWithAccuracy(result.z, standard.z, 0.000001);

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


@end
