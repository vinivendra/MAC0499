

@class Text;


@protocol TextExport <JSExport>
+ (instancetype)create;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
//
@property (nonatomic, strong) id color;
//
@property (nonatomic) CGFloat depth;
@property (nonatomic) id string;
@end


@interface Text : Shape <TextExport>
+ (instancetype)text;
@property (nonatomic) CGFloat depth;
@property (nonatomic) id string;
@end
