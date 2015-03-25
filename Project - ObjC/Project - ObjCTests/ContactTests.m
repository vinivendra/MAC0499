
#import <XCTest/XCTest.h>
#import "Contact.h"


@interface ContactTests : XCTestCase
@end


@implementation ContactTests

- (void)testInit {
    Item *firstItem = [Item new];
    Item *secondItem = [Item new];
    JSValue *action = [JSValue valueWithBool:YES inContext:[JSContext shared]];

    Contact *contact = [[Contact alloc] initWithFirstItem:firstItem
                                               secondItem:secondItem
                                                   action:action];

    XCTAssert(contact);
    XCTAssert([contact.firstItem isEqual:firstItem]);
    XCTAssert([contact.secondItem isEqual:secondItem]);
    XCTAssert([contact.action isEqual:action]);
}

- (void)testInitWithArray {

    Item *firstItem = [Item new];
    Item *secondItem = [Item new];
    JSValue *action = [JSValue valueWithBool:YES inContext:[JSContext shared]];

    Contact *contact =
        [[Contact alloc] initWithArray:@[ action, firstItem, secondItem ]];

    XCTAssert(contact);
    XCTAssert([contact.firstItem isEqual:firstItem]);
    XCTAssert([contact.secondItem isEqual:secondItem]);
    XCTAssert([contact.action isEqual:action]);
}

- (void)testInitWithDictionary {

    Item *firstItem = [Item new];
    Item *secondItem = [Item new];
    JSValue *action = [JSValue valueWithBool:YES inContext:[JSContext shared]];

    Contact *contact = [[Contact alloc] initWithDictionary:@{
        @"contact" : action,
        @"between" : firstItem,
        @"and" : secondItem
    }];

    XCTAssert(contact);
    XCTAssert([contact.firstItem isEqual:firstItem]);
    XCTAssert([contact.secondItem isEqual:secondItem]);
    XCTAssert([contact.action isEqual:action]);
}

- (void)testInitWithObject {

    Item *firstItem = [Item new];
    Item *secondItem = [Item new];
    JSValue *action = [JSValue valueWithBool:YES inContext:[JSContext shared]];

    NSArray *results = @[
        [[Contact alloc] initWithObject:@{
            @"contact" : action,
            @"between" : firstItem,
            @"and" : secondItem
        }],
        [[Contact alloc] initWithObject:@[ action, firstItem, secondItem ]]
    ];

    for (Contact *contact in results) {
        XCTAssert(contact);
        XCTAssert([contact.firstItem isEqual:firstItem]);
        XCTAssert([contact.secondItem isEqual:secondItem]);
        XCTAssert([contact.action isEqual:action]);
    }
}

@end
