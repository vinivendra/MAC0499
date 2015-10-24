

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

#import "Common.h"






@class UI;

@protocol UIExport <JSExport>
@property (nonatomic, weak) id addButton;
@end

@interface UI : NSObject <UIExport>
- (instancetype)init;
@property (nonatomic, strong) id<CallbackDelegate> delegate;
@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSMutableDictionary *actions;
@property (nonatomic, weak) id addButton;
@property (nonatomic, weak) id addSlider;
@end
