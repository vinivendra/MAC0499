

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
            push:[Position
                     positionWithX:((NSNumber *)position[0]).doubleValue
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

        Position *position1 =
            [Position positionWithX:((NSNumber *)positionArray[0]).doubleValue
                                  Y:((NSNumber *)positionArray[1]).doubleValue
                                  Z:((NSNumber *)positionArray[2]).doubleValue];

        Position *position2 =
            [Position positionWithX:((NSNumber *)positionArray[0]).doubleValue
                                  Y:((NSNumber *)positionArray[1]).doubleValue
                                  Z:((NSNumber *)positionArray[2]).doubleValue];

        Position *position3 = [Position
            positionWithX:((NSNumber *)nextPositionArray[0]).doubleValue
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
#pragma mark - Creation
//------------------------------------------------------------------------------

- (void)testPosition {
    XCTAssertNotNil([Position position]);
}

- (void)testOrigin {

    // Gold standard
    Position *standard = [Position positionWithX:0 Y:0 Z:0];

    // Actual result
    Position *result = [Position origin];

    // Comparison
    XCTAssertEqualObjects(standard, result);
}


@end
