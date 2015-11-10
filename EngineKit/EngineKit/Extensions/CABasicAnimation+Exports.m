

#import "CABasicAnimation+Exports.h"


@implementation CABasicAnimation (Exports)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {

    if (self = [super init]) {
        id value;

        if ((value = dictionary[@"keyPath"])) {
            if ([value isKindOfClass:[NSString class]]) {
                self.keyPath = value;
            }
        }

        if ((value = dictionary[@"toValue"])) {
            if ([value isKindOfClass:[NSNumber class]]) {
                self.toValue = value;
            }
        }

        if ((value = dictionary[@"fromValue"])) {
            if ([value isKindOfClass:[NSNumber class]]) {
                self.fromValue = value;
            }
        }

        if ((value = dictionary[@"duration"])) {
            if ([value isKindOfClass:[NSNumber class]]) {
                NSNumber *number = value;
                self.duration = number.doubleValue;
            }
        }

        if ((value = dictionary[@"delay"])) {
            if ([value isKindOfClass:[NSNumber class]]) {
                NSNumber *number = value;
                self.beginTime = number.doubleValue;
            }
        }

        if ((value = dictionary[@"function"])) {
            if ([value isKindOfClass:[NSString class]]) {
                if ([value caseInsensitiveCompare:@"linear"] == NSOrderedSame) {
                    self.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
                }
                else if ([value caseInsensitiveCompare:@"easeIn"] == NSOrderedSame) {
                    self.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
                }
                else if ([value caseInsensitiveCompare:@"easeOut"] == NSOrderedSame) {
                    self.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                }
                else if ([value caseInsensitiveCompare:@"easeInOut"] == NSOrderedSame) {
                    self.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                }
                else if ([value caseInsensitiveCompare:@"bounce"] == NSOrderedSame) {
                    self.timingFunction = [CAMediaTimingFunction functionWithControlPoints:.5 :1.2 :1 :1];
                }
            }
        }

        if ((value = dictionary[@"repeatCount"])) {
            if ([value isKindOfClass:[NSNumber class]]) {
                NSNumber *number = value;
                self.repeatCount = number.floatValue;
            }
        }

        if ((value = dictionary[@"autoreverses"])) {
            if ([value isKindOfClass:[NSNumber class]]) {
                NSNumber *number = value;
                self.autoreverses = number.boolValue;
            }
        }
    }

    return self;
}

@end
