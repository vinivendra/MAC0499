

#import <XCTest/XCTest.h>

#import "TestCommons.h"

#import "NSArray+Extension.h"
#import "NSDictionary+Extension.h"
#import "NSNumber+Extension.h"
#import "NSString+Extension.h"
#import "UIColor+Extension.h"


@interface FoundationExtensionTests : XCTestCase

@end


@implementation FoundationExtensionTests

//------------------------------------------------------------------------------
#pragma mark - NSNumber
//------------------------------------------------------------------------------

- (void)testNSNumberNumberWithString {
    // Gold standard
    NSNumber *standard = @(0);

    // Actual result
    NSNumber *result = [NSNumber numberWithString:@"0"];

    // Comparison
    XCTAssertEqualObjects(standard, result);

    for (int i = 0; i < 10; i++) {
        CGFloat random = randomFloat();
        NSString *string = [NSString stringWithFormat:@"%lf", random];

        // Gold standard
        NSNumber *standardNumber = @(random);
        CGFloat standard = standardNumber.doubleValue;

        // Actual result
        NSNumber *resultNumber = [NSNumber numberWithString:string];
        CGFloat result = resultNumber.doubleValue;

        // Comparison
        XCTAssertEqualWithAccuracy(standard,
                                   result,
                                   fabs(result / 100000) + 0.000001);
    }
}

- (void)testNSNumberNumberWithObject {
    // Gold standard
    NSNumber *standard = @(0);

    // Actual result
    NSNumber *result1 = [NSNumber numberWithObject:@"0"];
    NSNumber *result2 = [NSNumber numberWithObject:@(0)];
    NSNumber *result3 = [NSNumber numberWithObject:nil];
    NSNumber *result4 = [NSNumber numberWithObject:@[]];

    // Comparison
    XCTAssertEqualObjects(standard, result1);
    XCTAssertEqualObjects(standard, result2);
    XCTAssertEqualObjects(standard, result3);
    XCTAssertEqualObjects(standard, result4);

    for (int i = 0; i < 10; i++) {
        CGFloat random = randomFloat();
        NSString *string = [NSString stringWithFormat:@"%lf", random];
        NSNumber *number = @(random);

        // Gold standard
        NSNumber *standardNumber = @(random);
        CGFloat standard = standardNumber.doubleValue;

        // Actual result
        CGFloat result1 = [NSNumber numberWithObject:string].doubleValue;
        CGFloat result2 = [NSNumber numberWithObject:number].doubleValue;

        // Comparison
        XCTAssertEqualWithAccuracy(standard,
                                   result1,
                                   fabs(result1 / 100000) + 0.000001);
        XCTAssertEqualWithAccuracy(standard,
                                   result2,
                                   fabs(result2 / 100000) + 0.000001);
    }
}

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
    XCTAssertEqualObjects([results numberAtIndex:standards.count], @(0));
    XCTAssertEqualObjects([results numberAtIndex:standards.count + 1], @(0));
    XCTAssertEqualObjects([results numberAtIndex:standards.count + 2], @(0));
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
    XCTAssertEqual([results floatAtIndex:standards.count], 0.0);
    XCTAssertEqual([results floatAtIndex:standards.count + 1], 0.0);
    XCTAssertEqual([results floatAtIndex:standards.count + 2], 0.0);
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

    XCTAssertEqualObjects([results numberForKey:@"invalidTestKey"], @0);
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
    XCTAssertEqual([results floatForKey:@"invalidTestKey"], 0.0);
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
    XCTAssertEqual([results floatForStringKey:@"invalidTestKey"], 0.0);
}

//------------------------------------------------------------------------------
#pragma mark - NSString
//------------------------------------------------------------------------------

- (void)testNSStringValid {
    XCTAssertFalse([@"" valid]);
    XCTAssertFalse([@" " valid]);
    XCTAssertFalse([@"\n  \n" valid]);
    XCTAssertFalse([@"\t \n \n \t" valid]);

    BOOL result = [[NSString stringWithFormat:@"%lf", randomFloat()] valid];
    XCTAssertTrue(result);
}

- (void)testNSStringNumberValue {
    // Gold standard
    NSNumber *standard = @(0);

    // Actual result
    NSNumber *result = [@"0" numberValue];

    // Comparison
    XCTAssertEqualObjects(standard, result);

    for (int i = 0; i < 10; i++) {
        CGFloat random = randomFloat();
        NSString *string = [NSString stringWithFormat:@"%lf", random];

        // Gold standard
        NSNumber *standardNumber = @(random);
        CGFloat standard = standardNumber.doubleValue;

        // Actual result
        NSNumber *resultNumber = [string numberValue];
        CGFloat result = resultNumber.doubleValue;

        // Comparison
        XCTAssertEqualWithAccuracy(standard,
                                   result,
                                   fabs(result / 100000) + 0.000001);
    }
}

- (void)testNSStringIndentation {
    NSInteger result1 = [@"" indentation];
    NSInteger result2 = [@" " indentation];
    NSInteger result3 = [@"  " indentation];
    NSInteger result4 = [@"   " indentation];

    XCTAssertLessThan(result1, result2);
    XCTAssertLessThan(result2, result3);
    XCTAssertLessThan(result3, result4);

    XCTAssertEqual(result1, result1);
    XCTAssertEqual(result2, result2);
    XCTAssertEqual(result3, result3);
    XCTAssertEqual(result4, result4);
}

//------------------------------------------------------------------------------
#pragma mark - UIColor
//------------------------------------------------------------------------------

- (void)testColorWithName {
    NSArray *names = @[
        @"black",
        @"dark gray",
        @"darkGray",
        @"gray",
        @"light gray",
        @"lightGray",
        @"white",
        @"red",
        @"green",
        @"blue",
        @"cyan",
        @"yellow",
        @"magenta",
        @"orange",
        @"purple",
        @"brown",
        @"clear"
    ];

    for (NSString *name in names) {
        UIColor *color = [UIColor colorWithName:name];

        XCTAssertNotNil(color);
    }
}

- (void)testColorWithCArray {
    CGFloat result[4];

    // Gold Standard
    CGFloat array[] = {0.0, 0.0, 0.0, 0.0};

    // Actual Result
    UIColor *color = [UIColor colorWithCArray:array];
    [color getRed:&result[0] green:&result[1] blue:&result[2] alpha:&result[3]];

    // Comparison
    XCTAssertEqual(result[0], array[0]);
    XCTAssertEqual(result[1], array[1]);
    XCTAssertEqual(result[2], array[2]);
    XCTAssertEqual(result[3], array[3]);

    for (int i = 0; i < 10; i++) {
        // Gold Standard
        CGFloat array[] = {(CGFloat)rand() / RAND_MAX,
                           (CGFloat)rand() / RAND_MAX,
                           (CGFloat)rand() / RAND_MAX,
                           (CGFloat)rand() / RAND_MAX};

        // Actual Result
        UIColor *color = [UIColor colorWithCArray:array];
        [color getRed:&result[0]
                green:&result[1]
                 blue:&result[2]
                alpha:&result[3]];

        // Comparison
        XCTAssertEqual(result[0], array[0]);
        XCTAssertEqual(result[1], array[1]);
        XCTAssertEqual(result[2], array[2]);
        XCTAssertEqual(result[3], array[3]);
    }
}

- (void)testColorWithArray {
    CGFloat result[4];

    // Gold Standard
    NSArray *array = @[ @0.0, @0.0, @0.0, @0.0 ];

    // Actual Result
    UIColor *color = [UIColor colorWithArray:array];
    [color getRed:&result[0] green:&result[1] blue:&result[2] alpha:&result[3]];

    // Comparison
    XCTAssertEqual(result[0], [array floatAtIndex:0]);
    XCTAssertEqual(result[1], [array floatAtIndex:1]);
    XCTAssertEqual(result[2], [array floatAtIndex:2]);
    XCTAssertEqual(result[3], [array floatAtIndex:3]);

    for (int i = 0; i < 10; i++) {
        // Gold Standard
        NSArray *array = @[
            @((CGFloat)rand() / RAND_MAX),
            @((CGFloat)rand() / RAND_MAX),
            @((CGFloat)rand() / RAND_MAX),
            @((CGFloat)rand() / RAND_MAX)
        ];

        // Actual Result
        UIColor *color = [UIColor colorWithArray:array];
        [color getRed:&result[0]
                green:&result[1]
                 blue:&result[2]
                alpha:&result[3]];

        // Comparison
        XCTAssertEqual(result[0], [array floatAtIndex:0]);
        XCTAssertEqual(result[1], [array floatAtIndex:1]);
        XCTAssertEqual(result[2], [array floatAtIndex:2]);
        XCTAssertEqual(result[3], [array floatAtIndex:3]);
    }
}

- (void)testUIColorTimes {
    CGFloat result[4];

    // Gold Standard
    CGFloat array[] = {0.0, 0.0, 0.0, 0.0};

    // Actual Result
    UIColor *color = [UIColor colorWithCArray:array];
    color = [color times:randomFloat()];
    [color getRed:&result[0] green:&result[1] blue:&result[2] alpha:&result[3]];

    // Comparison
    XCTAssertEqual(result[0], array[0]);
    XCTAssertEqual(result[1], array[1]);
    XCTAssertEqual(result[2], array[2]);
    XCTAssertEqual(result[3], array[3]);

    for (int i = 0; i < 10; i++) {
        // Gold Standard
        CGFloat ratio = randomFloat();
        CGFloat array[] = {(CGFloat)rand() / RAND_MAX,
                           (CGFloat)rand() / RAND_MAX,
                           (CGFloat)rand() / RAND_MAX,
                           (CGFloat)rand() / RAND_MAX};

        // Actual Result
        UIColor *color = [UIColor colorWithCArray:array];
        color = [color times:ratio];
        [color getRed:&result[0]
                green:&result[1]
                 blue:&result[2]
                alpha:&result[3]];

        // Comparison
        XCTAssertEqual(result[0], LIMIT(0, array[0] * ratio, 1));
        XCTAssertEqual(result[1], LIMIT(0, array[1] * ratio, 1));
        XCTAssertEqual(result[2], LIMIT(0, array[2] * ratio, 1));
        XCTAssertEqual(result[3], array[3]);
    }
}

@end
