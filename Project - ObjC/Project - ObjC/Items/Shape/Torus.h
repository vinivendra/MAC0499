

@class Torus;


@protocol TorusExport <JSExport>
+ (instancetype)create;
- (instancetype)create;
+ (instancetype) template;
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
+ (instancetype)torus;
@property (nonatomic) NSNumber *ringRadius;
@property (nonatomic) NSNumber *pipeRadius;
@end


/*!
 A torus, which is a shape much like a donut, with specifiable ring radius and
 pipe radius.
 */
@interface Torus : Shape <TorusExport>
/*!
 Creates a new instance of @p Torus, with the default measures set by @p
 SCNTorus.
 @return a new, default instance of @p Torus.
 */
+ (instancetype)torus;
/*!
 An alias for the SCNTorus's @p ringRadius property. Speficies the radius that
 the Torus's ring will have, or how wide the donut will be.
 */
@property (nonatomic) NSNumber *ringRadius;
/*!
 An alias for the SCNTorus's @p pipeRadius property. Speficies the radius that
 the Torus's pipe will have, or the donut's thickness.
 */
@property (nonatomic) NSNumber *pipeRadius;
@end
