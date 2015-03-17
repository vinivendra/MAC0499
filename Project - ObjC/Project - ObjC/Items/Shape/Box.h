

#import "Shape.h"


@interface Box : Shape
+ (instancetype)box;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat length;
@end
