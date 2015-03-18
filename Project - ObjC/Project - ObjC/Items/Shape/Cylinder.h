
@class Cylinder;


@protocol CylinderExport <JSExport>
+ (instancetype)create;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) id scale;
//
@property (nonatomic, strong) id color;
//
+ (instancetype)cylinder;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat height;
@end


@interface Cylinder : Shape <CylinderExport>
+ (instancetype)cylinder;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat height;
@end
