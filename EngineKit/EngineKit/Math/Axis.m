

#import "Axis.h"

#import "ObjectiveSugar.h"

#import "NSString+Extension.h"


@implementation Axis

//------------------------------------------------------------------------------
#pragma mark - Common Axis constants
//------------------------------------------------------------------------------

+ (instancetype)x {
    return [[self alloc] initWithX:1 Y:0 Z:0];
}

+ (instancetype)y {
    return [[self alloc] initWithX:0 Y:1 Z:0];
}

+ (instancetype)z {
    return [[self alloc] initWithX:0 Y:0 Z:1];
}


//------------------------------------------------------------------------------
#pragma mark - Creating Axis objects
//------------------------------------------------------------------------------

- (instancetype)initWithString:(NSString *)string {
    if ([string isEqualToString:@"x"] || [string isEqualToString:@"X"]) {
        self = [super initWithX:1 Y:0 Z:0];
    } else if ([string isEqualToString:@"y"] || [string isEqualToString:@"Y"]) {
        self = [super initWithX:0 Y:1 Z:0];
    } else if ([string isEqualToString:@"z"] || [string isEqualToString:@"Z"]) {
        self = [super initWithX:0 Y:0 Z:1];
    } else {
        self = [super initWithString:string];
    }

    return self;
}


@end
