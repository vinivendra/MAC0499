

#import <XCTest/XCTest.h>


@interface PositionTests : XCTestCase
@end


@implementation PositionTests

- (void)testInitWithVector {
    // With
    NSArray *expectedVectors = @[
        [NSValue valueWithSCNVector3:SCNVector3Make(0.2, 0.3, 0.4)],
        [NSValue valueWithSCNVector3:SCNVector3Make(0.0, 0.0, 0.0)],
        [NSValue valueWithSCNVector3:SCNVector3Make(-0.2, 1230.3, 1.3)]
    ];

    // When
    NSArray *resultVectors = [expectedVectors map:^id(id object) {
        SCNVector3 vector = ((NSValue *)object).SCNVector3Value;
        return [Vector vectorWithVector:vector];
    }];

    NSArray *resultPositions = [resultVectors map:^id(id object) {
        Vector *vector = (Vector *)object;
        return [Position positionWithVector:vector];
    }];
    
    // Then
    for (int i = 0; i < resultVectors.count; i++) {
        Vector *resultVector = resultVectors[i];
        Position *resultPosition = resultPositions[i];
        XCTAssert([resultPosition isEqual:resultVector]);
    }
}

@end
