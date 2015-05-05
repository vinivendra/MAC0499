

#import "Axis.h"

#import "ObjectiveSugar.h"

#import "NSString+Extension.h"


@implementation Axis

- (instancetype)initWithString:(NSString *)string {

    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSCharacterSet *numbers =
        [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];

    NSMutableArray *array = [NSMutableArray array];

    BOOL done = NO;

    until(done) {
        NSString *number;

        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];

        done = ![scanner scanCharactersFromSet:numbers intoString:&number];

        if (number)
            [array push:number.numberValue];
    }

    if (array.count >= 3) {
        self = [super initWithArray:array];
    } else {
        if ([string containsString:@"x"] || [string containsString:@"X"]) {
            self = [super initWithX:1 Y:0 Z:0];
        } else if ([string containsString:@"y"]
                   || [string containsString:@"Y"]) {
            self = [super initWithX:0 Y:1 Z:0];
        } else if ([string containsString:@"z"]
                   || [string containsString:@"Z"]) {
            self = [super initWithX:0 Y:0 Z:1];
        }
        else {
            assert(false);
        }
    }

    return self;
}

+ (instancetype)x {
    return [[self alloc] initWithX:1 Y:0 Z:0];
}

+ (instancetype)y {
    return [[self alloc] initWithX:0 Y:1 Z:0];
}

+ (instancetype)z {
    return [[self alloc] initWithX:0 Y:0 Z:1];
}

@end
