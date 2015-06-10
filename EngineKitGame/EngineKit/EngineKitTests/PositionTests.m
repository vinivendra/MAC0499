

#import <XCTest/XCTest.h>

#import "TestCommons.h"

#import "NSDictionary+Extension.h"
#import "ObjectiveSugar.h"
#import "Position.h"


@interface PositionTests : XCTestCase
@property (nonatomic, strong) NSMutableArray *standardArrays;
@property (nonatomic, strong) NSMutableArray *standardPositions;
@end


@implementation PositionTests

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

    self.standardPositions = [NSMutableArray array];

    for (NSArray *position in self.standardArrays) {
        [self.standardPositions
            push:[[Position alloc]
                     initWithX:((NSNumber *)position[0]).doubleValue
                             Y:((NSNumber *)position[1]).doubleValue
                             Z:((NSNumber *)position[2]).doubleValue]];
    }
}

//------------------------------------------------------------------------------
#pragma mark - Basis
//------------------------------------------------------------------------------

- (void)testPositionWithXYZAndEquals {
    for (int i = 0; i < self.standardArrays.count; i++) {
        // Bijection
        NSArray *positionArray = self.standardArrays[i];
        NSArray *nextPositionArray
            = self.standardArrays[(i + 1) % self.standardArrays.count];

        Position *position1 = [[Position alloc]
            initWithX:((NSNumber *)positionArray[0]).doubleValue
                    Y:((NSNumber *)positionArray[1]).doubleValue
                    Z:((NSNumber *)positionArray[2]).doubleValue];

        Position *position2 = [[Position alloc]
            initWithX:((NSNumber *)positionArray[0]).doubleValue
                    Y:((NSNumber *)positionArray[1]).doubleValue
                    Z:((NSNumber *)positionArray[2]).doubleValue];

        Position *position3 = [[Position alloc]
            initWithX:((NSNumber *)nextPositionArray[0]).doubleValue
                    Y:((NSNumber *)nextPositionArray[1]).doubleValue
                    Z:((NSNumber *)nextPositionArray[2]).doubleValue];

        XCTAssert([position1 isEqual:position2]);
        XCTAssert([position1 isEqualToVector:position2.toSCNVector3]);
        XCTAssertEqualObjects(position1, position2);

        XCTAssertNotEqualObjects(position1, position3);
        XCTAssertFalse([position1 isEqual:position3]);
        XCTAssertFalse([position1 isEqualToVector:position3.toSCNVector3]);
    }
}


//------------------------------------------------------------------------------
#pragma mark - Extracting data
//------------------------------------------------------------------------------

- (void)testToSCNVector4 {
    for (int i = 0; i < self.standardArrays.count; i++) {
        // Gold standard
        NSArray *vectorArray = self.standardArrays[i];

        SCNVector4 standard
            = SCNVector4Make(((NSNumber *)vectorArray[0]).doubleValue,
                             ((NSNumber *)vectorArray[1]).doubleValue,
                             ((NSNumber *)vectorArray[2]).doubleValue,
                             0.0);

        // Actual result
        SCNVector4 result = ((Vector *)self.standardPositions[i]).toSCNVector4;

        // Comparison
        XCTAssert(SCNVector4EqualToVector4(standard, result));
    }
}


//------------------------------------------------------------------------------
#pragma mark - Creation
//------------------------------------------------------------------------------

- (void)testOrigin {

    // Gold standard
    Position *standard = [[Position alloc] initWithX:0 Y:0 Z:0];

    // Actual result
    Position *result = [Position origin];

    // Comparison
    XCTAssertEqualObjects(standard, result);
}

- (void)testPositionWithUniformNumbers {
    for (NSArray *array in self.standardArrays) {
        for (NSNumber *number1 in array) {
            // Gold standard
            CGFloat u = number1.doubleValue;
            Position *standard = [[Position alloc] initWithX:u Y:u Z:u];

            // Acutal result
            Position *result =
                [[Position alloc] initWithUniformNumbers:number1.doubleValue];

            // Comparison
            XCTAssertEqualObjects(standard, result);
        }
    }
}

- (void)testPositionWithCGPoint {
    for (NSArray *array in self.standardArrays) {
        // Gold standard
        CGPoint point = CGPointMake(((NSNumber *)array[0]).doubleValue,
                                    ((NSNumber *)array[1]).doubleValue);

        Position *standard =
            [[Position alloc] initWithX:point.x Y:-point.y Z:0];

        // Actual result
        Position *result = [[Position alloc] initWithCGPoint:point];

        // Comparison
        XCTAssertEqualObjects(standard, result);
    }
}

- (void)testPositionWithCIPosition {
    for (int i = 0; i < self.standardArrays.count; i++) {
        // Gold standard
        Position *standard = self.standardPositions[i];

        // Actual result
        NSArray *positionArray = self.standardArrays[i];
        CIVector *ciposition =
            [CIVector vectorWithX:((NSNumber *)positionArray[0]).doubleValue
                                Y:((NSNumber *)positionArray[1]).doubleValue
                                Z:((NSNumber *)positionArray[2]).doubleValue];
        Position *result = [[Position alloc] initWithCIVector:ciposition];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

- (void)testPositionWithSCNVector3 {
    for (int i = 0; i < self.standardPositions.count; i++) {
        // Gold standard
        Position *standard = self.standardPositions[i];

        // Actual result
        SCNVector3 position3 = standard.toSCNVector3;
        Position *result = [[Position alloc] initWithSCNVector3:position3];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

- (void)testPositionWithSCNVector4 {
    for (int i = 0; i < self.standardPositions.count; i++) {
        // Gold standard
        Position *standard = self.standardPositions[i];

        // Actual result
        SCNVector4 position4
            = SCNVector4Make(standard.x, standard.y, standard.z, arc4random());
        Position *result = [[Position alloc] initWithSCNVector4:position4];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

- (void)testPositionWithArray {
    for (int i = 0; i < self.standardPositions.count; i++) {
        // Gold standard
        Position *standard = self.standardPositions[i];

        // Actual result
        NSArray *array = standard.toArray;
        Position *result = [[Position alloc] initWithArray:array];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

- (void)testPositionWithDictionary {
    for (int i = 0; i < self.standardPositions.count; i++) {
        // Gold standard
        Position *standard = self.standardPositions[i];

        // Actual result
        NSDictionary *dictionary = @{
            @"x" : @(standard.x),
            @"y" : @(standard.y),
            @"z" : @(standard.z)
        };
        Position *result = [[Position alloc] initWithDictionary:dictionary];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}

- (void)testPositionWithString {
    for (int i = 0; i < self.standardPositions.count; i++) {
        // Gold standard
        Position *standard = self.standardPositions[i];

        // Actual result
        NSArray *formats =
            @[ @"[%lf, %lf, %lf]", @"vn %lf %lf %lf", @"(%lf %lf %lf)" ];

        NSString *string = [NSString stringWithFormat:formats[i % 3],
                                                      standard.x,
                                                      standard.y,
                                                      standard.z];
        Position *result = [[Position alloc] initWithString:string];

        // Comparison
        XCTAssertEqualWithAccuracy(result.x,
                                   standard.x,
                                   fabs(standard.x / 100) + 0.00001);
        XCTAssertEqualWithAccuracy(result.y,
                                   standard.y,
                                   fabs(standard.y / 100) + 0.00001);
        XCTAssertEqualWithAccuracy(result.z,
                                   standard.z,
                                   fabs(standard.z / 100) + 0.00001);
    }
}

- (void)testPositionWithVector {
    for (int i = 0; i < self.standardPositions.count; i++) {
        // Gold standard
        Position *standard = self.standardPositions[i];

        // Actual result
        Vector *vector = [[Vector alloc] initWithVector:standard];
        Position *result1 = [[Position alloc] initWithVector:vector];
        Position *result2 = [[Position alloc] initWithVector:standard];

        // Comparison
        XCTAssertEqualObjects(result1, standard);
        XCTAssertEqualObjects(result2, standard);
    }
}

- (void)testPositionWithPosition {
    for (int i = 0; i < self.standardPositions.count; i++) {
        // Gold standard
        Position *standard = self.standardPositions[i];

        // Actual result
        Position *result = [[Position alloc] initWithVector:standard];

        // Comparison
        XCTAssertEqualObjects(result, standard);
    }
}


- (void)testPositionWithObject {
    for (int i = 0; i < self.standardPositions.count; i++) {
        // Gold standard
        Position *standard = self.standardPositions[i];

        // Results and comparisons
        Position *result;

        NSDictionary *dictionary = @{
            @"x" : @(standard.x),
            @"y" : @(standard.y),
            @"z" : @(standard.z)
        };
        result = [[Position alloc] initWithObject:dictionary];
        XCTAssertEqualObjects(result, standard);

        NSString *string = [NSString stringWithFormat:@"%lf %lf %lf",
                                                      standard.x,
                                                      standard.y,
                                                      standard.z];
        result = [[Position alloc] initWithObject:string];
        XCTAssertEqualWithAccuracy(result.x,
                                   standard.x,
                                   fabs(standard.x / 100) + 0.00001);
        XCTAssertEqualWithAccuracy(result.y,
                                   standard.y,
                                   fabs(standard.y / 100) + 0.00001);
        XCTAssertEqualWithAccuracy(result.z,
                                   standard.z,
                                   fabs(standard.z / 100) + 0.00001);

        result = [[Position alloc] initWithObject:standard];
        XCTAssertEqualObjects(result, standard);

        result = [[Position alloc] initWithObject:standard.toArray];
        XCTAssertEqualObjects(result, standard);

        result = [[Position alloc] initWithObject:@(standard.x)];
        standard = [[Position alloc] initWithUniformNumbers:standard.x];
        XCTAssertEqualObjects(result, standard);
    }
}


@end
