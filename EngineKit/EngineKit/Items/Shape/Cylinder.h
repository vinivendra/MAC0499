

#import "Shape.h"


@protocol CylinderExport <JSExport>
- (instancetype)initAndAddToScene;
- (instancetype)create;
+ (instancetype)create;
+ (instancetype) template;
- (void)addItem:(Item *)newItem;
- (void)rotate:(id)rotation;
@property (nonatomic, weak, readonly) Item *parent;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) id materials;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) id scale;
@property (nonatomic) BOOL isDefault;
@property (nonatomic) BOOL hidden;
//
@property (nonatomic, strong) id color;
@property (nonatomic, strong) id physics;
@property (nonatomic, strong) id velocity;
//
+ (instancetype)cylinder;
@property (nonatomic) NSNumber *radius;
@property (nonatomic) NSNumber *height;
@end


/*!
 A cylinder, with speficiable height and radius.
 */
@interface Cylinder : Shape <CylinderExport>
/*!
 Creates a new instance of @p Cylinder, with the default measures set by @p
 SCNCylinder.
 @return a new, default instance of @p Cylinder.
 */
+ (instancetype)cylinder;

/*!
 An alias for the SCNCylinder's @p radius property. Speficies the radius used
 for the Cylinder's circular bases, aligned with the @p xz plane and centered in
 the origin.
 @see height
 */
@property (nonatomic) NSNumber *radius;
/*!
 An alias for the SCNCylinder's @p height property. Speficies the extent of the
 cylinder in its @p y axis.
 @see radius
 */
@property (nonatomic) NSNumber *height;
@end
