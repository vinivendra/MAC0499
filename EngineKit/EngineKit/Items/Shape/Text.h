

#import "Shape.h"


@protocol TextExport <JSExport>
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
@property (nonatomic) NSNumber *depth;
@property (nonatomic) id string;
@end


/*!
 A 3D text, with specifiable depth and string.
 */
@interface Text : Shape <TextExport>
/*!
 Creates a new instance of @p Text, with the default measures set by @p
 SCNText.
 @return a new, default instance of @p Text.
 */
+ (instancetype)text;
/*!
 An alias for the SCNText's @p extrusionDepth property. Speficies the depth that
 the characters will have.
 */
@property (nonatomic) NSNumber *depth;
/*!
 An alias for the SCNText's @p string property. Speficies the text that will be
 displayed. May be an instance of @p NSString or @p NSAttributedString.
 @see SCNText's string property.
 */
@property (nonatomic) id string;
@end
