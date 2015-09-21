

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol UICallbackHandler <NSObject>
@property (nonatomic, readonly, strong) JSValue *buttonCallback;
@property (nonatomic, readonly, strong) JSValue *sliderCallback;
@end


@class UI;

@protocol UIExport <JSExport>
@property (nonatomic, weak) id addButton;
@end

@interface UI : NSObject <UIExport>
- (instancetype)init;
@property (nonatomic, strong) id<UICallbackHandler> handler;
@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSMutableDictionary *actions;
@property (nonatomic, weak) id addButton;
@property (nonatomic, weak) id addSlider;
@end
