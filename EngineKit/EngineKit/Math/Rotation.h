

#import "Axis.h"
#import "Angle.h"


@class Rotation;


@protocol RotationExport <JSExport>
+ (instancetype)create:(id)object;

- (Vector *)rotate:(id)vector;

- (CGFloat)x;
- (CGFloat)y;
- (CGFloat)z;
- (CGFloat)a;
- (Axis *)axis;
- (Angle *)angle;
@end


/*!
 Represents a rotation by a determined angle around a determined axis.
 */
@interface Rotation : NSObject <RotationExport>
///-----------------------------------------------------------------------------
/// @name Creating Rotation objects
///-----------------------------------------------------------------------------
+ (instancetype)create:(id)object;
#pragma mark - Creating Rotation objects
/*!
 Creates a Rotation of `angle` radians around the axis represented by `(x, y,
 z)`.
 @param x The `x` component of the axis around which to rotate.
 @param y The `y` component of the axis around which to rotate.
 @param z The `z` component of the axis around which to rotate.
 @param angle The `angle`, in radians, around which to rotate.
 @return An initialized Rotation object.
 */
- (instancetype)initWithX:(CGFloat)x
                        Y:(CGFloat)y
                        Z:(CGFloat)z
                    Angle:(CGFloat)angle NS_DESIGNATED_INITIALIZER;
/*!
 Creates a Rotation in which all components are set as just as the given
 SCNVector4. This initialization is a lot like @p -initWithArray.
 @param vector The SCNVector4 that should be used as a model.
 @return An initialized Rotation object.
 @see -initWithArray
 */
- (instancetype)initWithSCNVector4:(SCNVector4)vector;
/*!
 Creates a Rotation of @p angle radians around the given @p axis.
 @param axis  The Axis around which to rotate.
 @param angle The Angle by which to rotate.
 @return An initialized Rotation object.
 */
- (instancetype)initWithAxis:(Axis *)axis
                       angle:(Angle *)angle NS_DESIGNATED_INITIALIZER;
/*!
 Attempts to initialize a Vector by scanning the string for numbers. Each number
 found is inserted into an array, and then the @p -initWithArray: method is
 used.

 @param string The NSString in which to search for the information.
 @return An initialized Vector object.
 */
- (instancetype)initWithString:(NSString *)string;
/*!
 Creates a Rotation based on the given NSArray. Trusts that the array has enough
 (4 or more) components, and that the first 4 components may be cast into @p
 NSNumbers.

 The first 3 numbers are used to create an Axis, and the fourth represents the
 angle for the rotation. This is much like the SCNVector4s are used for
 rotation.

 @param array The array representing the rotation.
 @return An initialized Rotation object.
 */
- (instancetype)initWithArray:(NSArray *)array;
/*!
 Creates a Rotation based on the elements on a given NSDictionary. If there are
 elements with the key "x", "y" and "z"(case insensitive), those elements are
 used for the axis; "a" or "w" is used for the angle. If one of them is missing,
 the corresponding "0", "1" or "2" is used instead for the axis, and "3" for the
 angle. If any elements are still missing, the corresponding value is set to
 0.0.
 @param array The dictionary from which to get the information.
 @return An initialized Rotation object.
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
/*!
 Initializes the receiver to copy the given rotation, such that is has the same
 values for its axis and angle.
 @param rotation The rotation from which to copy information.
 @return An initialized Rotation object.
 */
- (instancetype)initWithRotation:(Rotation *)rotation;
/*!
 Creates a Rotation based on the given object. The supported objects are:

 - Rotation, which will create a copy of the given Rotation.

 - NSArray, which will be initialized just like @p -initWithArray.

 - NSValue containing a SCNVector4, which will be initialized just like @p
 -initWithSCNVector4.

 @warning In case the object isn't a subclass of any of the above classes, an @p
 assert(false) will be triggered.

 @param object An object of any one of the classes mentioned above.
 @return An initialized Rotation object.
 @see -initWithArray
 @see -initWithSCNVector4
 */
- (instancetype)initWithObject:(id)object;

///-----------------------------------------------------------------------------
/// @name Operations with Rotations
///-----------------------------------------------------------------------------
#pragma mark - Operations with Rotations

/*!
 The receiver applies the rotation it represents to the receiving SCNMatrix4,
 and then returns the result.
 @param matrix The matrix to rotate.
 @return A new SCNMatrix4, representing the result of the rotation of the
 original matrix.
 */
- (SCNMatrix4)rotateMatrix:(SCNMatrix4)matrix;
/*!
 Creates a new `Vector` from the given `object` by calling `[Vector
 initWithObject:]`.
 That `Vector` is then rotated by the rotation that the receiver represents.

 @param object An object, used to initialize a new `Vector` to be rotated.
 @return A new intance of a `Vector` object.
 */
- (Vector *)rotate:(id)vector;

///-----------------------------------------------------------------------------
/// @name Getting the Rotation's information
///-----------------------------------------------------------------------------
#pragma mark - Getting the Rotation's information
/*!
 Returns a representation of the Rotation as an SCNVector4. The Rotation's Axis
 will be represented in the first three components (x y z), while the angle will
 be in the last component (w). This is the most common representation, ready to
 be used with SceneKit.
 @return An initialized SCNVector4.
 */
@property (nonatomic, readonly) SCNVector4 toSCNVector;
/*!
 Returns an SCNMatrix4 representing the same rotation as the receiver.
 @return An initialized SCNMatrix4.
 */
@property (nonatomic, readonly) SCNMatrix4 toSCNMatrix;
/*!
 The x component of the axis around which the rotation is being done.
 */
@property (nonatomic, readonly) CGFloat x;
/*!
 The y component of the axis around which the rotation is being done.
 */
@property (nonatomic, readonly) CGFloat y;
/*!
 The z component of the axis around which the rotation is being done.
 */
@property (nonatomic, readonly) CGFloat z;
/*!
 The value of the angle by which the rotation is being done, in radians.
 */
@property (nonatomic, readonly) CGFloat a;
/*!
 The axis around which the rotation is being done.
 */
@property (nonatomic, readonly, strong) Axis *axis;
/*!
 The angle by which the rotation is being done.
 */
@property (nonatomic, readonly, strong) Angle *angle;
@end
