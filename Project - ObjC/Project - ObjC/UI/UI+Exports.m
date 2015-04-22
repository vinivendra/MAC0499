

#import "UI+Exports.h"


@implementation UIButton (Export)

+ (instancetype)create {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];

    [button setTitle:@"BOTAUM" forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 100, 50);

    [[UI shared].view addSubview:button];
    [UI shared].addButton = button;

    return button;
}
@end
