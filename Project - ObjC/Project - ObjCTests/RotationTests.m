

#import <XCTest/XCTest.h>


@interface RotationTests : XCTestCase
@end


@implementation RotationTests

- (void)testInitWithAxisAngle {
    
    // With
    Axis *axis = [Axis x];
    Angle *angle = [Angle angleWithRadians:0.4];
    
    SCNVector4 expectedVector = SCNVector4Make(1, 0, 0, 0.4);
    
    // When
    Rotation *rotation = [Rotation rotationWithAxis:axis angle:angle];
    
    // Then
    XCTAssert(SCNVector4EqualToVector4([rotation toSCNVector], expectedVector));
}

- (void)testInitWithArray {
    
    // With
    NSArray *array = @[@0.2, @0.3, @0.4, @1.0];
    
    SCNVector4 expectedVector = SCNVector4Make(0.2, 0.3, 0.4, 1.0);
    
    // When
    Rotation *rotation = [Rotation rotationWithArray:array];
    
    // Then
    XCTAssert(SCNVector4EqualToVector4([rotation toSCNVector], expectedVector));
}


@end
