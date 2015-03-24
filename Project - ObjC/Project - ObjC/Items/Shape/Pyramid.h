

@class Pyramid;


@protocol PyramidExport <JSExport>
+ (instancetype)create;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) id scale;
//
@property (nonatomic, strong) id color;
@property (nonatomic, strong) id physics;
@property (nonatomic, strong) id velocity;
//
+ (instancetype)pyramid;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat length;
@end



/*!
 A square based pyramid, with specifiable width, length and height.
 */
@interface Pyramid : Shape <PyramidExport>
/*!
 Creates a new instance of @p Pyramid, with the default measures set by @p
 SCNPyramid.
 @return a new, default instance of @p Pyramid.
 */
+ (instancetype)pyramid;

/*!
 An alias for the SCNPyramid's @p width property. Speficies the width used for
 the Pyramid, which represents its @p x axis extent.
 */
@property (nonatomic) CGFloat width;
/*!
 An alias for the SCNPyramid's @p height property. Speficies the height used for
 the Pyramid, which represents its @p y axis extent.
 */
@property (nonatomic) CGFloat height;
/*!
 An alias for the SCNPyramid's @p length property. Speficies the length used for
 the Pyramid, which represents its @p z axis extent.
 */
@property (nonatomic) CGFloat length;
@end
