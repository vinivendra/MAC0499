
// TODO: Create initializers for array, dict, etc

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>


@interface ColorTests : XCTestCase

@end


static NSArray *testColors;


@implementation ColorTests

- (void)setUp {
    testColors = @[
        [Color colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0],
        [Color colorWithRed:0.4 green:0.0 blue:1.0 alpha:0.0],
        [Color colorWithRed:0.2 green:0.3 blue:0.2 alpha:0.4]
    ];
}

- (void)testColorWithCArray {

    // With
    NSArray *expectedColors = testColors;
    
    CGFloat testColors[3][4]
        = {{0.3, 0.3, 0.3, 1.0}, {0.4, 0.0, 1.0, 0.0}, {0.2, 0.3, 0.2, 0.4}};
    
    // When
    NSArray *resultColors = @[
        [Color colorWithCArray:testColors[0]],
        [Color colorWithCArray:testColors[1]],
        [Color colorWithCArray:testColors[2]]
    ];

    // Then
    for (int i = 0; i < expectedColors.count; i++) {
        XCTAssertEqualObjects(expectedColors[i], resultColors[i]);
    }
}

- (void)testColorWithArray {

    // With
    NSArray *testColors = @[
        @[ @0.5 ],
        @[ @0.5, @0.8 ],
        @[ @0.2, @0.3, @0.4 ],
        @[ @0.2, @0.3, @0.4, @0.5 ]
    ];

    NSArray *expectedColors = @[
        [Color colorWithWhite:0.5 alpha:1.0],
        [Color colorWithWhite:0.5 alpha:0.8],
        [Color colorWithRed:0.2 green:0.3 blue:0.4 alpha:1.0],
        [Color colorWithRed:0.2 green:0.3 blue:0.4 alpha:0.5]
    ];

    // When
    NSArray *resultColors = @[
        [Color colorWithArray:testColors[0]],
        [Color colorWithArray:testColors[1]],
        [Color colorWithArray:testColors[2]],
        [Color colorWithArray:testColors[3]]
    ];

    // Then
    for (int i = 0; i < expectedColors.count; i++) {
        XCTAssertEqualObjects(expectedColors[i], resultColors[i]);
    }
}

- (void)testColorTimes {

    // With
    NSArray *expectedColors = @[
        [Color colorWithRed:0.3 * 0.1 green:0.3 * 0.1 blue:0.3 * 0.1 alpha:1.0],
        [Color colorWithRed:0.4 * 1.2 green:0.0 * 1.2 blue:1.0 * 1.2 alpha:0.0],
        [Color colorWithRed:-0.2 green:-0.3 blue:-0.2 alpha:0.4]
    ];

    // When
    NSArray *resultColors = @[
        [((UIColor *)testColors[0])times:0.1],
        [((UIColor *)testColors[1])times:1.2],
        [((UIColor *)testColors[2])times:-1.0]
    ];

    // Then
    for (int i = 0; i < testColors.count; i++) {
        XCTAssertEqualObjects(expectedColors[i], resultColors[i]);
    }
}

@end
