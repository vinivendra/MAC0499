

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

@end
