
#import "Vector.h"

@protocol AxisExport <JSExport>
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
- (instancetype)initWithX:(CGFloat)x Y:(CGFloat)y Z:(CGFloat)z;
- (instancetype)initWithSCNVector:(SCNVector3)newValue;
- (instancetype)initWithCIVector:(CIVector *)newValue;
- (instancetype)initWithVector:(Vector *)vector;
- (instancetype)initWithArray:(NSArray *)array;

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
@end
