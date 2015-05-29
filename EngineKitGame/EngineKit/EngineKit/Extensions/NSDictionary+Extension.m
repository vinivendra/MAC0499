

#import "NSDictionary+Extension.h"

#import "NSNumber+Extension.h"


@implementation NSDictionary (Extension)

- (NSNumber *)numberForKey:(id<NSCopying>)key {
    return self[key] ? [NSNumber numberWithObject:self[key]] : @(0);
}

- (CGFloat)floatForKey:(id<NSCopying>)key {
    return self[key] ? [NSNumber numberWithObject:self[key]].doubleValue : 0.0;
}

- (CGFloat)floatForStringKey:(NSString *)key {
    if (self[key])
        return [NSNumber numberWithObject:self[key]].doubleValue;

    key = [key lowercaseString];
    if (self[key])
        return [NSNumber numberWithObject:self[key]].doubleValue;

    key = [key uppercaseString];
    if (self[key])
        return [NSNumber numberWithObject:self[key]].doubleValue;

    key = [key capitalizedString];
    if (self[key])
        return [NSNumber numberWithObject:self[key]].doubleValue;

    return 0.0;
}

@end
