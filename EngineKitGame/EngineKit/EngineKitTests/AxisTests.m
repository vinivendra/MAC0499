

#import <XCTest/XCTest.h>

#import "TestCommons.h"

#import "NSDictionary+Extension.h"
#import "ObjectiveSugar.h"
#import "Axis.h"


@interface AxisTests : XCTestCase
@property (nonatomic, strong) NSMutableArray *standardArrays;
@property (nonatomic, strong) NSMutableArray *standardAxes;
@end

@implementation AxisTests

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

    self.standardAxes = [NSMutableArray array];

    for (NSArray *axis in self.standardArrays) {
        [self.standardAxes
            push:[Axis axisWithX:((NSNumber *)axis[0]).doubleValue
                               Y:((NSNumber *)axis[1]).doubleValue
                               Z:((NSNumber *)axis[2]).doubleValue]];
    }
}


//------------------------------------------------------------------------------
#pragma mark - Basis
//------------------------------------------------------------------------------

- (void)testAxisWithXYZAndEquals {
    for (int i = 0; i < self.standardArrays.count; i++) {
        // Bijection
        NSArray *axisArray = self.standardArrays[i];
        NSArray *nextAxisArray
            = self.standardArrays[(i + 1) % self.standardArrays.count];

        Axis *axis1 = [Axis axisWithX:((NSNumber *)axisArray[0]).doubleValue
                                    Y:((NSNumber *)axisArray[1]).doubleValue
                                    Z:((NSNumber *)axisArray[2]).doubleValue];

        Axis *axis2 = [Axis axisWithX:((NSNumber *)axisArray[0]).doubleValue
                                    Y:((NSNumber *)axisArray[1]).doubleValue
                                    Z:((NSNumber *)axisArray[2]).doubleValue];

        Axis *axis3 =
            [Axis axisWithX:((NSNumber *)nextAxisArray[0]).doubleValue
                          Y:((NSNumber *)nextAxisArray[1]).doubleValue
                          Z:((NSNumber *)nextAxisArray[2]).doubleValue];

        XCTAssert([axis1 isEqual:axis2]);
        XCTAssert([axis1 isEqualToVector:axis2.toSCNVector3]);
        XCTAssertEqualObjects(axis1, axis2);

        XCTAssertNotEqualObjects(axis1, axis3);
        XCTAssertFalse([axis1 isEqual:axis3]);
        XCTAssertFalse([axis1 isEqualToVector:axis3.toSCNVector3]);
    }
}


//------------------------------------------------------------------------------
#pragma mark - Creation
//------------------------------------------------------------------------------

- (void)testOrigin {

    // Gold standard
    Axis *standard = [Axis axisWithX:0 Y:0 Z:0];

    // Actual result
    Axis *result = [Axis origin];

    // Comparison
    XCTAssertEqualObjects(standard, result);
}

- (void)testAxisWithUniformNumbers {
    for (NSArray *array in self.standardArrays) {
        for (NSNumber *number1 in array) {
            // Gold standard
            CGFloat u = number1.doubleValue;
            Axis *standard = [Axis axisWithX:u Y:u Z:u];

            // Acutal result
            Axis *result =
            [Axis axisWithUniformNumbers:number1.doubleValue];

            // Comparison
            XCTAssertEqualObjects(standard, result);
        }
    }
}

- (void)testAxisWithCIAxis {
    for (int i = 0; i < self.standardArrays.count; i++) {
        // Gold standard
        Axis *standard = self.standardAxes[i];

        // Actual result
        NSArray *axisArray = self.standardArrays[i];
        CIVector *ciaxis =
        [CIVector vectorWithX:((NSNumber *)axisArray[0]).doubleValue
                            Y:((NSNumber *)axisArray[1]).doubleValue
                            Z:((NSNumber *)axisArray[2]).doubleValue];
        Axis *result = [Axis axisWithCIVector:ciaxis];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

- (void)testAxisWithSCNVector3 {
    for (int i = 0; i < self.standardAxes.count; i++) {
        // Gold standard
        Axis *standard = self.standardAxes[i];

        // Actual result
        SCNVector3 axis3 = standard.toSCNVector3;
        Axis *result = [Axis axisWithSCNVector3:axis3];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

- (void)testAxisWithSCNVector4 {
    for (int i = 0; i < self.standardAxes.count; i++) {
        // Gold standard
        Axis *standard = self.standardAxes[i];

        // Actual result
        SCNVector4 axis4
        = SCNVector4Make(standard.x, standard.y, standard.z, arc4random());
        Axis *result = [Axis axisWithSCNVector4:axis4];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}


- (void)testAxisWithNSValue {
    for (int i = 0; i < self.standardAxes.count; i++) {
        // Gold standard
        Axis *standard = self.standardAxes[i];

        // Actual result
        SCNVector3 axis3 = standard.toSCNVector3;
        NSValue *value = [NSValue valueWithSCNVector3:axis3];
        Axis *result = [Axis axisWithNSValue:value];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

- (void)testAxisWithArray {
    for (int i = 0; i < self.standardAxes.count; i++) {
        // Gold standard
        Axis *standard = self.standardAxes[i];

        // Actual result
        NSArray *array = standard.toArray;
        Axis *result = [Axis axisWithArray:array];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

- (void)testAxisWithDictionary {
    for (int i = 0; i < self.standardAxes.count; i++) {
        // Gold standard
        Axis *standard = self.standardAxes[i];

        // Actual result
        NSDictionary *dictionary = @{
                                     @"x" : @(standard.x),
                                     @"y" : @(standard.y),
                                     @"z" : @(standard.z)
                                     };
        Axis *result = [Axis axisWithDictionary:dictionary];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

- (void)testAxisWithString {
    for (int i = 0; i < self.standardAxes.count; i++) {
        // Gold standard
        Axis *standard = self.standardAxes[i];

        // Actual result
        NSArray *formats =
        @[ @"[%lf, %lf, %lf]", @"vn %lf %lf %lf", @"(%lf %lf %lf)" ];

        NSString *string = [NSString stringWithFormat:formats[i % 3],
                            standard.x,
                            standard.y,
                            standard.z];
        Axis *result = [Axis axisWithString:string];

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

- (void)testAxisWithVector {
    for (int i = 0; i < self.standardAxes.count; i++) {
        // Gold standard
        Axis *standard = self.standardAxes[i];

        // Actual result
        Vector *vector = [Vector vectorWithVector:standard];
        Axis *result1 = [Axis axisWithVector:vector];
        Axis *result2 = [Axis axisWithVector:standard];

        // Comparison
        XCTAssertEqualObjects(result1, standard);
        XCTAssertEqualObjects(result2, standard);
    }
}

- (void)testAxisWithAxis {
    for (int i = 0; i < self.standardAxes.count; i++) {
        // Gold standard
        Axis *standard = self.standardAxes[i];

        // Actual result
        Axis *result = [Axis axisWithAxis:standard];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}


- (void)testAxisWithObject {
    for (int i = 0; i < self.standardAxes.count; i++) {
        // Gold standard
        Axis *standard = self.standardAxes[i];

        // Results and comparisons
        Axis *result;

        NSDictionary *dictionary = @{
                                     @"x" : @(standard.x),
                                     @"y" : @(standard.y),
                                     @"z" : @(standard.z)
                                     };
        result = [Axis axisWithObject:dictionary];
        XCTAssertEqualObjects(result, standard);

        NSString *string = [NSString stringWithFormat:@"%lf %lf %lf",
                            standard.x,
                            standard.y,
                            standard.z];
        result = [Axis axisWithObject:string];
        XCTAssertEqualWithAccuracy(result.x,
                                   standard.x,
                                   fabs(standard.x / 100));
        XCTAssertEqualWithAccuracy(result.y,
                                   standard.y,
                                   fabs(standard.y / 100));
        XCTAssertEqualWithAccuracy(result.z,
                                   standard.z,
                                   fabs(standard.z / 100));

        result = [Axis axisWithObject:standard];
        XCTAssertEqualObjects(result, standard);

        NSValue *value = [NSValue valueWithSCNVector3:standard.toSCNVector3];
        result = [Axis axisWithObject:value];
        XCTAssertEqualObjects(result, standard);

        result = [Axis axisWithObject:standard.toArray];
        XCTAssertEqualObjects(result, standard);
        
        result = [Axis axisWithObject:@(standard.x)];
        standard = [Axis axisWithUniformNumbers:standard.x];
        XCTAssertEqualObjects(result, standard);
    }
}


@end
