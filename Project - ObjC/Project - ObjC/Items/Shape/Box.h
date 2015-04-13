

@class Box;


@protocol BoxExport <JSExport>
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
