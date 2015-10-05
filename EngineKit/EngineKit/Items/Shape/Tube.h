

#import "Shape.h"


@protocol TubeExport <JSExport>
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
+ (instancetype)tube;
@property (nonatomic) NSNumber *radius;
@property (nonatomic) NSNumber *innerRadius;
@property (nonatomic) NSNumber *outerRadius;
@property (nonatomic) NSNumber *height;
@property (nonatomic) NSNumber *thickness;
@end


/*!
 A tube, with speficiable radius, thickness and height.
 */
@interface Tube : Shape <TubeExport>
/*!
 Creates a new instance of @p Tube, with the default measures set by @p
 SCNTube.
 @return a new, default instance of @p Tube.
 */
+ (instancetype)tube;
/*!
 A calculated property. Specifies the average between the tube's inner and outer
 radii.
 */
@property (nonatomic) NSNumber *radius;
/*!
 An alias for the SCNTube's @p outerRadius property. Speficies the radius that
 the Tube will have, or it's extent in the @p xz plane.
 */
@property (nonatomic) NSNumber *outerRadius;
/*!
 An alias for the SCNTube's @p innerRadius property. Speficies the radius that
 the Tube's hole will have.
 */
@property (nonatomic) NSNumber *innerRadius;
/*!
 An alias for the SCNTube's @p height property. Speficies the Tube's extent on
 the @p y axis.
 */
@property (nonatomic) NSNumber *height;
/*!
 A calculated property. Specifies the diference between the tube's inner radius
 and outer radius. When changed, changes both the inner and outer radius
 proportionally, so that the @p radius property is kept constant.
 */
@property (nonatomic) NSNumber *thickness;
@end
