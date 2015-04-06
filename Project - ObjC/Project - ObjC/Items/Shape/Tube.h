// TODO: Create a thickness variable.


@class Tube;


@protocol TubeExport <JSExport>
+ (instancetype)create;
+ (instancetype) template;
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
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat innerRadius;
@property (nonatomic) CGFloat outerRadius;
@property (nonatomic) CGFloat height;
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
@property (nonatomic) CGFloat radius;
/*!
 An alias for the SCNTube's @p outerRadius property. Speficies the radius that
 the Tube will have, or it's extent in the @p xz plane.
 */
@property (nonatomic) CGFloat outerRadius;
/*!
 An alias for the SCNTube's @p innerRadius property. Speficies the radius that
 the Tube's hole will have.
 */
@property (nonatomic) CGFloat innerRadius;
/*!
 An alias for the SCNTube's @p height property. Speficies the Tube's extent on
 the @p y axis.
 */
@property (nonatomic) CGFloat height;
@end
