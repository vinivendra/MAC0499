

#import <XCTest/XCTest.h>


@interface AxisTest : XCTestCase
@end


@implementation AxisTest

- (void)testInitWithString {
    // With
    NSArray *testStrings = @[
        @"[0.2 0.3 0.4]",
        @"[1000, 0.3, 0.0]",
        @"{1000. 0.3. 0.0, 400}",
        @"X",
        @"y",
        @"z"
    ];

    SCNVector3 expectedVectors[] = {SCNVector3Make(0.2, 0.3, 0.4),
                                    SCNVector3Make(1000, 0.3, 0.0),
                                    SCNVector3Make(1000, 0.3, 0.0),
                                    SCNVector3Make(1, 0, 0),
                                    SCNVector3Make(0, 1, 0),
                                    SCNVector3Make(0, 0, 1)};

    // When
    NSArray *resultAxes = [testStrings map:^id(NSString *string) {
        return [[Axis alloc] initWithString:string];
    }];

    // Then
    for (int i = 0; i < resultAxes.count; i++) {
        XCTAssert([resultAxes[i] isEqualToVector:expectedVectors[i]]);
    }
}

@end
