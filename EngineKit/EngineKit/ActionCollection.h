

#import "MethodAction.h"

#ifndef MethodAction_
#define MethodAction_

@interface ActionCollection : NSObject
@property (nonatomic, strong) NSMutableDictionary <NSString *,
                                                    NSMutableArray
                                                    <MethodAction *> *
                                                    > *arrays;

- (NSArray <MethodAction *> *)actionsForKey:(NSString *)key;
- (void)addAction:(MethodAction *)action forKey:(NSString *)key;
@end

#endif