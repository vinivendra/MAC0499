

@class Rotation;


@protocol RotationExport <JSExport>
@end


@interface Rotation : NSObject <RotationExport>
+ (instancetype)rotationWithAxis:(Axis *)axis angle:(Angle *)angle;
+ (instancetype)rotationWithArray:(NSArray *)array;
+ (instancetype)rotationWithObject:(id)object;
+ (instancetype)rotationWithSCNVector4:(SCNVector4)vector;
- (instancetype)initWithSCNVector4:(SCNVector4)vector;
- (instancetype)initWithAxis:(Axis *)axis angle:(Angle *)angle;
- (instancetype)initWithArray:(NSArray *)array;
- (instancetype)initWithObject:(id)object;
- (SCNVector4)toSCNVector;
@end
