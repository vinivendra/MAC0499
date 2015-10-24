

#import "Shape.h"


@protocol BoxExport <JSExport>
- (instancetype)initAndAddToScene;
- (instancetype)create;
+ (instancetype)create;
+ (instancetype) template;
- (void)addItem:(Item *)newItem;
- (void)rotate:(id)rotation;
@property (nonatomic, weak, readonly) Item *parent;
@property (nonatomic, strong) NSString *templateName;
@property (nonatomic, strong) id materials;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) id scale;
@property (nonatomic) BOOL isDefault;
@property (nonatomic) BOOL isTemplateBase;
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
//
@property (nonatomic, strong) id color;
@property (nonatomic, strong) id physics;
@property (nonatomic, strong) id velocity;
//
+ (instancetype)box;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) NSNumber *length;
@property (nonatomic, strong) NSNumber *chamferRadius;
@end


/*!
 A paralelepiped, with specificiable width, length and height. The edges and
 vertices of the Box's geometry may also be rounded with the @p chamferRadius
 property. Essentially, a wrapper for @p SCNBox.
 */
@interface Box : Shape <BoxExport>
/*!
 Creates a new instance of @p Box, with the default measures set by @p SCNBox,
 which create a cube with no chamfer.
 @return a new instance of @p Box.
 */
+ (instancetype)box;

/*!
 An alias for the SCNBox's @p width property. Speficies the size of the box
 along its @p x axis.
 */
@property (nonatomic, strong) NSNumber *width;
/*!
 An alias for the SCNBox's @p height property. Speficies the size of the box
 along its @p y axis.
 */
@property (nonatomic, strong) NSNumber *height;
/*!
 An alias for the SCNBox's @p length property. Speficies the size of the box
 along its @p z axis.
 */
@property (nonatomic, strong) NSNumber *length;
/*!
 An alias for the SCNBox's @p chamferRadius property. Speficies the radius to
 use when rounding both the edges and the vertices of the Box.
 */
@property (nonatomic, strong) NSNumber *chamferRadius;
@end
