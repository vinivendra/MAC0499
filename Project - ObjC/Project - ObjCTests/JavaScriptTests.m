
// TODO: JavaScript load()
// TODO: JavaScript update()


#import <XCTest/XCTest.h>
#import <JavaScriptCore/JavaScriptCore.h>

#import "JavaScript.h"


@interface JavaScriptTests : XCTestCase
@end


@implementation JavaScriptTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {

    [super tearDown];
}

//
- (void)testSharedInstances {
    XCTAssertNotNil( [JSContext shared] );
    XCTAssertNotNil( [JavaScript shared] );
}

@end
