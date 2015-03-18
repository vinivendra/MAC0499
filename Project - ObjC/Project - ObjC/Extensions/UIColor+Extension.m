

#import "UIColor+Extension.h"


@implementation UIColor (Extension)

+ (Color *)colorWithObject:(id)object {
    if ([object isKindOfClass:[Color class]]) {
        return [object copy];
    } else if ([object isKindOfClass:[NSString class]]) {
        return [Color colorWithName:object];
    } else if ([object isKindOfClass:[NSArray class]]) {
        return [Color colorWithArray:object];
    } else if ([object isKindOfClass:[NSNumber class]]) {
        return
            [Color colorWithWhite:((NSNumber *)object).doubleValue alpha:1.0];
    }

    NSLog(@"Warning: trying to initialize color with invalid object!");
    return nil;
}

+ (Color *)colorWithName:(NSString *)name {
    static NSDictionary *colorNames;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      colorNames = @{
                          @"black" : [Color blackColor],
                          @"dark gray" : [Color darkGrayColor],
                          @"light gray" : [Color lightGrayColor],
                          @"white" : [Color whiteColor],
                          @"gray" : [Color grayColor],
                          @"red" : [Color redColor],
                          @"green" : [Color greenColor],
                          @"blue" : [Color blueColor],
                          @"cyan" : [Color cyanColor],
                          @"yellow" : [Color yellowColor],
                          @"magenta" : [Color magentaColor],
                          @"orange" : [Color orangeColor],
                          @"purple" : [Color purpleColor],
                          @"brown" : [Color brownColor],
                          @"clear" : [Color clearColor]
                      };
                  });

    return colorNames[name];
}

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
    CGFloat result[4];

    [self getRed:&result[0] green:&result[1] blue:&result[2] alpha:&result[3]];

    result[3] = CGColorGetAlpha(self.CGColor);

    for (int i = 0; i < 3; i++) {
        result[i] = LIMIT(0, result[i] * scalar, 1);
    }

    return [Color colorWithCArray:result];
}

@end
