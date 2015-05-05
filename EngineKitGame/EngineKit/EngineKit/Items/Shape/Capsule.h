

#import "Shape.h"


@class Capsule;


@protocol CapsuleExport <JSExport>
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
+ (instancetype)capsule;
@property (nonatomic) NSNumber *radius;
@property (nonatomic) NSNumber *height;
@end


/*!
 A capsule, which is essentially a cylinder with two hemispheres on each end.
 */
@interface Capsule : Shape <CapsuleExport>
/*!
 Creates a new instance of @p Capsule, with the default measures set by @p
 SCNCapsule.
 @return a new, default instance of @p Capsule.
 */
+ (instancetype)capsule;
/*!
 An alias for the SCNCapsule's @p radius property. Speficies the radius used for
 both the Capsule's 'cylinder' and its 'hemispheres'. Both the cylinder's
 circular bases are aligned with the @p xz plane and centered in the origin.
 */
@property (nonatomic) NSNumber *radius;
/*!
 An alias for the SCNCapsule's @p height property. Speficies the extent of the
 Capsule along the @p y axis.
 */
@property (nonatomic) NSNumber *height;
@end
