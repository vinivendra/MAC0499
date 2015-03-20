// TODO: Make the vector property protected
// TODO: init with string (@"[0, 2, 3]")
// TODO: init with dictionary
// TODO: Create a copy method for all exported classes.
// TODO: Make isEqual accept the same objects as initWithObject does.
// TODO: Test rotation for non normalized vectors
// TODO: Create standard arithmetic methods, including norm, normalization,
// vector product and dot product.

@class Vector;


@protocol VectorExport <JSExport>
@property (nonatomic, readonly) CGFloat x;
@property (nonatomic, readonly) CGFloat y;
@property (nonatomic, readonly) CGFloat z;

+ (instancetype)origin;
- (instancetype)initUniformWithNumber:(CGFloat)x;
- (instancetype)initWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z;
- (instancetype)initWithSCNVector:(SCNVector3)newValue;
- (instancetype)initWithSCNVector4:(SCNVector4)newValue;
- (instancetype)initWithCIVector:(CIVector *)newValue;
- (instancetype)initWithVector:(Vector *)vector;
- (instancetype)initWithArray:(NSArray *)array;
- (instancetype)initWithObject:(id)object;
- (BOOL)isEqualToVector:(SCNVector3)vector;
- (SCNVector3)toSCNVector;
@end


/*!
 Represents a tuple of three @p CGFloats, here named @p x, @p y and @p z.
 */
@interface Vector : NSObject <VectorExport>
/*!
 The Vector class's inner representation of a vector. Meant to be used only by
 subclasses; use @p -toSCNVector instead.
 */
@property (nonatomic) SCNVector3 vector;

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
 Creates a vector in which all components are set to @p x. Useful for uniform
 scales.
 @param x The value to set to all the Vector's components.
 @return An initialized Vector object.
 */
- (instancetype)initUniformWithNumber:(CGFloat)x;
/*!
 Creates a vector in which all components are set as specified: (x y z).
 @param x The Vector's first component.
 @param y The Vector's second component.
 @param z The Vector's third component.
 @return An initialized Vector object.
 */
- (instancetype)initWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z;
/*!
 Creates a vector in which all components are set as just as the given
 SCNVector3.
 @param newValue The SCNVector3 that should be used as a model.
 @return An initialized Vector object.
 */
- (instancetype)initWithSCNVector:(SCNVector3)newValue;
/*!
 Creates a vector in which all components are set as just as the first 3
 components in the given SCNVector4. If that vector is written as (x y z w), the
 created Vector object will be (x y z).

 Useful for obtaining the axis of a rotation, for instance.

 @param newValue The SCNVector4 whose first three components should be used.
 @return An initialized Vector object.
 */
- (instancetype)initWithSCNVector4:(SCNVector4)newValue;
/*!
 Creates a vector in which all components are set as just as the first 3
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
 Creates a Vector based on the given NSArray. Trusts that the array has enough
 (3 or more) components, and that the first 3 components may be cast into @P
 NSNumbers.
 @param array The array to copy into the Vector.
 @return An initialized Vector object.
 */
- (instancetype)initWithArray:(NSArray *)array;
/*!
 Creates a Vector based on the given object. The supported objects are:
 - NSNumber, which will be initialized just like @p -initUniformWithNumber.
 - NSArray, which will be initialized just like @p -initWithArray.
 - NSValue containing a SCNVector3, which will be initialized just like @p
 -initWithSCNVector3.
 - Vector (or any of its subclassses, which will be initialized just like @p
 -initWithVector.

 @warning In case the object isn't a subclass of any of the above classes, an @p
 assert(false) will be triggered.

 @param object An object of any one of the classes mentioned above.
 @return An initialized Vector object.
 */
- (instancetype)initWithObject:(id)object;

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
@end
