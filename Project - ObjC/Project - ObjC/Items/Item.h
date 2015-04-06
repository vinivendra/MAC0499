

/*!
 An "abstract" superclass for all graphic items. This includes anything that
 could be in the game world - from objects and meshes to lights, cameras, etc.
 Basically, it's a wrapper for @p SCNNode.
 */
@interface Item : NSObject

/*!
 Used as a constructor for JavaScript. Creates an empty Item, with an empty
 node, and adds the node to the scene.
 @return An empty Item.
 */
+ (instancetype)create;
/*!
 Creates a template for the creation of new items. Equivalent to creating a new
 Item, but that Item isn't added to the scene.
 @return An empty Item.
 */
+ (instancetype) template;
/*!
 Creates a new unique ID to be used by a new instance of Item.
 @return A new ID.
 */
+ (NSUInteger)newID;
/*!
 @warning Must be called whenever an item should disappear, since Items and
 their Nodes
 create retain-cycles.
 This method removes the Item's Node (and all its subnodes) from the Scene Graph
 and readies the Item for destruction.
 */
- (void)destroy;
/*!
 Creates a deep copy of the receiver, including in it any relevant information.
 @return A new instance of Item, representing a copy of the receiver.
 */
- (Item *)deepCopy;
/*!
 Copies relevant information from the receiver to the given item. Used by
 deepCopy to copy the actual information over.
 @param item The new Item object, into which all copied information will be
 written.
 */
- (void)copyInfoTo:(Item *)item;
/*!
 Adds a child item to the receiver's hierarchy, just as a child node would be.
 @param newItem The child Item to be added.
 */
- (void)addItem:(Item *)newItem;
/*!
 Removes the receiver from its parent's hierarchy, just like a node.
 */
- (void)removeFromParent;
/*!
 An integer used to uniquely identify an Item.
 */
@property (nonatomic) NSUInteger ID;
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
 The item's child items, which are equivalent to a node's child nodes. Should
 not be handled manually; use @p addItem and @p removeFromParent instead.
 */
@property (nonatomic, strong, readonly) NSMutableArray *children;
/*!
 The item's parent item, equivalent to a node's parent node.
 */
@property (nonatomic, weak, readonly) Item *parent;
@end
