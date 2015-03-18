

@class Plane;


@protocol PlaneExport <JSExport>
+ (instancetype)create;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
//
@property (nonatomic, strong) id color;
//
+ (instancetype)plane;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@end


@interface Plane : Shape <PlaneExport>
+ (instancetype)plane;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@end
