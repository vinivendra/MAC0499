

#import "PlaceholderTriggerActionManager.h"


@implementation PlaceholderTriggerActionManager

- (void)addActionNamed:(NSString *)name
  forTriggerDictionary:(NSDictionary *)dictionary {

    NSString *trigger = [TriggerActionManager triggerForDictionary:dictionary];
    
    [self addActionNamed:name forTrigger:trigger];
}

- (void)addActionNamed:(NSString *)name
            forTrigger:(NSString *)trigger {

    PlaceholderAction *action = [[PlaceholderAction alloc] initWithName:name];

    [self addMethodAction:action forTrigger:trigger];
}

- (void)addActionNamed:(NSString *)name
                toItem:(Item *)item
            forTriggerDictionary:(NSDictionary *)dictionary {

    NSString *trigger = [TriggerActionManager triggerForDictionary:dictionary];

    [self addActionNamed:name
                  toItem:item
              forTrigger:trigger];
}

- (void)addActionNamed:(NSString *)name
                toItem:(Item *)item
            forTrigger:(NSString *)trigger {

    PlaceholderAction *action = [[PlaceholderAction alloc] initWithName:name];

    while (![item isEqual:item.parent]) {
        item = item.parent;
    }

    [item addAction:action forKey:trigger];
}

- (void)addJSValue:(JSValue *)value forTrigger:(NSString *)trigger {
    NSString *name = value.functionName;

    PlaceholderAction *action = [[PlaceholderAction alloc] initWithTarget:name
                                                               methodName:nil];

    [self addMethodAction:action forTrigger:trigger];
}

@end
