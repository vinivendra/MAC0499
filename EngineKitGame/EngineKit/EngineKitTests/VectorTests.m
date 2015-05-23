

#import <XCTest/XCTest.h>

#import "TestCommons.h"

#import "NSDictionary+Extension.h"
#import "ObjectiveSugar.h"
#import "Vector.h"


@interface VectorTests : XCTestCase
@property (nonatomic, strong) NSMutableArray *standardArrays;
@property (nonatomic, strong) NSMutableArray *standardVectors;
@end


@implementation VectorTests


- (void)setUp {
    [super setUp];

    setupRandomSeed();

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
        XCTAssertEqualWithAccuracy(xStandard, xResult, fabs(xStandard / 100));
        XCTAssertEqualWithAccuracy(yStandard, yResult, fabs(yStandard / 100));
        XCTAssertEqualWithAccuracy(zStandard, zResult, fabs(zStandard / 100));
    }
}

- (void)testToArray {
    for (Vector *vector in self.standardVectors) {
        XCTAssertEqual(vector.x, ((NSNumber *)vector.toArray[0]).doubleValue);
        XCTAssertEqual(vector.y, ((NSNumber *)vector.toArray[1]).doubleValue);
        XCTAssertEqual(vector.z, ((NSNumber *)vector.toArray[2]).doubleValue);
        XCTAssertNil(vector[3]);
    }
}

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

- (void)testOrigin {

    // Gold standard
    Vector *standard = [Vector vectorWithX:0 Y:0 Z:0];

    // Actual result
    Vector *result = [Vector origin];

    // Comparison
    XCTAssertEqualObjects(standard, result);
}

- (void)testVector {
    XCTAssertNotNil([Vector vector]);
}

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

- (void)testInit {
    XCTAssertNotNil([[Vector alloc] init]);
}

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
        CGFloat scalar = randomFloat() ?: 1;
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

- (void)testPlus {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *vector1 = self.standardVectors[i];
        SCNVector3 scnvector1 = vector1.toSCNVector3;
        Vector *vector2 =
            [Vector vectorWithX:randomFloat() Y:randomFloat() Z:randomFloat()];
        SCNVector3 scnvector2 = vector2.toSCNVector3;

        Vector *standard = [Vector vectorWithX:scnvector1.x + scnvector2.x
                                             Y:scnvector1.y + scnvector2.y
                                             Z:scnvector1.z + scnvector2.z];

        // Results and comparisons
        Vector *result;

        NSDictionary *dictionary =
            @{ @"x" : @(vector2.x),
               @"y" : @(vector2.y),
               @"z" : @(vector2.z) };
        result = [[Vector vectorWithSCNVector3:scnvector1] plus:dictionary];
        XCTAssertEqualObjects(result, standard);

        NSString *string = [NSString
            stringWithFormat:@"%lf %lf %lf", vector2.x, vector2.y, vector2.z];
        result = [[Vector vectorWithSCNVector3:scnvector1] plus:string];
        XCTAssertEqualWithAccuracy(result.x,
                                   standard.x,
                                   fabs(standard.x / 100));
        XCTAssertEqualWithAccuracy(result.y,
                                   standard.y,
                                   fabs(standard.y / 100));
        XCTAssertEqualWithAccuracy(result.z,
                                   standard.z,
                                   fabs(standard.z / 100));

        result = [[Vector vectorWithSCNVector3:scnvector1] plus:vector2];
        XCTAssertEqualObjects(result, standard);

        NSValue *value = [NSValue valueWithSCNVector3:vector2.toSCNVector3];
        result = [[Vector vectorWithSCNVector3:scnvector1] plus:value];
        XCTAssertEqualObjects(result, standard);

        result =
            [[Vector vectorWithSCNVector3:scnvector1] plus:vector2.toArray];
        XCTAssertEqualObjects(result, standard);

        result = [[Vector vectorWithSCNVector3:scnvector1] plus:@(vector2.x)];
        standard = [Vector vectorWithX:scnvector1.x + scnvector2.x
                                     Y:scnvector1.y + scnvector2.x
                                     Z:scnvector1.z + scnvector2.x];
        XCTAssertEqualObjects(result, standard);
    }
}

- (void)testMinus {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *vector1 = self.standardVectors[i];
        SCNVector3 scnvector1 = vector1.toSCNVector3;
        Vector *vector2 =
            [Vector vectorWithX:randomFloat() Y:randomFloat() Z:randomFloat()];
        SCNVector3 scnvector2 = vector2.toSCNVector3;

        Vector *standard = [Vector vectorWithX:scnvector1.x - scnvector2.x
                                             Y:scnvector1.y - scnvector2.y
                                             Z:scnvector1.z - scnvector2.z];

        // Results and comparisons
        Vector *result;

        NSDictionary *dictionary =
            @{ @"x" : @(vector2.x),
               @"y" : @(vector2.y),
               @"z" : @(vector2.z) };
        result = [[Vector vectorWithSCNVector3:scnvector1] minus:dictionary];
        XCTAssertEqualObjects(result, standard);

        NSString *string = [NSString
            stringWithFormat:@"%lf %lf %lf", vector2.x, vector2.y, vector2.z];
        result = [[Vector vectorWithSCNVector3:scnvector1] minus:string];
        XCTAssertEqualWithAccuracy(result.x,
                                   standard.x,
                                   fabs(standard.x / 100));
        XCTAssertEqualWithAccuracy(result.y,
                                   standard.y,
                                   fabs(standard.y / 100));
        XCTAssertEqualWithAccuracy(result.z,
                                   standard.z,
                                   fabs(standard.z / 100));

        result = [[Vector vectorWithSCNVector3:scnvector1] minus:vector2];
        XCTAssertEqualObjects(result, standard);

        NSValue *value = [NSValue valueWithSCNVector3:vector2.toSCNVector3];
        result = [[Vector vectorWithSCNVector3:scnvector1] minus:value];
        XCTAssertEqualObjects(result, standard);

        result =
            [[Vector vectorWithSCNVector3:scnvector1] minus:vector2.toArray];
        XCTAssertEqualObjects(result, standard);

        result = [[Vector vectorWithSCNVector3:scnvector1] minus:@(vector2.x)];
        standard = [Vector vectorWithX:scnvector1.x - scnvector2.x
                                     Y:scnvector1.y - scnvector2.x
                                     Z:scnvector1.z - scnvector2.x];
        XCTAssertEqualObjects(result, standard);
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
        // Gold standard
        Vector *vector1 = self.standardVectors[i];
        SCNVector3 scnvector1 = vector1.toSCNVector3;
        Vector *vector2
            = self.standardVectors[(i + 1) % self.standardVectors.count];
        SCNVector3 scnvector2 = vector2.toSCNVector3;

        CGFloat standard = (scnvector1.x * scnvector2.x)
                           + (scnvector1.y * scnvector2.y)
                           + (scnvector1.z * scnvector2.z);

        // Results and comparisons
        CGFloat result;

        NSDictionary *dictionary =
            @{ @"x" : @(vector2.x),
               @"y" : @(vector2.y),
               @"z" : @(vector2.z) };
        result = [vector1 dot:dictionary];
        XCTAssertEqualWithAccuracy(standard, result, fabs(standard / 100));

        NSString *string = [NSString
            stringWithFormat:@"%lf %lf %lf", vector2.x, vector2.y, vector2.z];
        result = [vector1 dot:string];
        XCTAssertEqualWithAccuracy(standard, result, fabs(standard / 100));

        result = [vector1 dot:vector2];
        XCTAssertEqualWithAccuracy(standard, result, fabs(standard / 100));

        NSValue *value = [NSValue valueWithSCNVector3:vector2.toSCNVector3];
        result = [vector1 dot:value];
        XCTAssertEqualWithAccuracy(standard, result, fabs(standard / 100));

        result = [vector1 dot:vector2.toArray];
        XCTAssertEqualWithAccuracy(standard, result, fabs(standard / 100));

        result = [vector1 dot:@(vector2.x)];
        standard = (scnvector1.x * scnvector2.x) + (scnvector1.y * scnvector2.x)
                   + (scnvector1.z * scnvector2.x);
        XCTAssertEqualWithAccuracy(standard, result, fabs(standard / 100));
    }
}

- (void)testNormSquared {
    for (int i = 0; i < self.standardVectors.count; i++) {
        Vector *vector = self.standardVectors[i];
        SCNVector3 vector3 = vector.toSCNVector3;

        // Gold standard
        CGFloat standard = (vector3.x * vector3.x) + (vector3.y * vector3.y)
                           + (vector3.z * vector3.z);

        // Actual results
        CGFloat result = vector.normSquared;

        // Comparison
        XCTAssertEqualWithAccuracy(standard, result, fabs(standard / 100));
    }
}

- (void)testNorm {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *vector = self.standardVectors[i];
        SCNVector3 vector3 = vector.toSCNVector3;
        CGFloat standard
            = sqrt((vector3.x * vector3.x) + (vector3.y * vector3.y)
                   + (vector3.z * vector3.z));

        // Actual results
        CGFloat result = vector.norm;

        // Comparison
        XCTAssertEqualWithAccuracy(standard, result, fabs(standard / 100));
    }
}

- (void)testNormalize {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *vector = self.standardVectors[i];
        SCNVector3 vector3 = vector.toSCNVector3;
        CGFloat norm = sqrt((vector3.x * vector3.x) + (vector3.y * vector3.y)
                            + (vector3.z * vector3.z))
                           ?: 1;
        Vector *standard = [vector over:norm];

        // Actual results
        Vector *result = vector.normalize;

        // Comparison
        XCTAssertEqualWithAccuracy(standard.x,
                                   result.x,
                                   fabs(standard.x / 100000));
        XCTAssertEqualWithAccuracy(standard.y,
                                   result.y,
                                   fabs(standard.y / 100000));
        XCTAssertEqualWithAccuracy(standard.z,
                                   result.z,
                                   fabs(standard.z / 100000));
    }
}

- (void)testTranslate {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *vector1 = self.standardVectors[i];
        SCNVector3 scnvector1 = vector1.toSCNVector3;
        Vector *vector2 =
            [Vector vectorWithX:randomFloat() Y:randomFloat() Z:randomFloat()];
        SCNVector3 scnvector2 = vector2.toSCNVector3;

        Vector *standard = [Vector vectorWithX:scnvector1.x + scnvector2.x
                                             Y:scnvector1.y + scnvector2.y
                                             Z:scnvector1.z + scnvector2.z];

        // Results and comparisons
        Vector *result;

        NSDictionary *dictionary =
            @{ @"x" : @(vector2.x),
               @"y" : @(vector2.y),
               @"z" : @(vector2.z) };
        result =
            [[Vector vectorWithSCNVector3:scnvector1] translate:dictionary];
        XCTAssertEqualObjects(result, standard);

        NSString *string = [NSString
            stringWithFormat:@"%lf %lf %lf", vector2.x, vector2.y, vector2.z];
        result = [[Vector vectorWithSCNVector3:scnvector1] translate:string];
        XCTAssertEqualWithAccuracy(result.x,
                                   standard.x,
                                   fabs(standard.x / 100));
        XCTAssertEqualWithAccuracy(result.y,
                                   standard.y,
                                   fabs(standard.y / 100));
        XCTAssertEqualWithAccuracy(result.z,
                                   standard.z,
                                   fabs(standard.z / 100));

        result = [[Vector vectorWithSCNVector3:scnvector1] translate:vector2];
        XCTAssertEqualObjects(result, standard);

        NSValue *value = [NSValue valueWithSCNVector3:vector2.toSCNVector3];
        result = [[Vector vectorWithSCNVector3:scnvector1] translate:value];
        XCTAssertEqualObjects(result, standard);

        result = [[Vector vectorWithSCNVector3:scnvector1]
            translate:vector2.toArray];
        XCTAssertEqualObjects(result, standard);

        result =
            [[Vector vectorWithSCNVector3:scnvector1] translate:@(vector2.x)];
        standard = [Vector vectorWithX:scnvector1.x + scnvector2.x
                                     Y:scnvector1.y + scnvector2.x
                                     Z:scnvector1.z + scnvector2.x];
        XCTAssertEqualObjects(result, standard);
    }
}

- (void)testScale {
    for (int i = 0; i < self.standardVectors.count; i++) {
        // Gold standard
        Vector *vector1 = self.standardVectors[i];
        SCNVector3 scnvector1 = vector1.toSCNVector3;
        Vector *vector2 =
            [Vector vectorWithX:randomFloat() Y:randomFloat() Z:randomFloat()];
        SCNVector3 scnvector2 = vector2.toSCNVector3;

        Vector *standard = [Vector vectorWithX:scnvector1.x * scnvector2.x
                                             Y:scnvector1.y * scnvector2.y
                                             Z:scnvector1.z * scnvector2.z];

        // Results and comparisons
        Vector *result;

        NSDictionary *dictionary =
            @{ @"x" : @(vector2.x),
               @"y" : @(vector2.y),
               @"z" : @(vector2.z) };
        result = [[Vector vectorWithSCNVector3:scnvector1] scale:dictionary];
        XCTAssertEqualObjects(result, standard);

        NSString *string = [NSString
            stringWithFormat:@"%lf %lf %lf", vector2.x, vector2.y, vector2.z];
        result = [[Vector vectorWithSCNVector3:scnvector1] scale:string];
        XCTAssertEqualWithAccuracy(result.x,
                                   standard.x,
                                   fabs(standard.x / 100));
        XCTAssertEqualWithAccuracy(result.y,
                                   standard.y,
                                   fabs(standard.y / 100));
        XCTAssertEqualWithAccuracy(result.z,
                                   standard.z,
                                   fabs(standard.z / 100));

        result = [[Vector vectorWithSCNVector3:scnvector1] scale:vector2];
        XCTAssertEqualObjects(result, standard);

        NSValue *value = [NSValue valueWithSCNVector3:vector2.toSCNVector3];
        result = [[Vector vectorWithSCNVector3:scnvector1] scale:value];
        XCTAssertEqualObjects(result, standard);

        result =
            [[Vector vectorWithSCNVector3:scnvector1] scale:vector2.toArray];
        XCTAssertEqualObjects(result, standard);

        result = [[Vector vectorWithSCNVector3:scnvector1] scale:@(vector2.x)];
        standard = [Vector vectorWithX:scnvector1.x * scnvector2.x
                                     Y:scnvector1.y * scnvector2.x
                                     Z:scnvector1.z * scnvector2.x];
        XCTAssertEqualObjects(result, standard);
    }
}

- (void)testTranslateMatrix {

    for (Vector *vector in self.standardVectors) {
        // Gold standard
        SCNMatrix4 translate = SCNMatrix4MakeTranslation(randomFloat(),
                                                         randomFloat(),
                                                         randomFloat());
        SCNMatrix4 scale
            = SCNMatrix4MakeScale(randomFloat(), randomFloat(), randomFloat());
        SCNMatrix4 rotate = SCNMatrix4MakeRotation(randomFloat(),
                                                   randomFloat(),
                                                   randomFloat(),
                                                   randomFloat());
        SCNMatrix4 matrix4
            = SCNMatrix4Mult(SCNMatrix4Mult(translate, rotate), scale);

        SCNVector3 vector3 = vector.toSCNVector3;

        SCNMatrix4 standard
            = SCNMatrix4Translate(matrix4, vector3.x, vector3.y, vector3.z);

        // Result
        SCNMatrix4 result = [vector translateMatrix:matrix4];

        // Comparison
        XCTAssertEqualWithAccuracy(result.m11,
                                   standard.m11,
                                   fabs(standard.m11 / 100000));
        XCTAssertEqualWithAccuracy(result.m12,
                                   standard.m12,
                                   fabs(standard.m12 / 100000));
        XCTAssertEqualWithAccuracy(result.m13,
                                   standard.m13,
                                   fabs(standard.m13 / 100000));
        XCTAssertEqualWithAccuracy(result.m14,
                                   standard.m14,
                                   fabs(standard.m14 / 100000));
        XCTAssertEqualWithAccuracy(result.m21,
                                   standard.m21,
                                   fabs(standard.m21 / 100000));
        XCTAssertEqualWithAccuracy(result.m22,
                                   standard.m22,
                                   fabs(standard.m22 / 100000));
        XCTAssertEqualWithAccuracy(result.m23,
                                   standard.m23,
                                   fabs(standard.m23 / 100000));
        XCTAssertEqualWithAccuracy(result.m24,
                                   standard.m24,
                                   fabs(standard.m24 / 100000));
        XCTAssertEqualWithAccuracy(result.m31,
                                   standard.m31,
                                   fabs(standard.m31 / 100000));
        XCTAssertEqualWithAccuracy(result.m32,
                                   standard.m32,
                                   fabs(standard.m32 / 100000));
        XCTAssertEqualWithAccuracy(result.m33,
                                   standard.m33,
                                   fabs(standard.m33 / 100000));
        XCTAssertEqualWithAccuracy(result.m34,
                                   standard.m34,
                                   fabs(standard.m34 / 100000));
        XCTAssertEqualWithAccuracy(result.m41,
                                   standard.m41,
                                   fabs(standard.m41 / 100000));
        XCTAssertEqualWithAccuracy(result.m42,
                                   standard.m42,
                                   fabs(standard.m42 / 100000));
        XCTAssertEqualWithAccuracy(result.m43,
                                   standard.m43,
                                   fabs(standard.m43 / 100000));
        XCTAssertEqualWithAccuracy(result.m44,
                                   standard.m44,
                                   fabs(standard.m44 / 100000));
    }
}

- (void)testScaleMatrix {

    for (Vector *vector in self.standardVectors) {
        // Gold standard
        SCNMatrix4 translate = SCNMatrix4MakeTranslation(randomFloat(),
                                                         randomFloat(),
                                                         randomFloat());
        SCNMatrix4 scale
            = SCNMatrix4MakeScale(randomFloat(), randomFloat(), randomFloat());
        SCNMatrix4 rotate = SCNMatrix4MakeRotation(randomFloat(),
                                                   randomFloat(),
                                                   randomFloat(),
                                                   randomFloat());
        SCNMatrix4 matrix4
            = SCNMatrix4Mult(SCNMatrix4Mult(translate, rotate), scale);

        SCNVector3 vector3 = vector.toSCNVector3;

        SCNMatrix4 standard
            = SCNMatrix4Scale(matrix4, vector3.x, vector3.y, vector3.z);

        // Result
        SCNMatrix4 result = [vector scaleMatrix:matrix4];

        // Comparison
        XCTAssertEqualWithAccuracy(result.m11,
                                   standard.m11,
                                   fabs(standard.m11 / 100000));
        XCTAssertEqualWithAccuracy(result.m12,
                                   standard.m12,
                                   fabs(standard.m12 / 100000));
        XCTAssertEqualWithAccuracy(result.m13,
                                   standard.m13,
                                   fabs(standard.m13 / 100000));
        XCTAssertEqualWithAccuracy(result.m14,
                                   standard.m14,
                                   fabs(standard.m14 / 100000));
        XCTAssertEqualWithAccuracy(result.m21,
                                   standard.m21,
                                   fabs(standard.m21 / 100000));
        XCTAssertEqualWithAccuracy(result.m22,
                                   standard.m22,
                                   fabs(standard.m22 / 100000));
        XCTAssertEqualWithAccuracy(result.m23,
                                   standard.m23,
                                   fabs(standard.m23 / 100000));
        XCTAssertEqualWithAccuracy(result.m24,
                                   standard.m24,
                                   fabs(standard.m24 / 100000));
        XCTAssertEqualWithAccuracy(result.m31,
                                   standard.m31,
                                   fabs(standard.m31 / 100000));
        XCTAssertEqualWithAccuracy(result.m32,
                                   standard.m32,
                                   fabs(standard.m32 / 100000));
        XCTAssertEqualWithAccuracy(result.m33,
                                   standard.m33,
                                   fabs(standard.m33 / 100000));
        XCTAssertEqualWithAccuracy(result.m34,
                                   standard.m34,
                                   fabs(standard.m34 / 100000));
        XCTAssertEqualWithAccuracy(result.m41,
                                   standard.m41,
                                   fabs(standard.m41 / 100000));
        XCTAssertEqualWithAccuracy(result.m42,
                                   standard.m42,
                                   fabs(standard.m42 / 100000));
        XCTAssertEqualWithAccuracy(result.m43,
                                   standard.m43,
                                   fabs(standard.m43 / 100000));
        XCTAssertEqualWithAccuracy(result.m44,
                                   standard.m44,
                                   fabs(standard.m44 / 100000));
    }
}

- (void)testNewX {
    for (Vector *vector in self.standardVectors) {
        // Gold Standard
        CGFloat newX = randomFloat();
        SCNVector3 vector3 = vector.toSCNVector3;
        SCNVector3 standard = SCNVector3Make(newX, vector3.y, vector3.z);

        // Actual result
        Vector *resultVector = [vector setNewX:newX];
        SCNVector3 result = resultVector.toSCNVector3;

        // Comparison
        XCTAssert(SCNVector3EqualToVector3(result, standard));
    }
}

- (void)testNewY {
    for (Vector *vector in self.standardVectors) {
        // Gold Standard
        CGFloat newY = randomFloat();
        SCNVector3 vector3 = vector.toSCNVector3;
        SCNVector3 standard = SCNVector3Make(vector3.x, newY, vector3.z);

        // Actual result
        Vector *resultVector = [vector setNewY:newY];
        SCNVector3 result = resultVector.toSCNVector3;

        // Comparison
        XCTAssert(SCNVector3EqualToVector3(result, standard));
    }
}

- (void)testNewZ {
    for (Vector *vector in self.standardVectors) {
        // Gold Standard
        CGFloat newZ = randomFloat();
        SCNVector3 vector3 = vector.toSCNVector3;
        SCNVector3 standard = SCNVector3Make(vector3.x, vector3.y, newZ);

        // Actual result
        Vector *resultVector = [vector setNewZ:newZ];
        SCNVector3 result = resultVector.toSCNVector3;

        // Comparison
        XCTAssert(SCNVector3EqualToVector3(result, standard));
    }
}

@end
