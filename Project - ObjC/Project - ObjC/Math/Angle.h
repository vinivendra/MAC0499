

@class Angle;


@protocol AngleExport <JSExport>
+ (instancetype)create;
//
+ (instancetype)angleWithRadians:(CGFloat)radians;
+ (instancetype)angleWithDegrees:(CGFloat)degrees;
+ (instancetype)angleWithPiTimes:(CGFloat)ratio;
- (instancetype)initWithRadians:(CGFloat)radians;
- (instancetype)initWithDegrees:(CGFloat)degrees;
- (CGFloat)toRadians;
- (CGFloat)toDegrees;
@end

/*!
 Represents an Angle, usually for a Rotation. Used mostly for initialization and
 conversion. More efficient when used exclusively with radians, but not slow
 unless used in a very tight loop.
 */
@interface Angle : NSObject
/*!
 Creates an Angle object with the given value in radians.
 @param radians An angle measured in radians.
 @return An initialized Angle object.
 */
+ (instancetype)angleWithRadians:(CGFloat)radians;
/*!
 Creates an Angle object with the given value in degrees.
 @param degrees An angle measured in degrees.
 @return An initialized Angle object.
 */
+ (instancetype)angleWithDegrees:(CGFloat)degrees;
/*!
 Creates an Angle object with the value of @p ratio*pi, measured in radians.
 @param ratio The value used to multiply by pi.
 @return An initialized Angle object.
 */
+ (instancetype)angleWithPiTimes:(CGFloat)ratio;
/*!
 Creates an Angle object with the given value in radians.
 @param radians An angle measured in radians.
 @return An initialized Angle object.
 */
- (instancetype)initWithRadians:(CGFloat)radians;
/*!
 Creates an Angle object with the given value in degrees.
 @param degrees An angle measured in degrees.
 @return An initialized Angle object.
 */
- (instancetype)initWithDegrees:(CGFloat)degrees;
/*!
 Converts the value of the Angle to radians.
 @return The Angle's value, measured in radians.
 */
- (CGFloat)toRadians;
/*!
 Converts the value of the Angle to degrees.
 @return The Angle's value, measured in degrees.
 */
- (CGFloat)toDegrees;
@end
