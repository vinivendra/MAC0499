

#import <UIKit/UIKit.h>


typedef UIColor Color;


@interface UIColor (Extension)
/*!
 * Initializes a UIColor based on the given object. The supported types are:
 *
 * - UIColor, which creates a copy the color.
 *
 * - NSString, which works a lot like -colorWithName.
 *
 * - NSArray, which works a lot like -colorWithArray.
 *
 * - NSNumber, which works a lot like -colorWithWhite.
 *
 * @warning If the color isn't a subclass of any of the accepted classes, an @p
 * assertion is triggered.
 * @param object The object from which to get the information for creating the
 * color.
 * @return An initialized UIColor.
 */
+ (Color *)colorWithObject:(id)object;
/*!
 * Creates a color with a given C array of floats. The array must have at least 4
 * components which will be used as red, green, blue and alpha, in that order.
 * @param array The array from which to get the values for the color.
 * @return An initialized UIColor instance.
 */
+ (Color *)colorWithCArray:(CGFloat[4])array;
/*!
 * Creates a color with a given NSArray. The array must have from 1 to 4
 * NSNumbers.
 *
 * - If there is 1 number only, it will be used as a white component (as in @p
 * -colorwithWhite).
 *
 * - If there are 2 numbers, the first one will be used as a white component and
 * the second one as an alpha value.
 *
 * - If there are 3 numbers, they will be used as RGB.
 *
 * - If here are 4 numbers, they will be used as RGB and alpha, in that order.
 *
 * @param array The array from which to get the values for the color.
 * @return An initialized UIColor instance.
 */
+ (Color *)colorWithArray:(NSArray *)array;
/*!
 * Creates a color based on a given name, such as "orange", "green", "lightGray",
 * etc. The accepted names are the same as the corresponding class methods of
 * UIColor.
 * @param name The name of the desired color.
 * @return An initialized UIColor instance.
 */
+ (Color *)colorWithName:(NSString *)name;
/*!
 * Multiplies the Red, Green and Blue components of the color by the given scalar
 * number. The alpha value is left untouched.
 * @param scalar The number by which to multiply the color's components.
 * @return A new color corresponding to the multiplicaton result.
 */
- (Color *)times:(CGFloat)scalar;
@end
