

@class Cone;


@protocol ConeExport <JSExport>
+ (instancetype)create;
- (instancetype)create;
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
+ (instancetype)cone;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat topRadius;
@property (nonatomic) CGFloat bottomRadius;
@property (nonatomic) CGFloat height;
@end


/*!
 A cone, which is may be whole or cut off at the top (like a conical frustrum).
 */
@interface Cone : Shape <ConeExport>
/*!
 Creates a new instance of @p Cone, with the default measures set by @p
 SCNCone.
 @return a new, default instance of @p Cone.
 */
+ (instancetype)cone;

/*!
 An alias for the SCNCone's @p bottomRadius property. Speficies the radius used
 for the Cone's base, which is very intuitive when the Cone is not a frustrum.
 The base is aligned with the @p xz plane and is centered in the origin.
 @see topRadius
 @see height
 */
@property (nonatomic) CGFloat radius;
/*!
 An alias for the SCNCone's @p bottomRadius property. Speficies the radius used
 for the Cone's base, which is very intuitive when the Cone is not a frustrum.
 The base is aligned with the @p xz plane and is centered in the origin.
 @see topRadius
 @see height
 */
@property (nonatomic) CGFloat bottomRadius;
/*!
 An alias for the SCNCone's @p topRadius property. Speficies the radius used
 for the Cone's top circle when it is a conical frustrum. A top radius of 0 is
 the default and results in an ordinary cone. The top circle is aligned with the
 @p xz plane and is centered in the origin.
 @see bottomRadius
 @see height
 */
@property (nonatomic) CGFloat topRadius;
/*!
 An alias for the SCNCone's @p height property. Speficies the extent of the cone
 along the @p y axis.
 @see bottomRadius
 @see topRadius
 */
@property (nonatomic) CGFloat height;
@end
