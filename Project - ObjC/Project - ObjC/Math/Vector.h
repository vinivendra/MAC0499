

bool vectorsAreEqual(SCNVector3 vector1, SCNVector3 vector2);

@interface Vector : NSObject
@property (nonatomic) SCNVector3 vector;

@property (nonatomic, readonly) CGFloat x;
@property (nonatomic, readonly) CGFloat y;
@property (nonatomic, readonly) CGFloat z;

+ (instancetype)vectorWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z;
+ (instancetype)vectorWithVector:(SCNVector3)newValue;
+ (instancetype)vectorWithArray:(NSArray *)array;
- (BOOL)isEqualToVector:(SCNVector3)vector;
- (SCNVector3)toSCNVector;
@end
