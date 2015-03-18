

@class Cone;


@protocol ConeExport <JSExport>
+ (instancetype)create;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
//
@property (nonatomic, strong) id color;
//
+ (instancetype)cone;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat topRadius;
@property (nonatomic) CGFloat bottomRadius;
@property (nonatomic) CGFloat height;
@end


@interface Cone : Shape <ConeExport>
+ (instancetype)cone;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat topRadius;
@property (nonatomic) CGFloat bottomRadius;
@property (nonatomic) CGFloat height;
@end
