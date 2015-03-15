

#import "NSString+Extension.h"


@implementation NSString (Extension)

- (BOOL)valid {
    
    if (self.length == 0) return NO;
    
    NSCharacterSet *nonWhitespaceSet = [[NSCharacterSet whitespaceAndNewlineCharacterSet] invertedSet];
    NSRange range = [self rangeOfCharacterFromSet:nonWhitespaceSet];
    return (range.location != NSNotFound);
}

@end
