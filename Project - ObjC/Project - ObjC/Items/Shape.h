

#import "Item.h"


/*!
 An abstract subclass of @p Item, representing geometric objects. All physical
 visible objects, such as @p Spheres and @p Boxes, are subclasses of @p Shape.
 */
@interface Shape : Item
/*!
 Used internally to make sure the Shape's dimensions won't change after we've
 already calculated the physics information.
 */
- (void)assertTheresNoPhysicsBody;
/*!
 An easy setter for the @p Shape's @p node's  @p geometry's @p materials. It
 creates an @p SCNMaterial and sets it as the @p geometry's only @p material, so
 that the object will have the given @p color. It accepts any object that would
 be accepted by @p Color's  @p +colorWithObject: method. The getter should never
 be used, since there is no guarantee the geometry's materials will still be
 colors.
 */
@property (nonatomic, strong) id color;
/*!
 @group Physics
 */
/*!
 The physics body type for the given item. This property @b must be set after
 all the Shape's dimensions have been set. This means that after getting a @p
 physics object, the Shape's scale property (as well as others such as height,
 radius, etc) will be locked and will trigger assert's if set.
 @note The getter of this property returns the SCNNode's physicsBody, which may
 be queried for its @p type.
 */
@property (nonatomic, strong) id physics;

/*!
 An alias for this Shape's SCNNode's physicsBody property.
 */
@property (nonatomic, strong) SCNPhysicsBody *physicsBody;
@end
