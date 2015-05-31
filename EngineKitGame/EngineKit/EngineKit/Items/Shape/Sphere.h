

#import "Shape.h"


@protocol SphereExport <JSExport>
- (instancetype)init;
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
+ (instancetype)sphere;
@property (nonatomic) NSNumber *radius;
@end


/*!
 A sphere, with specifiable radius.
 */
@interface Sphere : Shape <SphereExport>
/*!
 Creates a new instance of @p Sphere, with the default measures set by @p
 SCNSphere.
 @return a new, default instance of @p Sphere.
 */
+ (instancetype)sphere;

/*!
 An alias for the SCNSphere's @p radius property. Speficies the radius used for
 the Sphere, which is centered in the origin.
 */
@property (nonatomic) NSNumber *radius;
@end
