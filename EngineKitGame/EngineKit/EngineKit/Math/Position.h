

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
/// @name Common Vector constants
///-----------------------------------------------------------------------------
#pragma mark - Common Vector constants

/*!
 Represents a commonly used Position, (0 0 0).
 @return A `Position` object.
 */
+ (instancetype)origin;


///-----------------------------------------------------------------------------
/// @name Creating Position objects
///-----------------------------------------------------------------------------
#pragma mark - Getting the Vector's information

/*!
 Creates an "empty" `Position`, initialized to `(0 0 0)`.
 @return A `Position` object.
 @see origin
 */
+ (Position *)position;
/*!
 Creates a `Position` whith the three given components, respectively.
 @param x The value to assign to the `Position`'s `x` component.
 @param y The value to assign to the `Position`'s `y` component.
 @param z The value to assign to the `Position`'s `z` component.
 @return An initialized `Position` object.
 */
+ (Position *)positionWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z;
/*!
 Creates a `Position` in which all components are set to `s`. Useful for
 creating `Position`s that represent uniform scales.
 @param s The value to set to all the `Position`'s components.
 @return An initialized `Position` object.
 @see positionWithObject:
 */
+ (Position *)positionWithUniformNumbers:(CGFloat)s;
/*!
 Given a `CGPoint` of format `(x, y)`, creates a `Position` object of format
 `(x, - y, 0)`. This is done to ease the translation from screen points to scene
 points.
 @param newValue The `CGPoint` that should be used as a model.
 @return An initialized `Position` object.
 */
+ (Position *)positionWithCGPoint:(CGPoint)newValue;
/*!
 Creates a `Position` in which all components are set as just as the first 3
 components (`x`, `y` and `z`) in the given `CIVector`.  This method trusts that
 the CIVector has been correctly initialized and has the  necessary components.

 Useful for obtaining a `Position` through a `CIVector` initialization method.

 @param newValue The `CIValue` whose `x`, `y` and `z` components should be used.
 @return An initialized `Position` object.
 */
+ (Position *)positionWithCIVector:(CIVector *)newValue;
/*!
 Creates a `Position` in which all components are set as just as the given
 `SCNVector3`.
 @param newValue The `SCNVector3` that should be used as a model.
 @return An initialized `Position` object.
 @see positionWithNSValue:
 @see positionWithSCNVector4:
 */
+ (Position *)positionWithSCNVector3:(SCNVector3)newValue;
/*!
 Creates a `Position` in which all components are set as just as the first 3
 components in the given `SCNVector4`. If that `Position` has format `(x y z
 w)`, the created `Position` object will have format `(x y z)`.
 @param newValue The `SCNVector4` whose first three components should be used.
 @return An initialized `Position` object.
 @see positionWithSCNVector3:
 */
+ (Position *)positionWithSCNVector4:(SCNVector4)newValue;
/*!
 Creates a `Position` based on the `SCNVector3` contained in the given
 `NSValue`.

 @param newValue An `NSValue` created with an `SCNVector3`, which will be
 obtained using `SCNVector3Value`.
 @see [Vector initWithSCNVector3:]
 @see positionWithObject:
 */
+ (Position *)positionWithNSValue:(NSValue *)newValue;
/*!
 Creates a `Position` based on the first three elements on a given `NSArray`. If
 the array has less than 3 components or if any of the first three components is
 not an `NSNumber`, the corresponding value is set to zero.
 @param array The `NSArray` that should be used as a model.
 @return An initialized `Position` object.
 @see positionWithObject:
 */
+ (Position *)positionWithArray:(NSArray *)array;
/*!
 Creates a `Position` based on the elements on a given NSDictionary. If there
 are elements with the key "x", "y" and "z" (case insensitive), those elements
 are used. If one of them is missing, the keys "0", "1" or "2" are used to
 replace them as needed. If any elements are still missing, the corresponding
 value is set to 0.0.
 @param dictionary The `NSDictionary` that should be used as a model.
 @return An initialized `Position` object.
 @see positionWithObject:
 */
+ (Position *)positionWithDictionary:(NSDictionary *)dictionary;
/*!
 Attempts to create a `Position` by scanning the string for numbers. Each number
 found is inserted into an `NSArray`, and then the `[Vector initWithArray:]`
 method is used.
 @param string The `NSString` to use as a model.
 @return An initialized `Position` object.
 @see [Vector initWithArray:]
 @see positionWithObject:
 */
+ (Position *)positionWithString:(NSString *)string;
/*!
 Returns the given `Vector` object, cast to a `Position`. Used for completion
 and standardization by other methods.
 @param vector The `Vector` object that will be returned.
 @return A `Position` object.
 @see positionWithObject:
 */
+ (Position *)positionWithVector:(Vector *)vector;
/*!
 Returns the given `Position` object. Used for completion and standardization by
 other methods.
 @param position The `Position` object that will be returned.
 @return A `Position` object.
 */
+ (Position *)positionWithPosition:(Position *)position;
/*!
 Creates a `Position` based on the given object.

 The supported objects are:

 - `NSNumber`, which will be initialized just like `[Vector
 initWithUniformNumbers:]`.
 - `NSArray`, which will be initialized just like `[Vector initWithArray:]`.
 - `NSValue` containing a `SCNVector3`, which will be initialized just like
 `[Vector initWithSCNVector3:]`.
 - `Vector` (or any of its subclassses), which will be initialized just like
 `initWithVector:`.
 - `NSString`, which will be initialized just like `[Vector initWithString:]`.
 - `NSDictionary`, which will be initialized just like `[Vector
 initWithDictionary:]`.

 @warning In case the object isn't a subclass of any of the above classes, an
 `assert(false)` will be triggered.

 @param object An object of any one of the classes mentioned above.
 @return An initialized `Position` object.
 @see [Vector initWithUniformNumbers:]
 @see [Vector initWithArray:]
 @see [Vector initWithSCNVector3:]
 @see [Vector initWithVector:]
 @see [Vector initWithString:]
 @see [Vector initWithDictionary:]
 */
+ (Position *)positionWithObject:(id)object;
@end
