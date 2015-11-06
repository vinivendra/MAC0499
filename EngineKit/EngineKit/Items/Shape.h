// TODO: Add size properties to the shapes

#import "Item.h"


/*!
 An abstract subclass of @p Item, representing geometric objects. All physical
 visible objects, such as @p Spheres and @p Boxes, are subclasses of @p Shape.
 */
@interface Shape : Item
// TODO: doc
- (NSArray <NSString *>*)numericProperties;
- (NSString *)stringForPhysicsBody;
/*!
 Similar to -copyInfoTo:, meant to be used in the same context. -copyInfoTo:
 copies information that should be available @b before subclasses can copy their
 info, while -copyPhysicsTo: copies the physics body, which should usually be
 the last thing. Ideally, a subclass of shape should have the following
 implementation (or something similar):
 @code
 - (Item *)deepCopy {
     Shape *newItem = [[self class] new];
     [self copyInfoTo:newItem];
     [super copyPhysicsTo:newItem];
     return newItem;
 }
 @endcode
 considering that the subclass's -copyInfoTo: method should follow convention
 and call its super's -copyInfoTo: method before doing anything else.
 @param item The item that will receive a copy of the receiver's physics
 properties.
 */
- (void)copyPhysicsTo:(Shape *)item;
/*!
 @group Physics
 */
/*!
 The physics body type for the given item. This property @b must be set after
 all the Shape's dimensions have been set. This means that after getting a @p
 physics object, the Shape's scale property (as well as others such as height,
 radius, etc) will be locked and will trigger assert's if set.
 Supports only NSStrings: "dynamic", "static" and "kinematic".
 @note The getter of this property returns the SCNNode's physicsBody, which may
 be queried for its @p type.
 */
@property (nonatomic, strong) id physics;
/*!
 An alias for this Shape's node's physicsBody property.
 */
@property (nonatomic, strong) SCNPhysicsBody *physicsBody;
/*!
 An alias for this Shape's node's physicsBody's velocity property. If the setter
 receives an NSNumber, it tries to scale the current velocity so that it has
 that norm. Otherwise, it tries to instantiate a Vector using the given object.
 The getter always returns a Vector object obtained from the physicsBody's
 original property.
 */
@property (nonatomic, strong) id velocity;
/*!
 An alias for this Shape's node's material property. Used mainly for storing and
 resetting the materials in JavaScript.
 */
@property (nonatomic, strong) id materials;
@end
