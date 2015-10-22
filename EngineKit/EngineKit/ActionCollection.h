

#import "MethodAction.h"

#ifndef MethodAction_
#define MethodAction_

@interface ActionCollection : NSObject
@property (nonatomic, strong) NSMutableDictionary <NSString *,
                                                    NSMutableArray
                                                    <MethodAction *> *
                                                    > *arrays;

- (NSMutableArray <MethodAction *> *)actionsForKey:(NSString *)key;

- (void)addAction:(MethodAction *)action forKey:(NSString *)key;

- (ActionCollection *)deepCopy;

- (NSArray *)javaScriptStrings;
- (NSArray *)parserStrings;
@end

#endif