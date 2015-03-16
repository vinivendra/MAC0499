

#import "UIColor+Extension.h"


@implementation UIColor (Extension)

+ (Color *)colorWithCArray:(CGFloat[4])array {
    return [Color colorWithRed:array[0]
                         green:array[1]
                          blue:array[2]
                         alpha:array[3]];
}

+ (Color *)colorWithArray:(NSArray *)array {
    if (![array valid]) {
        NSLog(@"Warning: initializing color with an empty array!");
        return [Color lightGrayColor];
    }

    if ([array[0] isKindOfClass:[NSNumber class]]) {
        if (array.count == 1) {
            return [Color colorWithWhite:((NSNumber *)array[0]).doubleValue
                                   alpha:1.0];
        } else if (array.count == 2) {
            return [Color colorWithWhite:((NSNumber *)array[0]).doubleValue
                                   alpha:((NSNumber *)array[1]).doubleValue];
        } else if (array.count == 3) {
            return [Color colorWithRed:((NSNumber *)array[0]).doubleValue
                                 green:((NSNumber *)array[1]).doubleValue
                                  blue:((NSNumber *)array[2]).doubleValue
                                 alpha:1.0];
        } else if (array.count >= 4) {
            return [Color colorWithRed:((NSNumber *)array[0]).doubleValue
                                 green:((NSNumber *)array[1]).doubleValue
                                  blue:((NSNumber *)array[2]).doubleValue
                                 alpha:((NSNumber *)array[3]).doubleValue];
        }
    }

    NSLog(@"Warning: initializing color with an empty array!");
    return [Color lightGrayColor];
}

- (Color *)times:(CGFloat)scalar {

    const CGFloat *rgb = CGColorGetComponents(self.CGColor);

    CGFloat result[4];
    result[3] = CGColorGetAlpha(self.CGColor);

    for (int i = 0; i < 3; i++) {
        result[i] = LIMIT(0, rgb[i] * scalar, 1);
    }

    return [Color colorWithCArray:result];
}

@end
