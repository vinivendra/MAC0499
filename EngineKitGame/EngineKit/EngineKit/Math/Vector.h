// TODO: Create a copy method for all exported classes.
// TODO: Make isEqual accept the same objects as initWithObject does.
// TODO: Test rotation for non normalized vectors


#import <JavaScriptCore/JavaScriptCore.h>
#import <SceneKit/SceneKit.h>


@class Vector;


@protocol VectorExport <JSExport>
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
 Represents a tuple of three @p CGFloats, here named @p x, @p y and @p z.
 */
@interface Vector : NSObject <VectorExport>

/// The Vector's @p x component.
@property (nonatomic, readonly) CGFloat x;
/// The Vector's @p y component.
@property (nonatomic, readonly) CGFloat y;
/// The Vector's @p z component.
@property (nonatomic, readonly) CGFloat z;

/*!
 Represents a commonly used Vector, (0 0 0)
 @return An @p origin Vector object.
 */
+ (instancetype)origin;
/*!
 Creates a Vector in which all components are set to @p x. Useful for uniform
 scales.
 @param x The value to set to all the Vector's components.
 @return An initialized Vector object.
 */
- (instancetype)initUniformWithNumber:(CGFloat)x;
/*!
 Creates a Vector in which all components are set as specified: (x y z).
 @param x The Vector's first component.
 @param y The Vector's second component.
 @param z The Vector's third component.
 @return An initialized Vector object.
 */
- (instancetype)initWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z;
/*!
 Creates a Vector in which all components are set as just as the given
 SCNVector3.
 @param newValue The SCNVector3 that should be used as a model.
 @return An initialized Vector object.
 */
- (instancetype)initWithSCNVector:(SCNVector3)newValue;
/*!
 Creates a Vector in which x component is set as just as the given CGPoint's x
 component, the y component is the opposite of the CGPoint's y component and in
 which the z component is 0. This is done to ease the translation from screen
 points to scene points.
 @param newValue The CGPoint that should be used as a model.
 @return An initialized Vector object.
 */
- (instancetype)initWithCGPoint:(CGPoint)newValue;
/*!
 Creates a Vector in which all components are set as just as the first 3
 components in the given SCNVector4. If that vector is written as (x y z w), the
 created Vector object will be (x y z).

 Useful for obtaining the axis of a rotation, for instance.

 @param newValue The SCNVector4 whose first three components should be used.
 @return An initialized Vector object.
 */
- (instancetype)initWithSCNVector4:(SCNVector4)newValue;
/*!
 Creates a Vector in which all components are set as just as the first 3
 components (x, y and z) in the given CIVector.
 This method trusts that the CIVector has been correctly initialized and has the
 necessary components.

 Useful for obtaining a Vector through a CIVector initialization method.

 @param newValue The CIValue whose x, y and z components should be used.
 @return An initialized Vector object.
 */
- (instancetype)initWithCIVector:(CIVector *)newValue;
/*!
 Creates a Vector that is a copy of the given @p vector.
 @param vector The Vector object that should be copied.
 @return An initialized Vector object.
 */
- (instancetype)initWithVector:(Vector *)vector;
/*!
 Creates a Vector based on the first three elements on a given NSArray. If the
 array has less than 3 components or if any of the first three components is not
 an NSNumber, the corresponding value is set to zero.
 @param array The array to copy into the Vector.
 @return An initialized Vector object.
 */
- (instancetype)initWithArray:(NSArray *)array;
/*!
 Creates a Vector based on the elements on a given NSDictionary. If there are
 elements with the key "x", "y" and "z" (case insensitive), those elements are
 used. If one of them is missing, the corresponding "0", "1" or "2" is used
 instead. If any elements are still missing, the corresponding value is set to
 0.0.
 @param array The dictionary from which to get the information.
 @return An initialized Vector object.
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
/*!
 Attempts to initialize a Vector by scanning the string for numbers. Each number
 found is inserted into an array, and then the @p -initWithArray: method is
 used.

 @param string The NSString in which to search for the information.
 @return An initialized Vector object.
 */
- (instancetype)initWithString:(NSString *)string;
/*!
 Creates a Vector based on the given object. The supported objects are:
 - NSNumber, which will be initialized just like @p -initUniformWithNumber.
 - NSArray, which will be initialized just like @p -initWithArray.
 - NSValue containing a SCNVector3, which will be initialized just like @p
 -initWithSCNVector3.
 - Vector (or any of its subclassses), which will be initialized just like @p
 -initWithVector.
 - NSString, which will be initialized just like @p -initWithString.
 - NSDictionary, which will be initialized just like @p -initWithDictionary.

 @warning In case the object isn't a subclass of any of the above classes, an @p
 assert(false) will be triggered.

 @param object An object of any one of the classes mentioned above.
 @return An initialized Vector object.
 */
- (instancetype)initWithObject:(id)object;

/*!
 Creates a Vector in which all components are set to @p x. Useful for uniform
 scales.
 @param x The value to set to all the Vector's components.
 @return An initialized Vector object.
 */
+ (Vector *)vectorWithUniformWithNumber:(CGFloat)x;
/*!
 Creates a Vector in which all components are set as specified: (x y z).
 @param x The Vector's first component.
 @param y The Vector's second component.
 @param z The Vector's third component.
 @return An initialized Vector object.
 */
+ (Vector *)vectorWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z;
/*!
 Creates a Vector in which all components are set as just as the given
 SCNVector3.
 @param newValue The SCNVector3 that should be used as a model.
 @return An initialized Vector object.
 */
+ (Vector *)vectorWithSCNVector:(SCNVector3)newValue;
/*!
 Creates a Vector in which x component is set as just as the given CGPoint's x
 component, the y component is the opposite of the CGPoint's y component and in
 which the z component is 0. This is done to ease the translation from screen
 points to scene points.
 @param newValue The CGPoint that should be used as a model.
 @return An initialized Vector object.
 */
+ (Vector *)vectorWithCGPoint:(CGPoint)newValue;
/*!
 Creates a Vector in which all components are set as just as the first 3
 components in the given SCNVector4. If that vector is written as (x y z w), the
 created Vector object will be (x y z).

 Useful for obtaining the axis of a rotation, for instance.

 @param newValue The SCNVector4 whose first three components should be used.
 @return An initialized Vector object.
 */
+ (Vector *)vectorWithSCNVector4:(SCNVector4)newValue;
/*!
 Creates a Vector in which all components are set as just as the first 3
 components (x, y and z) in the given CIVector.
 This method trusts that the CIVector has been correctly initialized and has the
 necessary components.

 Useful for obtaining a Vector through a CIVector initialization method.

 @param newValue The CIValue whose x, y and z components should be used.
 @return An initialized Vector object.
 */
+ (Vector *)vectorWithCIVector:(CIVector *)newValue;
/*!
 Merely returns the given vector instead of creating a new one, for efficiency.
 @param vector The Vector object that will be returned.
 @return An initialized Vector object.
 */
+ (Vector *)vectorWithVector:(Vector *)vector;
/*!
 Creates a Vector based on the first three elements on a given NSArray. If the
 array has less than 3 components or if any of the first three components is not
 an NSNumber, the corresponding value is set to zero.
 @param array The array to copy into the Vector.
 @return An initialized Vector object.
 */
+ (Vector *)vectorWithArray:(NSArray *)array;
/*!
 Creates a Vector based on the elements on a given NSDictionary. If there are
 elements with the key "x", "y" and "z" (case insensitive), those elements are
 used. If one of them is missing, the corresponding "0", "1" or "2" is used
 instead. If any elements are still missing, the corresponding value is set to
 0.0.
 @param array The dictionary from which to get the information.
 @return An initialized Vector object.
 */
+ (Vector *)vectorWithDictionary:(NSDictionary *)dictionary;
/*!
 Attempts to initialize a Vector by scanning the string for numbers. Each number
 found is inserted into an array, and then the @p -initWithArray: method is
 used.

 @param string The NSString in which to search for the information.
 @return An initialized Vector object.
 */
+ (Vector *)vectorWithString:(NSString *)string;
/*!
 Creates a Vector based on the given object. The supported objects are:
 - NSNumber, which will be initialized just like @p -initUniformWithNumber.
 - NSArray, which will be initialized just like @p -initWithArray.
 - NSValue containing a SCNVector3, which will be initialized just like @p
 -initWithSCNVector3.
 - Vector (or any of its subclassses), which will be initialized just like @p
 -initWithVector.
 - NSString, which will be initialized just like @p -initWithString.
 - NSDictionary, which will be initialized just like @p -initWithDictionary.

 @warning In case the object isn't a subclass of any of the above classes, an @p
 assert(false) will be triggered.

 @param object An object of any one of the classes mentioned above.
 @return An initialized Vector object.
 */
+ (Vector *)vectorWithObject:(id)object;

/*!
 Returns @p YES if the Vector has the same components as the given @p vector, as
 determined by the @p SCNVector3EqualToVector3 function.
 @param vector The @p SCNVector3 used for comparison.
 @return @p YES if the components are all the same; @p NO otherwise.
 */
- (BOOL)isEqualToVector:(SCNVector3)vector;

/*!
 Creates an SCNVector3 with the same components as the Vector.
 @return An initialized SCNVector3.
 */
- (SCNVector3)toSCNVector;
/*!
 Creates an NSValue containing an SCNVector3 with the same components as the
 Vector.
 @return An instance of NSValue.
 */
- (NSValue *)toValue;

/*!
 Returns a Vector representing a multiplication of this Vector [x y z] by a
 scalar @p a: [a*x, a*y, a*z]
 @param scalar The scalar value by which to multiply the Vector.
 @return A new instance of a Vector object.
 */
- (Vector *)times:(CGFloat)scalar;
/*!
 Returns a Vector representing a division of this Vector [x y z] by a
 scalar @p a: [x/a, y/a, z/a]
 @param scalar The scalar value by which to divide the Vector.
 @return A new instance of a Vector object.
 */
- (Vector *)over:(CGFloat)scalar;
/*!
 Returns a Vector representing a sum of this Vector [x y z] by another Vector [a
 b c], resulting in [a+x  b+y  c+z].
 @param vector The other Vector to use in the addition.
 @return A new instance of a Vector object.
 */
- (Vector *)plus:(id)object;
/*!
 Returns a Vector representing a subtraction of another Vector [a b c] from this
 Vector [x y z], resulting in [x-a  y-b  z-c].
 @param vector The other Vector to use in the subtraction.
 @return A new instance of a Vector object.
 */
- (Vector *)minus:(id)object;
/*!
 Returns a Vector representing the opposite ([-x, -y, -z]) of the receiver ([x,
 y, z]).
 @return A new instance of a Vector object.
 */
- (Vector *)opposite;
/*!
 Returns the dot product (which is a scalar value) representing a dot product of
 this Vector [x y z] with another Vector [a b c], resulting in x*a + y*b + z*c.
 @param vector The other Vector to use in the dot product.
 @return The value of the dot product between the two vectors.
 */
- (CGFloat)dot:(id)object;
/*!
 Returns the squared norm of this Vector [x y z], which is the same as the dot
 product of this vector with itself: x*x + y*y + z*z. Useful to compare the
 magnitude of different vectors without having the performance hit of a squared
 root (as the @p -norm method does).
 @return The squared value of the Vector's norm.
 */
- (CGFloat)normSquared;
/*!
 Returns the norm of this Vector [x y z], which is the same as the square root
 of the dot product of this vector with itself: sqrt(x*x + y*y + z*z). Might
 have a performance hit from taking the squared root if used in a tight loop;
 use the @p -squaredNorm method instead whenever possible.
 @return The value of the Vector's norm.
 */
- (CGFloat)norm;
/*!
 Creates a new Vector as a result of changing all this Vector's components
 uniformly, scaling them so that the resulting vector has a norm of 1. Might
 have a performance hit from taking the squared root if used in a tight loop, so
 use only when necessary.
 @return A new instance of a Vector object.
 */
- (Vector *)normalize;
/*!
 Creates a new vector, using the receiver as a translation vector to translate
 the given vector.
 @param vector The vector that will be translated.
 @return A new intance of a Vector object.
 */
- (Vector *)translate:(id)object;
/*!
 Creates a new vector, by scaling the receiver by the appropriate amount, given
 by @p scale.
 @param scale The amount by which to scale the receiver.
 @return A new intance of a Vector object.
 */
- (Vector *)scale:(CGFloat)scale;
/*!
 The receiver applies the translation it represents to the receiving SCNMatrix4,
 and then returns the result.
 @param matrix The matrix to translate.
 @return A new SCNMatrix4, representing the result of the translation of the
 original matrix.
 */
- (SCNMatrix4)translateMatrix:(SCNMatrix4)matrix;
/*!
 The receiver applies the scale it represents to the receiving SCNMatrix4, and
 then returns the result.
 @param matrix The matrix to scale.
 @return A new SCNMatrix4, representing the result of scaling the original
 matrix.
 */
- (SCNMatrix4)scaleMatrix:(SCNMatrix4)matrix;
@end
