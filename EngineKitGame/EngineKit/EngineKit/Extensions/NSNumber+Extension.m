

#import "NSNumber+Extension.h"


@implementation NSNumber (Extension)

+ (NSNumber *)numberWithString:(NSString *)string {
    return @(string.doubleValue);
}

+ (NSNumber *)numberWithObject:(id)object {
    if ([object isKindOfClass:[NSNumber class]]) {
        return object;
    } else if ([object isKindOfClass:[NSString class]]) {
        return [NSNumber numberWithString:object];
    } else {
        __block NSNumber *zero;

        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,
                      ^{
                          zero = @(0);
                      });

        return zero;
    }
}

@end
