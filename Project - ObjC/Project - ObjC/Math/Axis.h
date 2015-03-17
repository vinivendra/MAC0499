

#import "Vector.h"


@interface Axis : Vector

- (instancetype)initWithString:(NSString *)string;

+ (instancetype)x;
+ (instancetype)y;
+ (instancetype)z;

@end
