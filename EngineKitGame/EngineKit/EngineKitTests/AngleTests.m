

#import <XCTest/XCTest.h>

#import "TestCommons.h"

#import "NSArray+Extension.h"
#import "ObjectiveSugar.h"
#import "Angle.h"

// TODO: Make sure random never generates 0s, remove those safeguards from the
// Axis object

@interface AngleTests : XCTestCase
@property (nonatomic, strong) NSMutableArray *standardNumbers;
@property (nonatomic, strong) NSMutableArray *standardAngles;
@end

@implementation AngleTests

- (void)setUp {
    [super setUp];

    setupRandomSeed();

    self.standardNumbers = [NSMutableArray array];
    [self.standardNumbers push:@0];
    [self.standardNumbers push:@(M_PI)];
    [self.standardNumbers push:@(M_PI_2)];
    [self.standardNumbers push:@(M_PI_4)];
    [self.standardNumbers push:@(M_1_PI)];
    [self.standardNumbers push:@(M_2_PI)];
    [self.standardNumbers push:@(M_2_SQRTPI)];
    [self.standardNumbers push:@(M_SQRT1_2)];
    [self.standardNumbers push:@(M_SQRT2)];
    [self.standardNumbers push:@(180)];
    [self.standardNumbers push:@(360)];
    [self.standardNumbers push:@(-360)];
    [self.standardNumbers push:@(-30)];
    [self.standardNumbers push:@(60)];
    [self.standardNumbers push:@(90)];
    [self.standardNumbers push:@(-90)];

    for (int i = 0; i < 10; i++) {
        CGFloat f = randomFloat();
        [self.standardNumbers push:@(f)];
    }

    self.standardAngles = [NSMutableArray array];

    for (NSNumber *number in self.standardNumbers) {
        [self.standardAngles push:[Angle angleWithRadians:number.doubleValue]];
    }
}

//------------------------------------------------------------------------------
#pragma mark - Basis
//------------------------------------------------------------------------------

- (void)testAngleWithRadiansAndEquals {
    for (int i = 0; i < self.standardNumbers.count; i++) {
        // Bijection
        NSNumber *number = self.standardNumbers[i];
        NSNumber *nextNumber = [self.standardNumbers
            numberAtIndex:(i + 1) % self.standardNumbers.count];

        Angle *angle1 = [Angle angleWithRadians:number.doubleValue];

        Angle *angle2 = [Angle angleWithRadians:number.doubleValue];

        Angle *angle3 = [Angle angleWithRadians:nextNumber.doubleValue];

        XCTAssert([angle1 isEqual:angle2]);
        XCTAssertEqualObjects(angle1, angle2);

        XCTAssertFalse([angle1 isEqual:angle3]);
        XCTAssertNotEqualObjects(angle1, angle3);
    }
}


//------------------------------------------------------------------------------
#pragma mark - Creation
//------------------------------------------------------------------------------

- (void)testToRadians {
    for (int i = 0; i < self.standardNumbers.count; i++) {
        // Gold standard
        CGFloat standard = [self.standardNumbers floatAtIndex:i];

        // Actual result
        CGFloat result = ((Angle *)self.standardAngles[i]).toRadians;

        // Comparison
        XCTAssertEqualWithAccuracy(result,
                                   standard,
                                   fabs(standard / 10000) + 0.000001);
    }
}

- (void)testToDegrees {
    for (int i = 0; i < self.standardNumbers.count; i++) {
        // Gold standard
        CGFloat standard = [self.standardNumbers floatAtIndex:i] / M_PI * 180;

        // Actual result
        CGFloat result = ((Angle *)self.standardAngles[i]).toDegrees;

        // Comparison
        XCTAssertEqualWithAccuracy(result,
                                   standard,
                                   fabs(standard / 10000) + 0.000001);
    }
}

- (void)testAngleWithDegrees {
    for (int i = 0; i < self.standardNumbers.count; i++) {
        // Gold standard
        CGFloat standard = ((Angle *)self.standardAngles[i]).toRadians;

        // Actual result
        CGFloat result =
            [Angle angleWithDegrees:[self.standardNumbers floatAtIndex:i] / M_PI
                                    * 180]
                .toRadians;

        // Comparison
        XCTAssertEqualWithAccuracy(result,
                                   standard,
                                   fabs(standard / 10000) + 0.000001);
    }
}

- (void)testAngleWithPiTimes {
    for (int i = 0; i < self.standardNumbers.count; i++) {
        // Gold standard
        CGFloat standard = ((Angle *)self.standardAngles[i]).toRadians;

        // Actual result
        CGFloat result =
            [Angle
                angleWithPiTimes:[self.standardNumbers floatAtIndex:i] / M_PI]
                .toRadians;

        // Comparison
        XCTAssertEqualWithAccuracy(result,
                                   standard,
                                   fabs(standard / 10000) + 0.000001);
    }
}

- (void)testAngleWithObject {
    for (int i = 0; i < self.standardNumbers.count; i++) {
        // Gold standard
        CGFloat standard = ((Angle *)self.standardAngles[i]).toRadians;

        // Actual result
        NSString *string = [NSString
            stringWithFormat:@"%lf", [self.standardNumbers floatAtIndex:i]];
        CGFloat result1 = [Angle angleWithObject:string].toRadians;
        CGFloat result2 =
            [Angle angleWithObject:[self.standardNumbers numberAtIndex:i]]
                .toRadians;

        // Comparison
        XCTAssertEqualWithAccuracy(result1,
                                   standard,
                                   fabs(standard / 10000) + 0.000001);
        XCTAssertEqualWithAccuracy(result2,
                                   standard,
                                   fabs(standard / 10000) + 0.000001);
    }
}

- (void)testInitWithDegrees {
    for (int i = 0; i < self.standardNumbers.count; i++) {
        // Gold standard
        CGFloat standard = ((Angle *)self.standardAngles[i]).toRadians;

        // Actual result
        CGFloat result =
            [[Angle alloc] initWithDegrees:[self.standardNumbers floatAtIndex:i]
                                           / M_PI * 180]
                .toRadians;

        // Comparison
        XCTAssertEqualWithAccuracy(result,
                                   standard,
                                   fabs(standard / 10000) + 0.000001);
    }
}

- (void)testInitWithRadians {
    for (int i = 0; i < self.standardNumbers.count; i++) {
        // Gold standard
        CGFloat standard = ((Angle *)self.standardAngles[i]).toRadians;

        // Actual result
        CGFloat result =
            [[Angle alloc]
                initWithRadians:[self.standardNumbers floatAtIndex:i]]
                .toRadians;

        // Comparison
        XCTAssertEqualWithAccuracy(result,
                                   standard,
                                   fabs(standard / 10000) + 0.000001);
    }
}

- (void)testInitWithObject {
    for (int i = 0; i < self.standardNumbers.count; i++) {
        // Gold standard
        CGFloat standard = ((Angle *)self.standardAngles[i]).toRadians;

        // Actual result
        NSString *string = [NSString
            stringWithFormat:@"%lf",
                             ((NSNumber *)self.standardNumbers[i]).doubleValue];
        CGFloat result1 = [[Angle alloc] initWithObject:string].toRadians;
        CGFloat result2 =
            [[Angle alloc]
                initWithObject:[self.standardNumbers numberAtIndex:i]]
                .toRadians;

        // Comparison
        XCTAssertEqualWithAccuracy(result1,
                                   standard,
                                   fabs(standard / 10000) + 0.000001);
        XCTAssertEqualWithAccuracy(result2,
                                   standard,
                                   fabs(standard / 10000) + 0.000001);
    }
}

@end
