

#import "NSArray+Extension.h"

#import "NSNumber+Extension.h"


@implementation NSArray (Extension)

- (BOOL)valid {
    return self.count != 0;
}

- (NSNumber *)numberAtIndex:(NSUInteger)index {
    return self.count <= index ? @(0) : [NSNumber numberWithObject:self[index]];
}

- (CGFloat)floatAtIndex:(NSUInteger)index {
    return self.count <= index
               ? 0.0f
               : [NSNumber numberWithObject:self[index]].doubleValue;
}

- (id)at:(NSUInteger)index {
    return self.count <= index ? nil : self[index];
}

@end
