
#ifndef Project___ObjC_UI_Exports_h
#define Project___ObjC_UI_Exports_h


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol UIButtonExport <JSExport>
+ (instancetype)create;
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id size;
//
@property (nonatomic, strong) NSString *string;
@end

@protocol UISliderExport <JSExport>
+ (instancetype)create;
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id size;
//
@property (nonatomic) float value;
@property (nonatomic) float minimumValue;
@property (nonatomic) float maximumValue;
@end




@interface UIView (Export)
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id size;
@end

@interface UIButton (Export) <UIButtonExport>
+ (instancetype)create;
//
@property (nonatomic, strong) NSString *string;
@end

@interface UISlider (Export) <UISliderExport>
+ (instancetype)create;
//
@end


#endif
