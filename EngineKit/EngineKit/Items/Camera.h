

#import <JavaScriptCore/JavaScriptCore.h>

#import "Item.h"

@class Camera;


@protocol CameraExport <JSExport>
- (void)addItem:(Item *)newItem;
- (void)rotate:(id)rotation;
- (void)lookAt:(id)object;
@property (nonatomic, weak, readonly) Item *parent;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) id scale;
@end


@interface Camera : Item <CameraExport>
- (void)lookAt:(id)object;
@end
