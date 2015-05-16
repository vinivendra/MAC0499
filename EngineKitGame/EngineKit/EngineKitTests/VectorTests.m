

#import <XCTest/XCTest.h>

#import "ObjectiveSugar.h"
#import "Vector.h"


NSString *stringForSCNVector3(SCNVector3 vector) {
    return [NSString
        stringWithFormat:@"(%lf %lf %lf)", vector.x, vector.y, vector.z];
}


@interface VectorTests : XCTestCase
@property (nonatomic, strong) NSMutableArray *testCases;
@end


@implementation VectorTests

- (NSMutableArray *)testArray {

    NSMutableArray *array = [NSMutableArray array];

    for (NSArray *vector in self.testCases) {
        [array push:[Vector vectorWithX:((NSNumber *)vector[0]).doubleValue
                                      Y:((NSNumber *)vector[1]).doubleValue
                                      Z:((NSNumber *)vector[2]).doubleValue]];
    }

    return array;
}

- (void)setUp {
    [super setUp];

    NSDateComponents *components = [[NSCalendar currentCalendar]
        components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
          fromDate:[NSDate date]];

    unsigned int seed = (unsigned int)components.day
                        + (unsigned int)components.month * 31
                        + (unsigned int)components.year * 12 * 31;

    srand(seed);

    self.testCases = [NSMutableArray array];
    [self.testCases push:@[ @0, @0, @0 ]];
    [self.testCases push:@[ @1, @0, @0 ]];
    [self.testCases push:@[ @0, @1, @0 ]];
    [self.testCases push:@[ @0, @0, @1 ]];

    for (int i = 0; i < 10; i++)
        [self.testCases push:@[
            @((double)rand() / rand()),
            @((double)rand() / rand()),
            @((double)rand() / rand())
        ]];
}

- (void)testOrigin {

    // With
    Vector *origin = [Vector origin];

    Vector *zero = [Vector vectorWithX:0 Y:0 Z:0];

    // Then
    XCTAssertEqualObjects(origin, zero, @"Origin vector should equal the zero "
                                        @"vector.");
}


- (void)testToSCNVector3 {

    // With
    NSMutableArray *array1 = [NSMutableArray array];

    for (NSArray *vector in self.testCases) {
        SCNVector3 vector3
            = SCNVector3Make(((NSNumber *)vector[0]).doubleValue,
                             ((NSNumber *)vector[1]).doubleValue,
                             ((NSNumber *)vector[2]).doubleValue);
        NSValue *value = [NSValue valueWithSCNVector3:vector3];
        [array1 push:value];
    }

    NSMutableArray *array2 = [self testArray];

    // Then
    for (int i = 0; i < array1.count; i++) {
        SCNVector3 vector1 = ((NSValue *)array1[i]).SCNVector3Value;
        SCNVector3 vector2 = ((Vector *)array2[i]).toSCNVector3;

        XCTAssert(SCNVector3EqualToVector3(vector1, vector2),
                  @"Two Vectors with the same numbers should be equal!");
    }
}

- (void)testIsEqual {

    // With
    NSMutableArray *array1 = [self testArray];
    NSMutableArray *array2 = [self testArray];

    // Then
    for (int i = 0; i < array1.count; i++) {
        XCTAssert([array1[i] isEqual:array2[i]],
                  @"Two Vectors with the same " @"numbers should be equal!");
    }

    for (int i = 1; i < array1.count; i++) {
        XCTAssertFalse([array1[i - 1] isEqual:array2[i]],
                       @"Two Vectors with different numbers should not be "
                       @"equal!");
    }
}

@end
