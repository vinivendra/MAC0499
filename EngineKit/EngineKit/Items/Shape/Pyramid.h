

#import "Shape.h"


@protocol PyramidExport <JSExport>
- (instancetype)initAndAddToScene;
- (instancetype)create;
+ (instancetype)create;
+ (instancetype) template;
- (void)addItem:(Item *)newItem;
- (void)rotate:(id)rotation;
@property (nonatomic, weak, readonly) Item *parent;
@property (nonatomic, strong) NSString *templateName;
@property (nonatomic, strong) id materials;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) id scale;
@property (nonatomic) BOOL isDefault;
@property (nonatomic) BOOL hidden;
- (void)setPositionX:(NSNumber *)newValue;
- (void)setPositionY:(NSNumber *)newValue;
- (void)setPositionZ:(NSNumber *)newValue;
- (void)setScaleX:(NSNumber *)newValue;
- (void)setScaleY:(NSNumber *)newValue;
- (void)setScaleZ:(NSNumber *)newValue;
- (void)setRotationX:(NSNumber *)newValue;
- (void)setRotationY:(NSNumber *)newValue;
- (void)setRotationZ:(NSNumber *)newValue;
- (void)setRotationA:(NSNumber *)newValue;
- (NSNumber *)positionX;
- (NSNumber *)positionY;
- (NSNumber *)positionZ;
- (NSNumber *)scaleX;
- (NSNumber *)scaleY;
- (NSNumber *)scaleZ;
- (NSNumber *)rotationX;
- (NSNumber *)rotationY;
- (NSNumber *)rotationZ;
- (NSNumber *)rotationA;
- (void)addPositionX:(NSNumber *)newValue;
- (void)addPositionY:(NSNumber *)newValue;
- (void)addPositionZ:(NSNumber *)newValue;
- (void)addScaleX:(NSNumber *)newValue;
- (void)addScaleY:(NSNumber *)newValue;
- (void)addScaleZ:(NSNumber *)newValue;
- (void)addRotationX:(NSNumber *)newValue;
- (void)addRotationY:(NSNumber *)newValue;
- (void)addRotationZ:(NSNumber *)newValue;
- (void)addRotationA:(NSNumber *)newValue;
- (void)addPosition:(id)object;
- (void)addScale:(id)object;
//
@property (nonatomic, strong) id color;
@property (nonatomic, strong) id physics;
@property (nonatomic, strong) id velocity;
//
+ (instancetype)pyramid;
@property (nonatomic) NSNumber *width;
@property (nonatomic) NSNumber *height;
@property (nonatomic) NSNumber *length;
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
@property (nonatomic) NSNumber *width;
/*!
 An alias for the SCNPyramid's @p height property. Speficies the height used for
 the Pyramid, which represents its @p y axis extent.
 */
@property (nonatomic) NSNumber *height;
/*!
 An alias for the SCNPyramid's @p length property. Speficies the length used for
 the Pyramid, which represents its @p z axis extent.
 */
@property (nonatomic) NSNumber *length;
@end
