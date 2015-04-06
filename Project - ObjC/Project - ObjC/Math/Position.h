

@class Position;

@protocol PositionExport <JSExport>
@property (nonatomic) SCNVector3 vector;

@property (nonatomic, readonly) CGFloat x;
@property (nonatomic, readonly) CGFloat y;
@property (nonatomic, readonly) CGFloat z;

- (BOOL)isEqualToVector:(SCNVector3)vector;
- (SCNVector3)toSCNVector;
@end


/*!
 A representation of a 3D position. Much like the Vector class, but meant to be
 used as a point instead of a vector.
 */
@interface Position : Vector <PositionExport>
@end
