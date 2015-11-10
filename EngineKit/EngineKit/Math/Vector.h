// TODO: Create a copy method for all exported classes.
// TODO: Test rotation for non normalized vectors

// TODO: Fix the documentations for the arithmetic operations (they say "object" but should say "vector")

#import <JavaScriptCore/JavaScriptCore.h>
#import <SceneKit/SceneKit.h>


@class Vector;

#pragma mark - Export protocol
@protocol VectorExport <JSExport>
// Getting the Vector's information
@property (nonatomic, readonly) CGFloat x;
@property (nonatomic, readonly) CGFloat y;
@property (nonatomic, readonly) CGFloat z;

#pragma mark -
// Common Vector constants
+ (instancetype)origin;

#pragma mark -
// Creating Vector objects
- (instancetype)initWithObject:(id)object;

#pragma mark -
// Comparing objects
- (BOOL)isEqual:(id)object;

#pragma mark -
// Operations with Vectors
- (Vector *)times:(CGFloat)scalar;
- (Vector *)over:(CGFloat)scalar;
- (Vector *)plus:(id)vector;
- (Vector *)minus:(id)vector;
- (CGFloat)dot:(id)object;
- (CGFloat)normSquared;
- (CGFloat)norm;
- (Vector *)normalize;
- (Vector *)translate:(id)vector;
- (Vector *)scale:(id)vector;
- (Vector *)setNewX:(CGFloat)x;
- (Vector *)setNewY:(CGFloat)y;
- (Vector *)setNewZ:(CGFloat)z;
@end


/*!
 Represents a tuple of three `CGFloats`, here named `x`, `y` and `z`.
 */
@interface Vector : NSObject <VectorExport>

///-----------------------------------------------------------------------------
/// @name Getting the Vector's information
///-----------------------------------------------------------------------------
#pragma mark - Getting the Vector's information

/*!
 The `Vector`'s `x` component.
 @see y
 @see z
 */
@property (nonatomic, readonly) CGFloat x;
/*!
 The `Vector`'s `x` component.
 @see x
 @see z
 */
@property (nonatomic, readonly) CGFloat y;
/*!
 The `Vector`'s `x` component.
 @see x
 @see y
 */
@property (nonatomic, readonly) CGFloat z;
/*!
 A `Vector`'s components may be accessed by subscripts. Index `0` corresponds to
 the `x` component, `1` to the `y` component and `2` to the `z` component. Any
 other index returns `nil`.
 @param index The index corresponding to one of the `Vector`'s components.
 @return The value of the corresponding component.
 */
- (NSNumber *)objectAtIndexedSubscript:(NSUInteger)index;

/*!
 Creates an `SCNVector3` with the same components as the `Vector`.
 @return An instance of `SCNVector3`.
 */
@property (nonatomic, readonly) SCNVector3 toSCNVector3;
/*!
 Creates an `SCNVector4` representing the receiver in homogeneous coordinates.

 If we write the receiver as `(x, y, z)`, the resulting `SCNVector4` can be
 written as `(x, y, z, 1)`.
 @return An instance of `SCNVector4`.
 */
@property (nonatomic, readonly) SCNVector4 toSCNVector4;
/*!
 Creates an `NSValue` containing an `SCNVector3` with the same components as the
 `Vector`.
 @return An instance of `NSValue`.
 */
@property (nonatomic, readonly, copy) NSValue *toNSValue;
/*!
 Creates an NSArray containing the `Vector`'s three components as NSNumbers.
 @return An instance of `NSArray`.
 */
@property (nonatomic, readonly, copy) NSArray *toArray;


//------------------------------------------------------------------------------
/// @name Getting the Vector's information
//------------------------------------------------------------------------------
#pragma mark - Getting the Vector's information
/*!
 Returns `NO` if all the `Vector`'s components are `0`; `YES` otherwise.
 @return A boolean value indicating wether or not the receiver has zeroes in all
 components.
 */
@property (nonatomic, readonly) BOOL notZero;


///-----------------------------------------------------------------------------
/// @name Common Vector constants
///-----------------------------------------------------------------------------
#pragma mark - Common Vector constants

/*!
 Represents a commonly used Vector, (0 0 0).
 @return A `Vector` object.
 */
+ (instancetype)origin;


///-----------------------------------------------------------------------------
/// @name Creating Vector objects
///-----------------------------------------------------------------------------
#pragma mark - Creating Vector objects
/*!
 Initializes an "empty" `Vector` with `(0 0 0)`.
 @return An initialized `Vector` object.
 @see origin
 */
- (instancetype)init;
/*!
 Initializes a `Vector` whith the three given components, respectively.
 @param x The value to assign to the `Vector`'s `x` component.
 @param y The value to assign to the `Vector`'s `y` component.
 @param z The value to assign to the `Vector`'s `z` component.
 @return An initialized `Vector` object.
 */
- (instancetype)initWithX:(CGFloat)x
                        Y:(CGFloat)y
                        Z:(CGFloat)z NS_DESIGNATED_INITIALIZER;
/*!
 Initializes a `Vector` in which all components are set to `s`. Useful for
 creating `Vector`s that represent uniform scales.
 @param s The value to set to all the `Vector`'s components.
 @return An initialized `Vector` object.
 @see initWithObject:
 */
- (instancetype)initWithUniformNumbers:(CGFloat)s;
/*!
 Given a `CGPoint` of format `(x, y)`, creates a `Vector` object of format `(x,
 - y, 0)`. This is done to ease the translation from screen points to scene
 points.
 @param newValue The `CGPoint` that should be used as a model.
 @return An initialized `Vector` object.
 */
- (instancetype)initWithCGPoint:(CGPoint)newValue;
/*!
 Initializes a `Vector` in which all components are set as just as the first 3
 components (`x`, `y` and `z`) in the given `CIVector`. This method trusts that
 the CIVector has been correctly initialized and has the necessary components.

 Useful for obtaining a `Vector` through a `CIVector` initialization method.

 @param newValue The `CIValue` whose `x`, `y` and `z` components should be used.
 @return An initialized `Vector` object.
 */
- (instancetype)initWithCIVector:(CIVector *)newValue;
/*!
 Initializes a `Vector` in which all components are set as just as the given
 `SCNVector3`.
 @param newValue The `SCNVector3` that should be used as a model.
 @return An initialized `Vector` object.
 @see initWithSCNVector4:
 @see initWithObject:
 */
- (instancetype)initWithSCNVector3:(SCNVector3)newValue;
/*!
 Initializes a `Vector` in which all components are set as just as the first 3
 components in the given `SCNVector4`. If that `Vector` has format `(x y z w)`,
 the created `Vector` object will have format `(x y z)`.

 Useful for obtaining the axis of a rotation.

 @param newValue The `SCNVector4` whose first three components should be used.
 @return An initialized `Vector` object.
 @see initWithSCNVector3:
 */
- (instancetype)initWithSCNVector4:(SCNVector4)newValue;
/*!
 Initializes a `Vector` based on the first three elements on a given `NSArray`.
 If the array has less than 3 components or if any of the first three components
 is not an `NSNumber`, the corresponding value is set to zero.
 @param array The `NSArray` that should be used as a model.
 @return An initialized `Vector` object.
 @see initWithObject:
 */
- (instancetype)initWithArray:(NSArray *)array;
/*!
 Initializes a `Vector` based on the elements on a given NSDictionary. If there
 are elements with the key "x", "y" and "z" (case insensitive), those elements
 are used. If one of them is missing, the keys "0", "1" or "2" are used to
 replace them as needed. If any elements are still missing, the corresponding
 value is set to 0.0.
 @param dictionary The `NSDictionary` that should be used as a model.
 @return An initialized `Vector` object.
 @see initWithObject:
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
/*!
 Attempts to initialize a `Vector` by scanning the string for numbers. Each
 number found is inserted into an `NSArray`, and then the `initWithArray:`
 method is used.
 @param string The `NSString` to use as a model.
 @return An initialized `Vector` object.
 @see initWithArray:
 @see initWithObject:
 */
- (instancetype)initWithString:(NSString *)string;
/*!
 Returns the given `Vector` object. Used for completion and standardization by
 other methods.
 @param vector The `Vector` object that will be returned.
 @return A `Vector` object.
 */
- (instancetype)initWithVector:(Vector *)vector;
/*!
 Initializes a `Vector` based on the given object.

 The supported objects are:

 - `NSNumber`, which will be initialized just like `initWithUniformNumbers:`.
 - `NSArray`, which will be initialized just like `initWithArray:`.
 - `Vector` (or any of its subclassses), which will be initialized just like
 `initWithVector:`.
 - `NSString`, which will be initialized just like `initWithString:`.
 - `NSDictionary`, which will be initialized just like `initWithDictionary:`.

 @warning In case the object isn't a subclass of any of the above classes, an
 `assert(false)` will be triggered.

 @param object An object of any one of the classes mentioned above.
 @return An initialized `Vector` object.
 @see initWithUniformNumbers:
 @see initWithArray:
 @see initWithSCNVector3:
 @see initWithVector:
 @see initWithString:
 @see initWithDictionary:
 */
- (instancetype)initWithObject:(id)object;

///-----------------------------------------------------------------------------
/// @name Comparing objects
///-----------------------------------------------------------------------------
#pragma mark - Comparing objects

/*!
 Compares the receiver with another `Vector` for equality by testing if all
 their components are equal.
 @param object An object used to initialize a `Vector` by calling
 `initWithObject:`. The resulting `Vector` will then be compared to the
 receiver.
 @return `YES` if both objects are considered equal; `NO` otherwise.
 */
- (BOOL)isEqual:(id)object;

/*!
 Compares the receiver with an `SCNVector3` for equality by testing if all their
 components are equal.
 @param vector An `SCNVector3` to compare with the receiver.
 @return `YES` if both vectors are considered equal; `NO` otherwise.
 */
- (BOOL)isEqualToVector:(SCNVector3)vector;

///-----------------------------------------------------------------------------
/// @name Operations with Vectors
///-----------------------------------------------------------------------------
#pragma mark - Operations with Vectors

/*!
 Creates a `Vector` representing a multiplication of the receiver by a scalar
 `a`.

 If we wrote the receiver as `(x, y, z)`, the resulting `Vector` would be
 written as `(a*x, a*y, a*z)`.

 @param a The scalar value by which to multiply the `Vector`.
 @return A new instance of a `Vector` object.
 @see over:
 @see scale:
 */
- (Vector *)times:(CGFloat)a;
/*!
 Creates a `Vector` representing a division of the receiver by a scalar `a`.

 If we wrote the receiver as `(x, y, z)`, the resulting `Vector` would be
 written as `(x/a, y/a, z/a)`.

 @param a The scalar value by which to divide the `Vector`.
 @return A new instance of a `Vector` object.
 @see times:
 */
- (Vector *)over:(CGFloat)a;
/*!
 Creates a new `Vector` from the given `object` by calling `initWithObject:`.
 Adds this new `Vector` to the receiver and returns the result.

 If we wrote the receiver as `(x, y, z)` and the `Vector` resulting from the
 given object as `(a, b, c)`, the resulting `Vector` would be written as `(a +
 x, b + y, c + z)`.

 @param object An object, used to initialize a new `Vector` using the
 `initWithObject:` method. The resulting `Vector` is then used in the
 addition.
 @return A new instance of a `Vector` object.
 @see minus:
 */
- (Vector *)plus:(id)vector;
/*!
 Creates a new `Vector` from the given `object` by calling `initWithObject:`.
 Subtracts this new `Vector` from the receiver and returns the result.

 If we wrote the receiver as `(x, y, z)` and the `Vector` resulting from the
 given object as `(a, b, c)`, the resulting `Vector` would be written as `(a -
 x, b - y, c - z)`.

 @param object An object, used to initialize a new `Vector` using the
 `initWithObject:` method. The resulting `Vector` is then used in the
 subtraction.
 @return A new instance of a `Vector` object.
 @see plus:
 */
- (Vector *)minus:(id)vector;
/*!
 Creates a new `Vector`, representing the opposite from the given `Vector`.

 If we wrote the given `Vector` as `(x, y, z)`, the resulting `Vector` would be
 written as `(- x, - y, - z)`.

 @return A new instance of a `Vector` object.
 */
@property (nonatomic, readonly, strong) Vector *opposite;
/*!
 Creates a new `Vector` from the given `object` by calling `initWithObject:`.
 Calculates the dot product between that `Vector` and the receiver.

 If we wrote the receiver as `(x, y, z)` and the `Vector` resulting from the
 given object as `(a, b, c)`, the result would be written as `a*x + b*y + c*z`.

 @param object An object, used to initialize a new `Vector` using the
 `initWithObject:` method. The resulting `Vector` is then used in the dot
 product.
 @return The value of the dot product between the two vectors.
 @see normSquared
 @see norm
 */
// TODO: doc
- (CGFloat)dot:(id)object;
/*!
 Returns the squared norm of the receiver.

 Useful to compare the magnitude of different vectors without having the
 performance hit of a squared root (as the `norm` method does).

 If we wrote the receiver as `(x, y, z)`, the result would be written as `x*x +
 y*y + z*z`.

 @return The squared value of the `Vector`'s norm.
 @see dot:
 @see norm
 */
@property (nonatomic, readonly) CGFloat normSquared;
/*!
 Returns the norm of the receiver.

 If we wrote the receiver as `(x, y, z)`, the result would be written as
 `sqrt(x*x + y*y + z*z)`.

 @warning This method might involve a performance hit from taking the squared
 root if used in a tight loop; use the `squaredNorm` method instead whenever
 possible.
 @return The value of the `Vector`'s norm.
 @see normSquared
 @see dot:
 */
@property (nonatomic, readonly) CGFloat norm;
/*!
 Creates a new `Vector` as a result of changing receiver's components uniformly,
 scaling them so that the resulting `Vector` object has a norm of 1.

 If we write the receiver as `(x, y, z)` and its `norm` as `n`, the resulting
 `Vector` would be written as `(x/n, y/n, z/n)`.

 @warning This method might involve a performance hit from taking the squared
 root if used in a tight loop; use only when necessary.
 @return A new instance of a `Vector` object.
 @see norm
 @see normSquared
 */
@property (nonatomic, readonly, strong) Vector *normalize;
/*!
 Creates a new `Vector` from the given `object` by calling `initWithObject:`.
 That `Vector` is then translated, using the receiver as a translation `Vector`.

 Mathematically equivalent to adding both `Vector`s using the `plus` method.

 @param object An object, used to initialize a new `Vector` using the
 `initWithObject:` method. The resulting `Vector` is then translated.
 @return A new intance of a `Vector` object.
 @see plus:
 @see scale:
 */
- (Vector *)translate:(id)vector;
/*!
 Creates a new `Vector` from the given `object` by calling `initWithObject:`.
 That `Vector` is then scaled, using the receiver as a scale `Vector`.

 If an `NSNumber` is given, the result would be equivalent to simply scaling the
 receiver by that number.

 If we write the receiver as `(x, y, z)` and the given `Vector` as `(a, b, c)`,
 the resulting `Vector` would be written as `(a*x, b*y, c*z)`

 @param object An object, used to initialize a new `Vector` using the
 `initWithObject:` method. The resulting `Vector` is then used as a scale.
 @return A new intance of a `Vector` object.
 @see translate:
 */
- (Vector *)scale:(id)vector;
/*!
 Applies the translation the receiver represents to the given `SCNMatrix4`.
 @param matrix The matrix to translate.
 @return A new `SCNMatrix4`, representing the result of the translation of the
 original matrix.
 @see translate:
 */
- (SCNMatrix4)translateMatrix:(SCNMatrix4)matrix;
/*!
 Applies the scale the receiver represents to the given `SCNMatrix4`.
 @param matrix The matrix to scale.
 @return A new `SCNMatrix4`, representing the result of scaling the original
 matrix.
 @see scale:
 */
- (SCNMatrix4)scaleMatrix:(SCNMatrix4)matrix;


///-----------------------------------------------------------------------------
/// @name Attempting to change Vectors
///-----------------------------------------------------------------------------
#pragma mark - Attempting to change Vectors

/*!
 Creates a new `Vector` object with the same coordinates as the receiver but
 with the new `x` coordinate.

 Since `Vector`s are immutable, this method acts like a setter for the `x`
 property but returns a new `Vector` instead.

 If the receiver has format `(a, b, c)`, the resulting `Vector` has format `(x,
 b, c)`.
 @param x The new value to set in the `x` coordinate.
 @return A new `Vector` object
 @see setNewY:
 @see setNewZ:
 */
- (Vector *)setNewX:(CGFloat)x;
/*!
 Creates a new `Vector` object with the same coordinates as the receiver but
 with the new `y` coordinate.

 Since `Vector`s are immutable, this method acts like a setter for the `y`
 property but returns a new `Vector` instead.

 If the receiver has format `(a, b, c)`, the resulting `Vector` has format `(a,
 y, c)`.
 @param y The new value to set in the `y` coordinate.
 @return A new `Vector` object
 @see setNewX:
 @see setNewZ:
 */
- (Vector *)setNewY:(CGFloat)y;
/*!
 Creates a new `Vector` object with the same coordinates as the receiver but
 with the new `z` coordinate.

 Since `Vector`s are immutable, this method acts like a setter for the `z`
 property but returns a new `Vector` instead.

 If the receiver has format `(a, b, c)`, the resulting `Vector` has format `(a,
 b, z)`.
 @param z The new value to set in the `z` coordinate.
 @return A new `Vector` object
 @see setNewX:
 @see setNewY:
 */
- (Vector *)setNewZ:(CGFloat)z;
@end
