
#ifndef Project___ObjC_UI_Exports_h
#define Project___ObjC_UI_Exports_h

@protocol UIButtonExport <JSExport>
+ (instancetype)create;
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id size;
@property (nonatomic, strong) NSString *string;
@end


@interface UIButton (Export) <UIButtonExport>
+ (instancetype)create;
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id size;
@property (nonatomic, strong) NSString *string;
@end


#endif
