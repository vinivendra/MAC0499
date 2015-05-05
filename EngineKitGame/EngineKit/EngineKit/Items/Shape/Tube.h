// TODO: Create a thickness variable.


#import "Shape.h"


@class Tube;


@protocol TubeExport <JSExport>
+ (instancetype)create;
- (instancetype)create;
+ (instancetype) template;
- (void)addItem:(Item *)newItem;
- (void)rotate:(id)rotation;
//
- (void)destroy;
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) id scale;
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
 An alias for the SCNTube's @p outerRadius property. Speficies the radius that
 the Tube will have, or it's extent in the @p xz plane.
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
@end
