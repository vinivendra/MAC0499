
#import "Vector.h"

@protocol AxisExport <JSExport>
@property (nonatomic, readonly) CGFloat x;
@property (nonatomic, readonly) CGFloat y;
@property (nonatomic, readonly) CGFloat z;

+ (instancetype)origin;
- (instancetype)initWithObject:(id)object;
- (BOOL)isEqualToVector:(SCNVector3)vector;

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

//
- (instancetype)initWithString:(NSString *)string;

+ (instancetype)x;
+ (instancetype)y;
+ (instancetype)z;
@end


/*!
 A representation of an axis (which is treated as an infinite vector and isn't
 necessarily x, y or z). Used mainly for Rotations.
 */
@interface Axis : Vector <AxisExport>

///-----------------------------------------------------------------------------
/// @name Common Axis constants
///-----------------------------------------------------------------------------
#pragma mark - Common Axis constants

/*!
 The default x Axis, represented by (1 0 0).
 @return An initialized Axis.
 */
+ (instancetype)x;
/*!
 The default y Axis, represented by (0 1 0).
 @return An initialized Axis.
 */
+ (instancetype)y;
/*!
 The default z Axis, represented by (0 0 1).
 @return An initialized Axis.
 */
+ (instancetype)z;


///-----------------------------------------------------------------------------
/// @name Creating Axis objects
///-----------------------------------------------------------------------------
#pragma mark - Creating Axis objects

/*!
 Creates a `Axis` whith the three given components, respectively.
 @param x The value to assign to the `Axis`'s `x` component.
 @param y The value to assign to the `Axis`'s `y` component.
 @param z The value to assign to the `Axis`'s `z` component.
 @return An initialized `Axis` object.
 */
+ (Axis *)axisWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z;
/*!
 Creates a `Axis` in which all components are set to `s`. Useful for
 creating `Axis`s that represent uniform scales.
 @param s The value to set to all the `Axis`'s components.
 @return An initialized `Axis` object.
 @see axisWithObject:
 */
+ (Axis *)axisWithUniformNumbers:(CGFloat)s;
/*!
 Creates a `Axis` in which all components are set as just as the first 3
 components (`x`, `y` and `z`) in the given `CIVector`.  This method trusts that
 the CIVector has been correctly initialized and has the  necessary components.

 Useful for obtaining a `Axis` through a `CIVector` initialization method.

 @param newValue The `CIValue` whose `x`, `y` and `z` components should be used.
 @return An initialized `Axis` object.
 */
+ (Axis *)axisWithCIVector:(CIVector *)newValue;
/*!
 Creates a `Axis` in which all components are set as just as the given
 `SCNVector3`.
 @param newValue The `SCNVector3` that should be used as a model.
 @return An initialized `Axis` object.
 @see axisWithNSValue:
 @see axisWithSCNVector4:
 */
+ (Axis *)axisWithSCNVector3:(SCNVector3)newValue;
/*!
 Creates a `Axis` in which all components are set as just as the first 3
 components in the given `SCNVector4`. If that `Axis` has format `(x y z
 w)`, the created `Axis` object will have format `(x y z)`.
 @param newValue The `SCNVector4` whose first three components should be used.
 @return An initialized `Axis` object.
 @see axisWithSCNVector3:
 */
+ (Axis *)axisWithSCNVector4:(SCNVector4)newValue;
/*!
 Creates a `Axis` based on the `SCNVector3` contained in the given
 `NSValue`.

 @param newValue An `NSValue` created with an `SCNVector3`, which will be
 obtained using `SCNVector3Value`.
 @see [Vector initWithSCNVector3:]
 @see axisWithObject:
 */
+ (Axis *)axisWithNSValue:(NSValue *)newValue;
/*!
 Creates a `Axis` based on the first three elements on a given `NSArray`. If
 the array has less than 3 components or if any of the first three components is
 not an `NSNumber`, the corresponding value is set to zero.
 @param array The `NSArray` that should be used as a model.
 @return An initialized `Axis` object.
 @see axisWithObject:
 */
+ (Axis *)axisWithArray:(NSArray *)array;
/*!
 Creates a `Axis` based on the elements on a given NSDictionary. If there
 are elements with the key "x", "y" and "z" (case insensitive), those elements
 are used. If one of them is missing, the keys "0", "1" or "2" are used to
 replace them as needed. If any elements are still missing, the corresponding
 value is set to 0.0.
 @param dictionary The `NSDictionary` that should be used as a model.
 @return An initialized `Axis` object.
 @see axisWithObject:
 */
+ (Axis *)axisWithDictionary:(NSDictionary *)dictionary;
/*!
 Creates an Axis by scanning the string for numbers. If at least three numbers
 are found, the first three are used. Otherwise, scans the string for the
 characters x, y or z, and returns the corresponding axis.

 @warning If the Axis fails to find something useful in the string, an @p
 assert(false) is triggered.
 @param string The NSString in which to search for the information.
 @return The initialized Axis.
 */
+ (Axis *)axisWithString:(NSString *)string;
/*!
 Returns the given `Vector` object, cast to a `Axis`. Used for completion
 and standardization by other methods.
 @param vector The `Vector` object that will be returned.
 @return A `Axis` object.
 @see axisWithObject:
 */
+ (Axis *)axisWithVector:(Vector *)vector;
/*!
 Returns the given `Axis` object. Used for completion and standardization by
 other methods.
 @param axis The `Axis` object that will be returned.
 @return A `Axis` object.
 */
+ (Axis *)axisWithAxis:(Axis *)axis;
/*!
 Creates a `Axis` based on the given object.

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
 @return An initialized `Axis` object.
 @see [Vector initWithUniformNumbers:]
 @see [Vector initWithArray:]
 @see [Vector initWithSCNVector3:]
 @see [Vector initWithVector:]
 @see [Vector initWithDictionary:]
 @see [Axis initWithString:]
 */
+ (Axis *)axisWithObject:(id)object;

/*!
 Attempts to initialize an Axis by scanning the string for numbers. If at least
 three numbers are found, the first three are used. Otherwise, scans the string
 for the characters x, y or z, and returns the corresponding axis.

 @warning If the Axis fails to find something useful in the string, an @p
 assert(false) is triggered.
 @param string The NSString in which to search for the information.
 @return The initialized Axis.
 */
- (instancetype)initWithString:(NSString *)string;

@end
