

#import <EngineKit/EngineKit.h>


@interface PlaceholderTriggerActionManager : TriggerActionManager
- (void)addActionNamed:(NSString *)name forTrigger:(NSDictionary *)dictionary;
- (void)addJSValue:(JSValue *)value forTrigger:(NSString *)trigger;
@end
