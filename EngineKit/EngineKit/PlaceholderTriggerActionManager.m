

#import "PlaceholderTriggerActionManager.h"


@implementation PlaceholderTriggerActionManager

- (void)addActionNamed:(NSString *)name forTrigger:(NSDictionary *)dictionary {
    PlaceholderAction *action = [[PlaceholderAction alloc] initWithName:name];
    NSString *trigger = [self triggerForDictionary:dictionary];
    [self addMethodAction:action forTrigger:trigger];
}

- (void)addJSValue:(JSValue *)value forTrigger:(NSString *)trigger {
    NSString *name = value.functionName;

    PlaceholderAction *action = [[PlaceholderAction alloc] initWithTarget:name
                                                               methodName:nil];

    [self addMethodAction:action forTrigger:trigger];
}

@end
