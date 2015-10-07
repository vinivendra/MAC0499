

#import <JavaScriptCore/JavaScriptCore.h>

#import "Item.h"

@class Camera;


@protocol CameraExport <JSExport>
- (void)addItem:(Item *)newItem;
- (void)rotate:(id)rotation;
- (void)lookAt:(id)object;
@property (nonatomic, weak, readonly) Item *parent;
@property (nonatomic, strong) NSString *templateName;
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
- (void)addPosition:(id)object;
- (void)addScale:(id)object;
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
@end


@interface Camera : Item <CameraExport>
- (void)lookAt:(id)object;
@end
