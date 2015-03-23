

#import "UIColor+Extension.h"


@implementation UIColor (Extension)

+ (Color *)colorWithObject:(id)object {
    Color *result;
    if ([object isKindOfClass:[Color class]]) {
        result = [object copy];
    } else if ([object isKindOfClass:[NSString class]]) {
        result = [Color colorWithName:object];
    } else if ([object isKindOfClass:[NSArray class]]) {
        result = [Color colorWithArray:object];
    } else if ([object isKindOfClass:[NSNumber class]]) {
        result =
            [Color colorWithWhite:((NSNumber *)object).doubleValue alpha:1.0];
    }
    
    assert(result);

    return result;
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

    assert([colorNames.allKeys containsObject:name]);
    
    return colorNames[name];
}

+ (Color *)colorWithCArray:(CGFloat[4])array {
    return [Color colorWithRed:array[0]
                         green:array[1]
                          blue:array[2]
                         alpha:array[3]];
}

+ (Color *)colorWithArray:(NSArray *)array {
    assert([array valid]);

    Color *result;
    
    if ([array[0] isKindOfClass:[NSNumber class]]) {
        if (array.count == 1) {
            result = [Color colorWithWhite:((NSNumber *)array[0]).doubleValue
                                   alpha:1.0];
        } else if (array.count == 2) {
            result = [Color colorWithWhite:((NSNumber *)array[0]).doubleValue
                                   alpha:((NSNumber *)array[1]).doubleValue];
        } else if (array.count == 3) {
            result = [Color colorWithRed:((NSNumber *)array[0]).doubleValue
                                 green:((NSNumber *)array[1]).doubleValue
                                  blue:((NSNumber *)array[2]).doubleValue
                                 alpha:1.0];
        } else if (array.count >= 4) {
            result = [Color colorWithRed:((NSNumber *)array[0]).doubleValue
                                 green:((NSNumber *)array[1]).doubleValue
                                  blue:((NSNumber *)array[2]).doubleValue
                                 alpha:((NSNumber *)array[3]).doubleValue];
        }
    }
    
    assert(result);

    return result;
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
