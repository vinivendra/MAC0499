

#import "Shape.h"


@protocol PlaneExport <JSExport>
- (instancetype)initAndAddToScene;
- (instancetype)create;
+ (instancetype)create;
+ (instancetype) template;
- (void)addItem:(Item *)newItem;
- (void)rotate:(id)rotation;
@property (nonatomic, weak, readonly) Item *parent;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) id materials;
@property (nonatomic, getter=isSelected) BOOL selected;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) id scale;
//
@property (nonatomic, strong) id color;
@property (nonatomic, strong) id physics;
@property (nonatomic, strong) id velocity;
//
+ (instancetype)plane;
@property (nonatomic) NSNumber *width;
@property (nonatomic) NSNumber *height;
@end


/*!
 A plane, with limited width and height, is much like a square.
 */
@interface Plane : Shape <PlaneExport>

/*!
 Creates a new instance of @p Plane, with the default measures set by @p
 SCNPlane.
 @return a new, default instance of @p Plane.
 */
+ (instancetype)plane;

/*!
 An alias for the SCNPlane's @p width property. Speficies the width used for
 the Plane, which represents its @p x axis extent.
 */
@property (nonatomic) NSNumber *width;
/*!
 An alias for the SCNPlane's @p height property. Speficies the height used for
 the Plane, which represents its @p y axis extent.
 */
@property (nonatomic) NSNumber *height;
@end
