

#import "UI+Exports.h"

#import "Position.h"

#import "UI.h"


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

- (void)setSize:(id)size {
    Vector *newValue = [[Vector alloc] initWithObject:size];
    CGRect frame = self.frame;
    frame.size.width = newValue.x;
    frame.size.height = newValue.y;

    self.frame = frame;
}

- (Vector *)size {
    return [[Position alloc] initWithX:self.frame.size.width
                                     Y:self.frame.size.height
                                     Z:0];
}

@end


@implementation UIButton (Export)

+ (instancetype)create {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];

    [button setTitle:@"BOTAUM" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 100, 50);

    [[UI shared].view addSubview:button];
    [UI shared].addButton = button;

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

    [[UI shared].view addSubview:slider];
    [UI shared].addSlider = slider;

    return slider;
}

@end


@implementation UILabel (Export)

+ (instancetype)create {
    UILabel *label = [UILabel new];

//    label.frame = CGRectMake(100, 100, 100, 50);

    [[UI shared].view addSubview:label];

    return label;
}

- (void)setAlignment:(NSTextAlignment)alignment {
    self.textAlignment = alignment;
}

- (NSTextAlignment)alignment {
    return self.textAlignment;
}

@end
