

#import <UIKit/UIKit.h>


typedef UIColor Color;


@interface UIColor (Extension)
+ (Color *)colorWithObject:(id)object;
+ (Color *)colorWithCArray:(CGFloat[4])array;
+ (Color *)colorWithArray:(NSArray *)array;
- (Color *)times:(CGFloat)scalar;
@end
