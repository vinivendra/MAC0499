

#import <XCTest/XCTest.h>


@interface VectorTests : XCTestCase
@end


@implementation VectorTests

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
        return [[Vector alloc] initWithSCNVector:vector];
    }];

    // Then
    for (int i = 0; i < resultVectors.count; i++) {
        SCNVector3 expectedVector
            = ((NSValue *)expectedVectors[i]).SCNVector3Value;
        Vector *resultVector = resultVectors[i];
        XCTAssert([resultVector isEqualToVector:expectedVector]);
    }
}

- (void)testInitWithArray {
    // With
    NSArray *expectedVectors = @[
        [NSValue valueWithSCNVector3:SCNVector3Make(0.2, 0.3, 0.4)],
        [NSValue valueWithSCNVector3:SCNVector3Make(0.0, 0.0, 0.0)],
        [NSValue valueWithSCNVector3:SCNVector3Make(-0.2, 1230.3, 1.3)]
    ];

    NSArray *testVectors = @[
        @[ @0.2, @0.3, @0.4 ],
        @[ @0.0, @0.0, @0.0 ],
        @[ @(-0.2), @1230.3, @1.3 ]
        ];
    
    // When
    NSArray *resultVectors = [testVectors map:^id(id object) {
        NSArray *array = (NSArray *)object;
        return [[Vector alloc] initWithArray:array];
    }];

    // Then
    for (int i = 0; i < resultVectors.count; i++) {
        SCNVector3 expectedVector
            = ((NSValue *)expectedVectors[i]).SCNVector3Value;
        Vector *resultVector = resultVectors[i];
        XCTAssert([resultVector isEqualToVector:expectedVector]);
    }
}

- (void)testInitWithObject {
    // With
    NSArray *expectedVectors = @[
                                 [NSValue valueWithSCNVector3:SCNVector3Make(0.2, 0.3, 0.4)],
                                 [NSValue valueWithSCNVector3:SCNVector3Make(0.0, 0.0, 0.0)],
                                 [NSValue valueWithSCNVector3:SCNVector3Make(-0.2, 1230.3, 1.3)]
                                 ];
    
    NSArray *testObjects = @[
                             @[ @0.2, @0.3, @0.4 ],
                             [[Vector alloc] initWithX:0 Y:0 Z:0],
                             [NSValue valueWithSCNVector3:SCNVector3Make(-0.2, 1230.3, 1.3)]
                             ];
    
    // When
    NSArray *resultVectors = [testObjects map:^id(id object) {
        return [[Vector alloc] initWithObject:object];
    }];
    
    // Then
    for (int i = 0; i < resultVectors.count; i++) {
        SCNVector3 expectedVector
        = ((NSValue *)expectedVectors[i]).SCNVector3Value;
        Vector *resultVector = resultVectors[i];
        XCTAssert([resultVector isEqualToVector:expectedVector]);
    }
}



@end
