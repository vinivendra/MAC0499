

@interface Position : Vector

+ (instancetype)positionWithVector:(Vector *)vector;
+ (instancetype)positionWithSCNVector:(SCNVector3)vector;
+ (instancetype)positionWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z;
+ (instancetype)positionArray:(NSArray *)array;

@end
