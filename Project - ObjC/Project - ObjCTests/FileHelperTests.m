

#import <XCTest/XCTest.h>
#import "FileHelper.h"


@interface FileHelperTests : XCTestCase
@end


@implementation FileHelperTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {

    [super tearDown];
}

- (void)testPath {
    XCTAssertNotNil( [FileHelper pathForFilename:_testFileName] );
}

- (void)testOpenTextFile {
    XCTAssertEqualObjects( [FileHelper openTextFile:_testFileName], @"console.log(\"test\");" );
}

@end
