

#import "Vector.h"


@class Position;

#pragma mark - Export protocol
@protocol PositionExport <JSExport>
// Getting the Position's information
@property (nonatomic, readonly) CGFloat x;
@property (nonatomic, readonly) CGFloat y;
@property (nonatomic, readonly) CGFloat z;

#pragma mark -
// Common Position constants
+ (instancetype)origin;

#pragma mark -
// Creating Position objects
- (instancetype)initWithObject:(id)object;

#pragma mark -
// Comparing objects
- (BOOL)isEqual:(id)object;

#pragma mark -
// Operations with Positions
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


///-----------------------------------------------------------------------------
/// @name Getting the Position's information
///-----------------------------------------------------------------------------
#pragma mark - Getting the Position's information

/*!
 Creates an `SCNVector4` representing the receiver in homogeneous coordinates.

 If we write the receiver as `(x, y, z)`, the resulting `SCNVector4` can be
 written as `(x, y, z, 0)`.
 @return An instance of `SCNVector4`.
 */
@property (nonatomic, readonly) SCNVector4 toSCNVector4;


///-----------------------------------------------------------------------------
/// @name Common Position constants
///-----------------------------------------------------------------------------
#pragma mark - Common Position constants

/*!
 Represents a commonly used Position, (0 0 0).
 @return A `Position` object.
 */
+ (instancetype)origin;
@end
