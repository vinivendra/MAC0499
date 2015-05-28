

#import <XCTest/XCTest.h>

#import "NSArray+Extension.h"


@interface FoundationExtensionTests : XCTestCase

@end


@implementation FoundationExtensionTests

//------------------------------------------------------------------------------
#pragma mark - NSArray
//------------------------------------------------------------------------------

- (void)testNSArrayValid {
    XCTAssertFalse([@[] valid]);
    XCTAssert([@[ @1 ] valid]);
    XCTAssert([@[ [NSNull null] ] valid]);
}

- (void)testNumberAtIndex {
    NSArray *standards = @[ @0, @0, @1, @(M_PI), @(-M_1_PI), @-2 ];
    NSArray *results = @[ @0, @"0", @"1", @(M_PI), @(-M_1_PI), @"-2" ];
    for (int i = 0; i < standards.count; i++) {
        XCTAssertEqualWithAccuracy(((NSNumber *)standards[i]).doubleValue,
                                   [results numberAtIndex:i].doubleValue,
                                   fabs([results numberAtIndex:i].doubleValue
                                        / 10000) + 0.000001);
    }
}

- (void)testFloatAtIndex {
    NSArray *standards = @[ @0, @0, @1, @(M_PI), @(-M_1_PI), @-2 ];
    NSArray *results = @[ @0, @"0", @"1", @(M_PI), @(-M_1_PI), @"-2" ];
    for (int i = 0; i < standards.count; i++) {
        XCTAssertEqualWithAccuracy(((NSNumber *)standards[i]).doubleValue,
                                   [results numberAtIndex:i].doubleValue,
                                   fabs([results floatAtIndex:i]
                                        / 10000) + 0.000001);
    }
}

- (void)testAt {
    NSArray *array = @[@0, @-1, @M_PI, @"foo", @"bar"];
    for (int i = 0; i < array.count; i++) {
        XCTAssertEqualObjects(array[i], [array at:i]);
    }
    XCTAssertNil([array at:array.count]);
    XCTAssertNil([array at:array.count + 1]);
    XCTAssertNil([array at:array.count + 2]);
}

@end
