

#import "Shape.h"


@protocol TextExport <JSExport>
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
