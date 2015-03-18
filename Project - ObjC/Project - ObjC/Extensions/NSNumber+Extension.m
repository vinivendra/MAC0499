

#import "NSNumber+Extension.h"


@implementation NSNumber (Extension)

+ (NSNumber *)numberWithString:(NSString *)string {
    return @([string doubleValue]);
}

@end
