

#import "ActionCollection.h"

#import "TriggerActionManager.h"

#import "ObjectiveSugar.h"


@implementation ActionCollection
@synthesize arrays = _arrays;
- (NSMutableDictionary *)arrays {
    if (!_arrays) {
        _arrays = [NSMutableDictionary new];
    }
    return _arrays;
}

- (NSMutableArray <MethodAction *> *)actionsForKey:(NSString *)key {
    return self.arrays[key];
}

- (void)addAction:(MethodAction *)action forKey:(NSString *)key {
    NSMutableArray *array = self.arrays[key];
    if (!array) {
        array = [NSMutableArray new];
        self.arrays[key] = array;
    }

    [array addObject:action];
}

- (ActionCollection *)deepCopy {
    ActionCollection *copy = [ActionCollection new];

    for (NSString *key in self.arrays) {
        NSMutableArray *array = self.arrays[key];
        copy.arrays[key] = [array mutableCopy];
    }

    return copy;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Writing

- (NSArray *)parserStrings {
    NSMutableArray *statements = [NSMutableArray new];

    NSMutableDictionary *arrays = self.arrays;
    for (NSString *key in arrays) {
        NSMutableArray *array = arrays[key];
        for (MethodAction *action in array) {
            [statements addObject:[self parserStringForAction:action
                                                          key:key]];
        }
    }

    return statements;
}

- (NSString *)parserStringForAction:(MethodAction *)action
                                key:(NSString *)key {
    NSString *statement = @"action ";

    statement = [statement stringByAppendingString:action.name];

    NSMutableDictionary *options = [NSMutableDictionary new];

    [TriggerActionManager addOptionsToDictionary:options
                                      forTrigger:key];

    for (NSString *key in options) {
        NSString *value = options[key];

        NSString *entry = [NSString stringWithFormat:@" %@ %@",
                           key, value];

        statement = [statement stringByAppendingString:entry];
    }
    
    return statement;
}

- (NSArray *)javaScriptStrings {
    NSMutableArray *statements = [NSMutableArray new];

    NSMutableDictionary *arrays = self.arrays;
    for (NSString *key in arrays) {
        NSMutableArray *array = arrays[key];
        for (MethodAction *action in array) {
            [statements addObject:[self javaScriptStringForAction:action
                                                              key:key]];
        }
    }

    return statements;
}

- (NSString *)javaScriptStringForAction:(MethodAction *)action
                                    key:(NSString *)key {
    NSString *statement = @"TriggerManager.addActionForTrigger(";

    statement = [statement stringByAppendingString:action.name];

    NSMutableDictionary *options = action.options;
    if (!options) {
        options = [NSMutableDictionary new];
    }

    [TriggerActionManager addOptionsToDictionary:options
                                      forTrigger:key];

    BOOL isFirst = YES;
    for (NSString *key in options) {
        NSString *value = options[key];

        if (isFirst) {
            isFirst = NO;
            statement = [statement stringByAppendingString:@", {"];
        }
        else {
            statement = [statement stringByAppendingString:@", "];
        }

        NSString *entry = [NSString stringWithFormat:@"\"%@\": \"%@\"",
                           key, value];

        statement = [statement stringByAppendingString:entry];
    }

    if (!isFirst) {
        statement = [statement stringByAppendingString:@"}"];
    }

    statement = [statement stringByAppendingString:@");"];

    return statement;
}


@end