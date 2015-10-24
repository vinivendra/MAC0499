

#import <EngineKit/EngineKit.h>


@interface PlaceholderTriggerActionManager : TriggerActionManager
- (void)addActionNamed:(NSString *)name
            forTrigger:(NSString *)trigger;

- (void)addActionNamed:(NSString *)name
                toItem:(Item *)item
            forTrigger:(NSString *)trigger;

- (void)addJSValue:(JSValue *)value
        forTrigger:(NSString *)trigger;
@end
