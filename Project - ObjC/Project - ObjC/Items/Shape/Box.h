

@class Box;


@protocol BoxExport <JSExport>
+ (instancetype)create;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) id scale;
//
@property (nonatomic, strong) id color;
//
+ (instancetype)box;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat length;
@property (nonatomic) CGFloat chamferRadius;
@end


@interface Box : Shape <BoxExport>
+ (instancetype)box;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat length;
@property (nonatomic) CGFloat chamferRadius;
@end
