

@interface Rotation : NSObject
+ (instancetype)rotationWithAxis:(Axis *)axis angle:(Angle *)angle;
+ (instancetype)rotationWithArray:(NSArray *)array;
- (instancetype)initWithAxis:(Axis *)axis angle:(Angle *)angle;
- (instancetype)initWithArray:(NSArray *)array;
- (SCNVector4)toSCNVector;
@end
