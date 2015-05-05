

#import "Vector.h"


@class Position;

@protocol PositionExport <JSExport>
@property (nonatomic) SCNVector3 vector;

@property (nonatomic, readonly) CGFloat x;
@property (nonatomic, readonly) CGFloat y;
@property (nonatomic, readonly) CGFloat z;

+ (instancetype)origin;
- (instancetype)initWithObject:(id)object;
- (BOOL)isEqualToVector:(SCNVector3)vector;
- (SCNVector3)toSCNVector;

- (Vector *)times:(CGFloat)scalar;
- (Vector *)over:(CGFloat)scalar;
- (Vector *)plus:(Vector *)vector;
- (Vector *)minus:(Vector *)vector;
- (CGFloat)dot:(Vector *)vector;
- (CGFloat)normSquared;
- (CGFloat)norm;
- (Vector *)normalize;
- (Vector *)translate:(Vector *)vector;
- (Vector *)scale:(CGFloat)scale;
@end


/*!
 A representation of a 3D position. Much like the Vector class, but meant to be
 used as a point instead of a vector.
 */
@interface Position : Vector <PositionExport>
@end
