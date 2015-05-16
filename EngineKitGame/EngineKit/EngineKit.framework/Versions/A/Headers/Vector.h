// TODO: Create a copy method for all exported classes.
// TODO: Make isEqual accept the same objects as initWithObject does.
// TODO: Test rotation for non normalized vectors


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
 Represents a tuple of three `CGFloats`, here named `x`, `y` and `z`.
 */
@interface Vector : NSObject <VectorExport>


///-----------------------------------------------------------------------------
/// @name Getting the Vector's information
///-----------------------------------------------------------------------------
#pragma mark - Getting the Vector's information

/// The `Vector`'s `x` component.
@property (nonatomic, readonly) CGFloat x;
/// The `Vector`'s `y` component.
@property (nonatomic, readonly) CGFloat y;
/// The `Vector`'s `z` component.
@property (nonatomic, readonly) CGFloat z;


///-----------------------------------------------------------------------------
/// @name Common Vector constants
///-----------------------------------------------------------------------------
#pragma mark - Common Vector constants

/*!
 Represents a commonly used Vector, (0 0 0)
 @return A `Vector` object.
 */
+ (instancetype)origin;


///-----------------------------------------------------------------------------
/// @name Creating Vector objects
///-----------------------------------------------------------------------------
#pragma mark - Creating Vector objects

/*!
 Creates a `Vector` based on the given object.

 The supported objects are:

 - `NSNumber`, which will be initialized just like `initUniformWithNumber:`.
 - `NSArray`, which will be initialized just like `initWithArray:`.
 - `NSValue` containing a `SCNVector3`, which will be initialized just like
 `initWithSCNVector3:`.
 - `Vector` (or any of its subclassses), which will be initialized just like
 `initWithVector:`.
 - `NSString`, which will be initialized just like `initWithString:`.
 - `NSDictionary`, which will be initialized just like `initWithDictionary:`.

 @warning In case the object isn't a subclass of any of the above classes, an
 `assert(false)` will be triggered.

 @param object An object of any one of the classes mentioned above.
 @return An initialized `Vector` object.
 */
+ (Vector *)vectorWithObject:(id)object;
/*!
 Creates a `Vector` whith the three given components, respectively.
 @param x The value to assign to the `Vector`'s `x` component.
 @param y The value to assign to the `Vector`'s `y` component.
 @param z The value to assign to the `Vector`'s `z` component.
 @return An initialized `Vector` object.
 */
+ (Vector *)vectorWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z;
/*!
 Creates a `Vector` in which all components are set to `s`. Useful for creating
 `Vector`s that represent uniform scales.
 @param s The value to set to all the `Vector`'s components.
 @return An initialized `Vector` object.
 */
+ (Vector *)vectorWithUniformWithNumber:(CGFloat)s;
/*!
 Given a `CGPoint` of format `(x, y)`, creates a `Vector` object of format `(x,
 - y, 0)`. This is done to ease the translation from screen points to scene
 points.
 @param newValue The `CGPoint` that should be used as a model.
 @return An initialized `Vector` object.
 */
+ (Vector *)vectorWithCGPoint:(CGPoint)newValue;
/*!
 Creates a `Vector` in which all components are set as just as the first 3
 components (`x`, `y` and `z`) in the given `CIVector`.  This method trusts that
 the CIVector has been correctly initialized and has the  necessary components.

 Useful for obtaining a `Vector` through a `CIVector` initialization method.

 @param newValue The `CIValue` whose `x`, `y` and `z` components should be used.
 @return An initialized `Vector` object.
 */
+ (Vector *)vectorWithCIVector:(CIVector *)newValue;
/*!
 Creates a `Vector` in which all components are set as just as the given
 `SCNVector3`.
 @param newValue The `SCNVector3` that should be used as a model.
 @return An initialized `Vector` object.
 */
+ (Vector *)vectorWithSCNVector3:(SCNVector3)newValue;
/*!
 Creates a `Vector` in which all components are set as just as the first 3
 components in the given `SCNVector4`. If that `Vector` has format `(x y z w)`,
 the created `Vector` object will have format `(x y z)`.

 Useful for obtaining the axis of a rotation.

 @param newValue The `SCNVector4` whose first three components should be used.
 @return An initialized `Vector` object.
 */
+ (Vector *)vectorWithSCNVector4:(SCNVector4)newValue;
/*!
 Creates a `Vector` based on the first three elements on a given `NSArray`. If
 the array has less than 3 components or if any of the first three components is
 not an `NSNumber`, the corresponding value is set to zero.
 @param array The `NSArray` that should be used as a model.
 @return An initialized `Vector` object.
 */
+ (Vector *)vectorWithArray:(NSArray *)array;
/*!
 Creates a `Vector` based on the elements on a given NSDictionary. If there are
 elements with the key "x", "y" and "z" (case insensitive), those elements are
 used. If one of them is missing, the keys "0", "1" or "2" are used to replace
 them as needed. If any elements are still missing, the corresponding value is
 set to 0.0.
 @param dictionary The `NSDictionary` that should be used as a model.
 @return An initialized `Vector` object.
 */
+ (Vector *)vectorWithDictionary:(NSDictionary *)dictionary;
/*!
 Attempts to create a `Vector` by scanning the string for numbers. Each number
 found is inserted into an `NSArray`, and then the `initWithArray:` method is
 used.
 @param string The `NSString` to use as a model.
 @return An initialized `Vector` object.
 */
+ (Vector *)vectorWithString:(NSString *)string;
/*!
 Returns the given `Vector` object. Used for completion and standardization by
 other methods.
 @param vector The `Vector` object that will be returned.
 @return A `Vector` object.
 */
+ (Vector *)vectorWithVector:(Vector *)vector;


///-----------------------------------------------------------------------------
/// @name Initializing Vector objects
///-----------------------------------------------------------------------------
#pragma mark - Initializing Vector objects
/*!
 Initializes a `Vector` whith the three given components, respectively.
 @param x The value to assign to the `Vector`'s `x` component.
 @param y The value to assign to the `Vector`'s `y` component.
 @param z The value to assign to the `Vector`'s `z` component.
 @return An initialized `Vector` object.
 */
- (instancetype)initWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z;
/*!
 Initializes a `Vector` in which all components are set to `s`. Useful for
 creating `Vector`s that represent uniform scales.
 @param s The value to set to all the `Vector`'s components.
 @return An initialized `Vector` object.
 */
- (instancetype)initUniformWithNumber:(CGFloat)s;
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
 */
- (instancetype)initWithSCNVector3:(SCNVector3)newValue;
/*!
 Initializes a `Vector` in which all components are set as just as the first 3
 components in the given `SCNVector4`. If that `Vector` has format `(x y z w)`,
 the created `Vector` object will have format `(x y z)`.

 Useful for obtaining the axis of a rotation.

 @param newValue The `SCNVector4` whose first three components should be used.
 @return An initialized `Vector` object.
 */
- (instancetype)initWithSCNVector4:(SCNVector4)newValue;
/*!
 Initializes a `Vector` based on the first three elements on a given `NSArray`.
 If the array has less than 3 components or if any of the first three components
 is not an `NSNumber`, the corresponding value is set to zero.
 @param array The `NSArray` that should be used as a model.
 @return An initialized `Vector` object.
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
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
/*!
 Attempts to initialize a `Vector` by scanning the string for numbers. Each
 number found is inserted into an `NSArray`, and then the `initWithArray:`
 method is used.
 @param string The `NSString` to use as a model.
 @return An initialized `Vector` object.
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

 - `NSNumber`, which will be initialized just like `initUniformWithNumber:`.
 - `NSArray`, which will be initialized just like `initWithArray:`.
 - `NSValue` containing a `SCNVector3`, which will be initialized just like
 `initWithSCNVector3:`.
 - `Vector` (or any of its subclassses), which will be initialized just like
 `initWithVector:`.
 - `NSString`, which will be initialized just like `initWithString:`.
 - `NSDictionary`, which will be initialized just like `initWithDictionary:`.

 @warning In case the object isn't a subclass of any of the above classes, an
 `assert(false)` will be triggered.

 @param object An object of any one of the classes mentioned above.
 @return An initialized `Vector` object.
 */
- (instancetype)initWithObject:(id)object;


///-----------------------------------------------------------------------------
/// @name Extracting data
///-----------------------------------------------------------------------------
#pragma mark - Extracting data

/*!
 Creates an `SCNVector3` with the same components as the `Vector`.
 @return An initialized `SCNVector3`.
 */
- (SCNVector3)toSCNVector3;
/*!
 Creates an `NSValue` containing an `SCNVector3` with the same components as the
 `Vector`.
 @return An instance of `NSValue`.
 */
- (NSValue *)toNSValue;


///-----------------------------------------------------------------------------
/// @name Comparing objects
///-----------------------------------------------------------------------------
#pragma mark - Comparing objects

/*!
 Compares the receiver with another `Vector` for equality by testing if all
 their components are equal.
 @param object An object used to initialize a `Vector` by calling
 `vectorWithObject:`. The resulting `Vector` will then be compared to the
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
 Returns a `Vector` representing a multiplication of this `Vector`, of format
 `(x, y, z)`, by a scalar `a`, resulting in a `Vector` of format `(a*x, a*y,
 a*z)`.
 @param scalar The scalar value by which to multiply the `Vector`.
 @return A new instance of a `Vector` object.
 */
- (Vector *)times:(CGFloat)scalar;
/*!
 Returns a `Vector` representing a division of this `Vector`, of format `(x, y,
 z)`, by a scalar `a`, resulting in a `Vector` of format `(x/a, y/a, z/a)`.
 @param scalar The scalar value by which to divide the `Vector`.
 @return A new instance of a `Vector` object.
 */
- (Vector *)over:(CGFloat)scalar;
/*!
 Returns a `Vector` representing a sum of this `Vector`, of format `(x, y, z)`,
 by another `Vector` of format (a, b, c), resulting in a `Vector` of format `(a
 + x, b + y, c + z)`.
 @param object An object, used to initialize a new `Vector` using the
 `vectorWithObject:` method. The resulting `Vector` is then used in the
 addition.
 @return A new instance of a `Vector` object.
 */
- (Vector *)plus:(id)object;
/*!
 Returns a `Vector` representing a subtraction of another `Vector`, of format
 `(a, b, c)`, from this `Vector` of format `(x, y, z)`, resulting in a `Vector`
 of format `(x - a, y - b, z - c)`.
 @param object An object, used to initialize a new `Vector` using the
 `vectorWithObject:` method. The resulting `Vector` is then used in the
 subtraction.
 @return A new instance of a `Vector` object.
 */
- (Vector *)minus:(id)object;
/*!
 Takes the receiver, of format `(x, y, z)`, and returns its opposite, of format
 `(- x, - y, - z)`.
 @return A new instance of a `Vector` object.
 */
- (Vector *)opposite;
/*!
 Returns the dot product (which is a scalar value) of the receiver `Vector`,
 which has format `(x, y, z)`, with another `Vector` of format `(a, b, c)`,
 resulting the number given by `x*a + y*b + z*c`.
 @param object An object, used to initialize a new `Vector` using the
 `vectorWithObject:` method. The resulting `Vector` is then used in the dot
 product.
 @return The value of the dot product between the two vectors.
 */
- (CGFloat)dot:(id)object;
/*!
 Returns the squared norm of this `Vector`, which has format `(x, y, z)`. The
 norm is the same as the dot product of this vector with itself: `x*x + y*y +
 z*z`.

 Useful to compare the magnitude of different vectors without having the
 performance hit of a squared root (as the `norm` method does).
 @return The squared value of the `Vector`'s norm.
 */
- (CGFloat)normSquared;
/*!
 Returns the norm of this `Vector`, which has format `(x, y, z)`. The norm is
 the same as the square root of the dot product of this vector with itself:
 `sqrt(x*x + y*y + z*z)`.

 @warning This method might involve a performance hit from taking the squared
 root if used in a tight loop; use the `squaredNorm` method instead whenever
 possible.
 @return The value of the `Vector`'s norm.
 */
- (CGFloat)norm;
/*!
 Creates a new `Vector` as a result of changing receiver's components uniformly,
 scaling them so that the resulting `Vector` object has a norm of 1.

 @warning This method might involve a performance hit from taking the squared
 root if used in a tight loop, so use only when necessary.
 @return A new instance of a `Vector` object.
 */
- (Vector *)normalize;
/*!
 Creates a new `Vector`, using the receiver as a translation vector to translate
 the given `Vector` object.
 @param object An object, used to initialize a new `Vector` using the
 `vectorWithObject:` method. The resulting `Vector` is then translated.
 @return A new intance of a `Vector` object.
 */
- (Vector *)translate:(id)object;
/*!
 Creates a new `Vector`, by scaling the receiver by the appropriate amount,
 given by `scale`.
 @param scale The amount by which to scale the receiver.
 @return A new intance of a `Vector` object.
 */
- (Vector *)scale:(CGFloat)scale;
/*!
 The receiver applies the translation it represents to the receiving
 `SCNMatrix4`, and then returns the result.
 @param matrix The matrix to translate.
 @return A new `SCNMatrix4`, representing the result of the translation of the
 original matrix.
 */
- (SCNMatrix4)translateMatrix:(SCNMatrix4)matrix;
/*!
 The receiver applies the scale it represents to the receiving `SCNMatrix4`, and
 then returns the result.
 @param matrix The matrix to scale.
 @return A new `SCNMatrix4`, representing the result of scaling the original
 matrix.
 */
- (SCNMatrix4)scaleMatrix:(SCNMatrix4)matrix;
@end
