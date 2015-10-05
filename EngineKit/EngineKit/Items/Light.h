

#import <JavaScriptCore/JavaScriptCore.h>

#import "Item.h"


@protocol LightExport <JSExport>
- (instancetype)create;
+ (instancetype)create;
- (instancetype)initAndAddToScene;
+ (instancetype) template;
- (void)addItem:(Item *)newItem;
- (void)rotate:(id)rotation;
@property (nonatomic, weak, readonly) Item *parent;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) id scale;
@property (nonatomic) BOOL isDefault;
@property (nonatomic) BOOL hidden;
//
@property (nonatomic, strong) id color;
@property (nonatomic) NSString *type;
@end


@interface Light : Item <LightExport>
// TODO: doc
@property (nonatomic, strong) id color;
/// Accepts "ambient", "directional", "omni", "spot" or a default SCNLightType.
/// Returns the default SCNLightType.
@property (nonatomic) NSString *type;
@end
