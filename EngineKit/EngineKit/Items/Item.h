

#ifndef Item_h
#define Item_h


#import "Common.h"

#import "Gestures.h"

#import "ActionCollection.h"

#import "Rotation.h"
#import "Position.h"


@class Item;


@protocol ItemExport <JSExport>
- (instancetype)create;
+ (instancetype)create;
- (instancetype)initAndAddToScene;
+ (instancetype) template;
- (void)addItem:(Item *)newItem;
- (void)rotate:(id)rotation;
- (void)rotate:(id)rotation around:(id)anchor;
@property (nonatomic, weak, readonly) Item *parent;
@property (nonatomic, strong) NSString *templateName;
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) id scale;
@property (nonatomic) BOOL isDefault;
@property (nonatomic) BOOL hidden;
- (void)setPositionX:(NSNumber *)newValue;
- (void)setPositionY:(NSNumber *)newValue;
- (void)setPositionZ:(NSNumber *)newValue;
- (void)setScaleX:(NSNumber *)newValue;
- (void)setScaleY:(NSNumber *)newValue;
- (void)setScaleZ:(NSNumber *)newValue;
- (void)setRotationX:(NSNumber *)newValue;
- (void)setRotationY:(NSNumber *)newValue;
- (void)setRotationZ:(NSNumber *)newValue;
- (void)setRotationA:(NSNumber *)newValue;
- (void)addPosition:(id)object;
- (void)addScale:(id)object;
- (NSNumber *)positionX;
- (NSNumber *)positionY;
- (NSNumber *)positionZ;
- (NSNumber *)scaleX;
- (NSNumber *)scaleY;
- (NSNumber *)scaleZ;
- (NSNumber *)rotationX;
- (NSNumber *)rotationY;
- (NSNumber *)rotationZ;
- (NSNumber *)rotationA;
- (void)addPositionX:(NSNumber *)newValue;
- (void)addPositionY:(NSNumber *)newValue;
- (void)addPositionZ:(NSNumber *)newValue;
- (void)addScaleX:(NSNumber *)newValue;
- (void)addScaleY:(NSNumber *)newValue;
- (void)addScaleZ:(NSNumber *)newValue;
- (void)addRotationX:(NSNumber *)newValue;
- (void)addRotationY:(NSNumber *)newValue;
- (void)addRotationZ:(NSNumber *)newValue;
- (void)addRotationA:(NSNumber *)newValue;
@end


/*!
 An "abstract" superclass for all graphic items. This includes anything that
 could be in the game world - from objects and meshes to lights, cameras, etc.
 Basically, it's a wrapper for @p SCNNode.
 */
@interface Item : NSObject <ItemExport>
// TODO: Documentation
// TODO: Add these to JSExport
- (void)setPositionX:(NSNumber *)newValue;
- (void)setPositionY:(NSNumber *)newValue;
- (void)setPositionZ:(NSNumber *)newValue;
- (void)setScaleX:(NSNumber *)newValue;
- (void)setScaleY:(NSNumber *)newValue;
- (void)setScaleZ:(NSNumber *)newValue;
- (void)setRotationX:(NSNumber *)newValue;
- (void)setRotationY:(NSNumber *)newValue;
- (void)setRotationZ:(NSNumber *)newValue;
- (void)setRotationA:(NSNumber *)newValue;

- (NSNumber *)positionX;
- (NSNumber *)positionY;
- (NSNumber *)positionZ;
- (NSNumber *)scaleX;
- (NSNumber *)scaleY;
- (NSNumber *)scaleZ;
- (NSNumber *)rotationX;
- (NSNumber *)rotationY;
- (NSNumber *)rotationZ;
- (NSNumber *)rotationA;

- (void)addPositionX:(NSNumber *)newValue;
- (void)addPositionY:(NSNumber *)newValue;
- (void)addPositionZ:(NSNumber *)newValue;
- (void)addScaleX:(NSNumber *)newValue;
- (void)addScaleY:(NSNumber *)newValue;
- (void)addScaleZ:(NSNumber *)newValue;
- (void)addRotationX:(NSNumber *)newValue;
- (void)addRotationY:(NSNumber *)newValue;
- (void)addRotationZ:(NSNumber *)newValue;
- (void)addRotationA:(NSNumber *)newValue;

- (void)addPosition:(id)object;
- (void)addScale:(id)object;

+ (NSMutableDictionary <NSString *, Item *> *)templates;
+ (Item *)templateNamed:(NSString *)name;
- (Item *)childItemWithName:(NSString *)string recursively:(BOOL)recursively;
- (NSString *)parserString;
- (NSString *)parserStringBasedOnTemplate:(Item *)template
                         withTemplateName:(BOOL)withTemplateName;
@property (nonatomic) BOOL hidden;
@property (nonatomic) BOOL isDefault;
@property (nonatomic, strong) NSString *templateName;
@property (nonatomic, strong) NSString *name;
- (instancetype) template;

@property (nonatomic, strong) ActionCollection *actionCollection;
- (void)addAction:(MethodAction *)action forKey:(NSString *)key;
- (NSMutableArray <MethodAction *> *)actionsForKey:(NSString *)key;

// Protected
- (NSMutableArray *)propertyStringsBasedOnTemplate:(Item *)template;
+ (void)registerTemplate:(Item *)template;

/*!
 Initializes the `Item` and adds it to the scene. Meant to be used by any
 subclasses' initializers that are exported to JavaScript.
 @return An initialized `Item`.
 */
- (instancetype)initAndAddToScene NS_DESIGNATED_INITIALIZER;
/*!
 Initializes the `Item` but does not add it to the scene.
 @return An initialized `Item`.
 */
- (instancetype)init NS_DESIGNATED_INITIALIZER;
/*!
 Used to create instances of templates, which are added to the scene.
 @return A deep copy of the item, which is basically an instance of the
 template.
 */
- (instancetype)create;
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
 Creates a deep copy of the receiver, including in it any relevant information.
 @return A new instance of Item, representing a copy of the receiver.
 */
@property (nonatomic, readonly, strong) Item *deepCopy;
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
 Creates a Rotation object from the given id object, then applies the resulting
 rotation to the receiver. The rotation is applied on top of the receiver's
 existing transform, so that it is concatenated on top of any existing rotations
 the receiver may have.
 @param rotation A Rotation object, representing the change that should be
 applied to the receiver.
 @see rotate:around:
 */
- (void)rotate:(id)rotation;
/*!
 Creates a Rotation object from the given id object, then applies the resulting
 rotation to the receiver. The rotation is applied on top of the receiver's
 existing transform, so that it is concatenated on top of any existing rotations
 the receiver may have. Moreover, the rotation is calculated around the given
 `anchor` point, as opposed to the `rotate:` method, which always rotates around
 the `Item`'s center.
 @param rotation A Rotation object, representing the change that should be
 applied to the receiver.
 @see rotate:
 */
- (void)rotate:(id)rotation around:(id)anchor;
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
@property (nonatomic, weak) Item *parent;
@end

#endif