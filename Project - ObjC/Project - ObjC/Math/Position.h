

@class Position;

@protocol PositionExport <JSExport>
@property (nonatomic) SCNVector3 vector;

@property (nonatomic, readonly) CGFloat x;
@property (nonatomic, readonly) CGFloat y;
@property (nonatomic, readonly) CGFloat z;

- (instancetype)initWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z;
- (instancetype)initWithSCNVector:(SCNVector3)newValue;
- (instancetype)initWithCIVector:(CIVector *)newValue;
- (instancetype)initWithVector:(Vector *)vector;
- (instancetype)initWithArray:(NSArray *)array;
- (instancetype)initWithObject:(id)object;
- (BOOL)isEqualToVector:(SCNVector3)vector;
- (SCNVector3)toSCNVector;
@end


/*!
 A representation of a 3D position. Much like the Vector class, but meant to be
 used as a point instead of a vector.
 */
@interface Position : Vector <PositionExport>
@end
