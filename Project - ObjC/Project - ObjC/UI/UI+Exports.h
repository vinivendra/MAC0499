
#ifndef Project___ObjC_UI_Exports_h
#define Project___ObjC_UI_Exports_h

@protocol UIButtonExport <JSExport>
+ (instancetype)create;
@end


@interface UIButton (Export) <UIButtonExport>
+ (instancetype)create;
@end


#endif
