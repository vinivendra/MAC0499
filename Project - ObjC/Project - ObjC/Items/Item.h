

/*!
 An "abstract" superclass for all graphic items. This includes anything that
 could be in the game world - from objects and meshes to lights, cameras, etc.
 Basically, it's a wrapper for @p SCNNode.
 */
@interface Item : NSObject
/// The node that this Item is wrapping.
@property (nonatomic, strong) SCNNode *node;
/*!
 An alias for this Item's node's position. The object itself is a Position
 object. The setter accepts any object valid for the Position's  @p
 -initWithObject: method, including a Position object that may be initialized in
 other ways. The getter always returns a Position object. Attempting to set an
 invalid object triggers an @p assert(false).
 */
@property (nonatomic, strong) id position;
/*!
 An alias for this Item's node's rotation. The object itself is a Rotation
 object. The setter accepts any object valid for the Rotation's  @p
 -initWithObject: method, including a Rotation object that may be initialized in
 other ways. The getter always returns a Rotation object. Attempting to set an
 invalid object triggers an @p assert(false).
 */
@property (nonatomic, strong) id rotation;
/*!
 An alias for this Item's node's scale. The object itself is a Vector object.
 The setter accepts any object valid for the Vector's  @p -initWithObject:
 method, including a Vector object that may be initialized in other ways. The
 getter always returns a Vector object. Attempting to set an invalid object
 triggers an @p assert(false).
 */
@property (nonatomic, strong) id scale;
/*!
 An alias for this Item's node's geometry.
 */
@property (nonatomic, strong) SCNGeometry *geometry;

/*!
 Used as a constructor for JavaScript. Creates an empty Item, with an empty
 node.
 @return An empty Item.
 */
+ (instancetype)create;
@end
