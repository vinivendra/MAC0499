

@class Pyramid;


@protocol PyramidExport <JSExport>
+ (instancetype)create;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
//
@property (nonatomic, strong) id color;
//
+ (instancetype)pyramid;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat length;
@end


@interface Pyramid : Shape <PyramidExport>
+ (instancetype)pyramid;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat length;
@end
