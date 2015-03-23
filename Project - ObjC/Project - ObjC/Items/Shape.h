

#import "Item.h"


/*!
 An abstract subclass of @p Item, representing geometric objects. All physical
 visible objects, such as @p Spheres and @p Boxes, are subclasses of @p Shape.
 */
@interface Shape : Item
/*!
 An easy setter for the @p Shape's @p node's  @p geometry's @p materials. It
 creates an @p SCNMaterial and sets it as the @p geometry's only @p material, so
 that the object will have the given @p color. It accepts any object that would
 be accepted by @p Color's  @p +colorWithObject: method. The getter should never
 be used, since there is no guarantee the geometry's materials will still be
 colors.
 */
@property (nonatomic, strong) id color;
@end
