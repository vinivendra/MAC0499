

#import <Foundation/Foundation.h>


@interface Angle : NSObject
+ (instancetype)angleWithRadians:(CGFloat)radians;
+ (instancetype)angleWithDegrees:(CGFloat)degrees;
+ (instancetype)angleWithPiTimes:(CGFloat)ratio;
- (instancetype)initWithRadians:(CGFloat)radians;
- (instancetype)initWithDegrees:(CGFloat)degrees;
- (CGFloat)toRadians;
- (CGFloat)toDegrees;
@end
