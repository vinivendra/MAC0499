

@protocol SphereExport <JSExport>
+ (instancetype)create;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
//
@property (nonatomic, strong) id color;
//
@property (nonatomic) CGFloat radius;
@end


@interface Sphere : Shape <SphereExport>
+ (instancetype)sphere;
@property (nonatomic) CGFloat radius;
@end

// Floor
// Text
// Shape
// Plane