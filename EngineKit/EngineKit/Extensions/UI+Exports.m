

#import "UI+Exports.h"

#import "UI.h"

#import "SceneManager.h"

#import "Position.h"




@implementation UIView (Export)

- (void)setPosition:(id)position {
    Position *newValue = [[Position alloc] initWithObject:position];
    CGRect frame = self.frame;
    frame.origin.x = newValue.x;
    frame.origin.y = newValue.y;

    self.frame = frame;
}

- (Position *)position {
    return [[Position alloc] initWithX:self.frame.origin.x
                                     Y:self.frame.origin.y
                                     Z:0];
}

@end


@implementation UIButton (Export)

+ (instancetype)create {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];

    [button setTitle:@"BOTAUM" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 100, 50);

    [[SceneManager currentSceneManager].ui.view addSubview:button];
    [SceneManager currentSceneManager].ui.addButton = button;

    return button;
}

- (void)setString:(NSString *)string {
    [self setTitle:string forState:UIControlStateNormal];
}

- (NSString *)string {
    return [self titleForState:UIControlStateNormal];
}

@end


@implementation UISlider (Export)

+ (instancetype)create {
    UISlider *slider = [UISlider new];

    slider.frame = CGRectMake(100, 100, 100, 50);

    [[SceneManager currentSceneManager].ui.view addSubview:slider];
    [SceneManager currentSceneManager].ui.addSlider = slider;

    return slider;
}

@end


@implementation UILabel (Export)

+ (instancetype)create {
    UILabel *label = [UILabel new];

//    label.frame = CGRectMake(100, 100, 100, 50);

    [[SceneManager currentSceneManager].ui.view addSubview:label];

    return label;
}

- (void)setAlignment:(NSTextAlignment)alignment {
    self.textAlignment = alignment;
}

- (NSTextAlignment)alignment {
    return self.textAlignment;
}

@end
