

#import <XCTest/XCTest.h>

#import "TestCommons.h"

#import "NSDictionary+Extension.h"
#import "ObjectiveSugar.h"
#import "Rotation.h"


@interface RotationTests : XCTestCase
@property (nonatomic, strong) NSMutableArray *standardArrays;
@property (nonatomic, strong) NSMutableArray *standardRotations;
@end

@implementation RotationTests

- (void)setUp {
    [super setUp];

    setupRandomSeed();

    self.standardArrays = [NSMutableArray array];
    [self.standardArrays push:@[ @1, @0, @0, @0 ]];
    [self.standardArrays push:@[ @0, @-1, @0, @0 ]];
    [self.standardArrays push:@[ @0, @0, @2, @0 ]];
    [self.standardArrays push:@[ @1, @0, @0, @1 ]];
    [self.standardArrays push:@[ @0, @-1, @0, @(M_PI) ]];
    [self.standardArrays push:@[ @0, @0, @2, @(M_1_PI) ]];

    for (int i = 0; i < 10; i++)
        [self.standardArrays
            push:@[ @(randomFloat()), @(randomFloat()), @(randomFloat()) ]];

    self.standardRotations = [NSMutableArray array];

    for (NSArray *rotation in self.standardArrays) {
        [self.standardRotations
            push:[[Rotation alloc]
                     initWithX:((NSNumber *)rotation[0]).doubleValue
                             Y:((NSNumber *)rotation[1]).doubleValue
                             Z:((NSNumber *)rotation[2]).doubleValue
                         Angle:((NSNumber *)rotation[3]).doubleValue]];
    }
}

@end
