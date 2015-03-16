

#import "UIColor+Extension.h"


@implementation UIColor (Extension)

+ (Color *)colorWithCArray:(CGFloat[4])array {
    return [Color colorWithRed:array[0] green:array[1] blue:array[2] alpha:array[3]];
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
