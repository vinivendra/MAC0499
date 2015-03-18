

@class Torus;


@protocol TorusExport <JSExport>
+ (instancetype)create;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
//
@property (nonatomic, strong) id color;
//
+ (instancetype)torus;
@property (nonatomic) CGFloat ringRadius;
@property (nonatomic) CGFloat pipeRadius;
@end


@interface Torus : Shape <TorusExport>
+ (instancetype)torus;
@property (nonatomic) CGFloat ringRadius;
@property (nonatomic) CGFloat pipeRadius;
@end
