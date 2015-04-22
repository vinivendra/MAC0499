

#import "UI.h"
#import "JavaScript.h"


@implementation UI

+ (UI *)shared {
    static UI *singleton;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      singleton = [self new];
                  });

    return singleton;
}

- (instancetype)init {
    if (self = [super init]) {
        self.view = [UIView new];
        self.actions = [NSMutableDictionary new];
    }
    return self;
}

- (void)setAddButton:(UIButton *)button {
    self.actions[@(button.hash)] = [JavaScript shared].buttonCallback;
    [button addTarget:self
                  action:@selector(triggerActionForButton:)
        forControlEvents:UIControlEventTouchUpInside];
}

- (id)addButton {
    assert(false); // This property is meant to be used only for its setter.
}

- (void)triggerActionForButton:(UIButton *)button {
    JSValue *action = self.actions[@(button.hash)];
    [action callWithArguments:@[button]];
}

@end
