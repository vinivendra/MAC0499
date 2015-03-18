

@class Capsule;


@protocol CapsuleExport <JSExport>
+ (instancetype)create;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) id scale;
//
@property (nonatomic, strong) id color;
//
+ (instancetype)capsule;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat height;
@end


@interface Capsule : Shape <CapsuleExport>
+ (instancetype)capsule;
@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat height;
@end
