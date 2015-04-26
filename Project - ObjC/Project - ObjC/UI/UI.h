

@class UI;

@protocol UIExport <JSExport>
@property (nonatomic, weak) id addButton;
@end


@interface UI : NSObject <UIExport>
+ (UI *)shared;
@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSMutableDictionary *actions;
@property (nonatomic, weak) id addButton;
@property (nonatomic, weak) id addSlider;
@end
