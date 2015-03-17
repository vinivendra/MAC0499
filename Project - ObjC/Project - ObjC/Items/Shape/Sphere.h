

@protocol SphereExport <JSExport>
+ (instancetype)create;
+ (instancetype)sphere;
@property (nonatomic) CGFloat radius;
@property (nonatomic, strong) id color;
@end


@interface Sphere : Shape <SphereExport>
+ (instancetype)sphere;
@property (nonatomic) CGFloat radius;
@end
