

#import <XCTest/XCTest.h>

#import "NSArray+Extension.h"
#import "NSDictionary+Extension.h"


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

- (void)testNSArrayNumberAtIndex {
    NSArray *standards = @[ @0, @0, @1, @(M_PI), @(-M_1_PI), @-2 ];
    NSArray *results = @[ @0, @"0", @"1", @(M_PI), @(-M_1_PI), @"-2" ];
    for (int i = 0; i < standards.count; i++) {
        XCTAssertEqualWithAccuracy(((NSNumber *)standards[i]).doubleValue,
                                   [results numberAtIndex:i].doubleValue,
                                   fabs([results numberAtIndex:i].doubleValue
                                        / 10000) + 0.000001);
    }
}

- (void)testNSArrayFloatAtIndex {
    NSArray *standards = @[ @0, @0, @1, @(M_PI), @(-M_1_PI), @-2 ];
    NSArray *results = @[ @0, @"0", @"1", @(M_PI), @(-M_1_PI), @"-2" ];
    for (int i = 0; i < standards.count; i++) {
        XCTAssertEqualWithAccuracy(((NSNumber *)standards[i]).doubleValue,
                                   [results floatAtIndex:i],
                                   fabs([results floatAtIndex:i] / 10000)
                                       + 0.000001);
    }
}

- (void)testNSArrayAt {
    NSArray *array = @[ @0, @-1, @M_PI, @"foo", @"bar" ];
    for (int i = 0; i < array.count; i++) {
        XCTAssertEqualObjects(array[i], [array at:i]);
    }
    XCTAssertNil([array at:array.count]);
    XCTAssertNil([array at:array.count + 1]);
    XCTAssertNil([array at:array.count + 2]);
}

//------------------------------------------------------------------------------
#pragma mark - NSArray
//------------------------------------------------------------------------------

- (void)testNSDictionaryNumberForKey {
    NSDictionary *standards = @{
        @"0" : @0,
        @"1" : @0,
        @"2" : @1,
        @"3" : @(M_PI),
        @"4" : @(-M_1_PI),
        @"5" : @-2
    };
    NSDictionary *results = @{
        @"0" : @0,
        @"1" : @"0",
        @"2" : @"1",
        @"3" : @(M_PI),
        @"4" : @(-M_1_PI),
        @"5" : @"-2"
    };
    NSString *key;
    NSEnumerator *enumerator = results.keyEnumerator;
    while ((key = enumerator.nextObject)) {
        double standard = ((NSNumber *)standards[key]).doubleValue;
        double result = [results numberForKey:key].doubleValue;
        XCTAssertEqualWithAccuracy(standard,
                                   result,
                                   fabs(result / 10000) + 0.000001);
    }
}

- (void)testNSDictionaryFloatForKey {
    NSDictionary *standards = @{
                                @"0" : @0,
                                @"1" : @0,
                                @"2" : @1,
                                @"3" : @(M_PI),
                                @"4" : @(-M_1_PI),
                                @"5" : @-2
                                };
    NSDictionary *results = @{
                              @"0" : @0,
                              @"1" : @"0",
                              @"2" : @"1",
                              @"3" : @(M_PI),
                              @"4" : @(-M_1_PI),
                              @"5" : @"-2"
                              };
    NSString *key;
    NSEnumerator *enumerator = results.keyEnumerator;
    while ((key = enumerator.nextObject)) {
        double standard = ((NSNumber *)standards[key]).doubleValue;
        double result = [results floatForKey:key];
        XCTAssertEqualWithAccuracy(standard,
                                   result,
                                   fabs(result / 10000) + 0.000001);
    }
}

- (void)testNSDictionaryFloatForStringKey {
    NSDictionary *standards = @{
                                @"a" : @0,
                                @"b" : @0,
                                @"CcC" : @1,
                                @"blah" : @(M_PI),
                                @"Foo" : @(-M_1_PI),
                                @"BAR" : @-2
                                };
    NSDictionary *results = @{
                              @"a" : @0,
                              @"B" : @"0",
                              @"CCC" : @"1",
                              @"Blah" : @(M_PI),
                              @"Foo" : @(-M_1_PI),
                              @"bar" : @"-2"
                              };
    NSString *key;
    NSEnumerator *enumerator = standards.keyEnumerator;
    while ((key = enumerator.nextObject)) {
        double standard = ((NSNumber *)standards[key]).doubleValue;
        double result = [results floatForStringKey:key];
        XCTAssertEqualWithAccuracy(standard,
                                   result,
                                   fabs(result / 10000) + 0.000001);
    }
}

@end

