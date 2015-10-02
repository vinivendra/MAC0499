

#import "NSString+Extension.h"

#import "NSNumber+Extension.h"


@implementation NSString (Extension)

- (BOOL)valid {
    if (self.length == 0)
        return NO;

    NSCharacterSet *nonWhitespaceSet =
    [[NSCharacterSet whitespaceAndNewlineCharacterSet] invertedSet];
    NSRange range = [self rangeOfCharacterFromSet:nonWhitespaceSet];
    return (range.location != NSNotFound);
}

- (NSNumber *)numberValue {
    return [NSNumber numberWithString:self];
}

- (NSUInteger)indentation {
    NSCharacterSet *whitespaceSet =
    [NSCharacterSet whitespaceAndNewlineCharacterSet];

    NSUInteger i;
    for (i = 0; i < self.length; i++) {
        if (![whitespaceSet characterIsMember:[self characterAtIndex:i]])
            break;
    }

    return i;
}

+ (NSString *)stringFromFloat:(float) val {
    NSString *ret = [NSString stringWithFormat:@"%lf", val];
    unichar c = [ret characterAtIndex:[ret length] - 1];
    while (c == 48 || c == 46) { // 0 or .
        ret = [ret substringToIndex:[ret length] - 1];
        c = [ret characterAtIndex:[ret length] - 1];
    }
    return ret;
}

@end
