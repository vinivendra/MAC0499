

#import <JavaScriptCore/JavaScriptCore.h>

#import "Item.h"


@protocol LightExport <JSExport>
- (void)addItem:(Item *)newItem;
- (void)rotate:(id)rotation;
@property (nonatomic, weak, readonly) Item *parent;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) id scale;
//
@property (nonatomic, strong) id color;
@property (nonatomic) NSString *type;
@end


@interface Light : Item <LightExport>
@property (nonatomic, strong) id color;
@property (nonatomic) NSString *type;
@end
