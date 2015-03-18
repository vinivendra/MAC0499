
@class Tube;


@protocol TubeExport <JSExport>
+ (instancetype)create;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
//
@property (nonatomic, strong) id color;
//
+ (instancetype)tube;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat innerRadius;
@property (nonatomic) CGFloat outerRadius;
@property (nonatomic) CGFloat height;
@end


@interface Tube : Shape <TubeExport>
+ (instancetype)tube;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat innerRadius;
@property (nonatomic) CGFloat outerRadius;
@property (nonatomic) CGFloat height;
@end
