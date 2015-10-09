

#import "PlaceholderAction.h"


@implementation PlaceholderAction

- (instancetype)initWithTarget:(id)target methodName:(NSString *)name {
    if (self = [super init]) {
        self.target = name;
    }
    return self;
}

- (NSString *)description {
    return self.target;
}

- (NSString *)JSString {
    NSString *result = [NSString stringWithFormat:@"TriggerManager.addActionForTrigger(%@, {",
                        self.description];

    return result;
}

@end
