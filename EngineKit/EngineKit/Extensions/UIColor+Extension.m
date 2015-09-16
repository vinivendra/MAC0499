

#import "UIColor+Extension.h"

#import "NSArray+Extension.h"
#import "ObjectiveSugar.h"


@implementation UIColor (Extension)

+ (NSDictionary *)colorNames {
    static NSDictionary *colorNames;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      colorNames = @{
                                     @"black" : [UIColor blackColor],
                                     @"dark gray" : [UIColor darkGrayColor],
                                     @"darkGray" : [UIColor darkGrayColor],
                                     @"gray" : [UIColor grayColor],
                                     @"light gray" : [UIColor lightGrayColor],
                                     @"lightGray" : [UIColor lightGrayColor],
                                     @"white" : [UIColor whiteColor],
                                     @"red" : [UIColor redColor],
                                     @"green" : [UIColor greenColor],
                                     @"blue" : [UIColor blueColor],
                                     @"cyan" : [UIColor cyanColor],
                                     @"yellow" : [UIColor yellowColor],
                                     @"magenta" : [UIColor magentaColor],
                                     @"orange" : [UIColor orangeColor],
                                     @"purple" : [UIColor purpleColor],
                                     @"brown" : [UIColor brownColor],
                                     @"clear" : [UIColor clearColor]
                                     };
                  });

    return colorNames;
}

+ (instancetype)color:(id)object {
    return [UIColor colorWithObject:object];
}

+ (UIColor *)colorWithObject:(id)object {
    UIColor *result;

    if ([object isKindOfClass:[UIColor class]]) {
        result = [object copy];
    } else if ([object isKindOfClass:[NSString class]]) {
        result = [UIColor colorWithName:object];
    } else if ([object isKindOfClass:[NSArray class]]) {
        result = [UIColor colorWithArray:object];
    } else if ([object isKindOfClass:[NSNumber class]]) {
        result =
            [UIColor colorWithWhite:((NSNumber *)object).doubleValue alpha:1.0];
    }

    return result;
}

+ (UIColor *)colorWithName:(NSString *)name {
    name = name.camelCase;
    return self.colorNames[name];
}

+ (UIColor *)colorWithCArray:(CGFloat[4])array {
    return [UIColor colorWithRed:array[0]
                         green:array[1]
                          blue:array[2]
                         alpha:array[3]];
}

+ (UIColor *)colorWithArray:(NSArray *)array {
    UIColor *result;
    
    if ([array[0] isKindOfClass:[NSNumber class]]) {
        if (array.count == 1) {
            result = [UIColor colorWithWhite:[array floatAtIndex:0]
                                   alpha:1.0];
        } else if (array.count == 2) {
            result = [UIColor colorWithWhite:[array floatAtIndex:0]
                                   alpha:[array floatAtIndex:1]];
        } else if (array.count == 3) {
            result = [UIColor colorWithRed:[array floatAtIndex:0]
                                 green:[array floatAtIndex:1]
                                  blue:[array floatAtIndex:2]
                                 alpha:1.0];
        } else if (array.count >= 4) {
            result = [UIColor colorWithRed:[array floatAtIndex:0]
                                 green:[array floatAtIndex:1]
                                  blue:[array floatAtIndex:2]
                                 alpha:[array floatAtIndex:3]];
        }
    }

    return result;
}

- (UIColor *)times:(CGFloat)scalar {
    CGFloat result[4];

    [self getRed:&result[0] green:&result[1] blue:&result[2] alpha:&result[3]];

    for (int i = 0; i < 3; i++) {
        result[i] = LIMIT(0, result[i] * scalar, 1);
    }

    return [UIColor colorWithCArray:result];
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[UIColor class]]) {
        return NO;
    }

    CGFloat r1, g1, b1, a1;
    [self getRed:&r1 green:&g1 blue:&b1 alpha:&a1];

    CGFloat r2, g2, b2, a2;
    [self getRed:&r2 green:&g2 blue:&b2 alpha:&a2];

    return r1 == r2 && g1 == g2 && b1 == b2 && a1 == a2;
}

- (NSString *)name {
    NSEnumerator *enumerator = [UIColor colorNames].keyEnumerator;
    NSString *name;
    while ((name = [enumerator nextObject])) {
        UIColor *color = [UIColor colorWithName:name];
        if ([self isEqual:color]) {
            return name;
        }
    }

    return nil;
}

@end
