// TODO: Change setAddSlider and similars to actual normal methods.

#import "UI.h"
#import "JavaScript.h"


@implementation UI

- (instancetype)init {
    if (self = [super init]) {
        self.view = [UIView new];
        self.actions = [NSMutableDictionary new];
    }
    return self;
}

- (void)setAddButton:(UIButton *)button {
    [button addTarget:self
               action:@selector(triggerActionForButton:)
     forControlEvents:UIControlEventValueChanged];
}

- (void)setAddSlider:(UISlider *)slider {
    [slider addTarget:self
               action:@selector(triggerActionForSlider:)
     forControlEvents:UIControlEventValueChanged];
}

// TODO: CHANGE THIS TO A FREAKIN METHOD
- (id)addButton {
    assert(false); // This property is meant to be used only for its setter.
}

- (id)addSlider {
    assert(false); // This property is meant to be used only for its setter.
}

- (void)triggerActionForButton:(UIButton *)button {
    [self.delegate callUICallbackForView:button ofType:Button];
}

- (void)triggerActionForSlider:(UISlider *)slider {
    [self.delegate callUICallbackForView:slider ofType:Slider];
}

@end
