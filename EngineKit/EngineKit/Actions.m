

#import "Actions.h"
#import "JSContext+Extension.h"
#import "JSValue+Extension.h"
#import "ObjectiveSugar.h"


static NSMutableDictionary <NSString *, id<Action>> *actions;


@implementation Actions

+ (id<Action>)actionForStrings:(NSArray <NSString *> *)strings {

    NSString *actionID = strings[0];

    if ([actionID caseInsensitiveCompare:@"set"] == NSOrderedSame) {
        return [self setActionForStrings:strings];
    }

    return nil;
}

+ (id<Action>)setActionForStrings:(NSArray <NSString *> *)strings {

    NSArray <NSString *> *keyPathArray;
    keyPathArray = [strings objectForKeyedSubscript:@"1.."];

    NSString *keyPath = [keyPathArray join:@"."];

    NSString *contents = [NSString stringWithFormat:@"item.%@ = value", keyPath];

    NSString *keyPathSnakeCase = [keyPathArray join:@"_"];

    NSString *nameSnakeCase = [NSString stringWithFormat:@"set_%@",
                               keyPathSnakeCase];

    NSString *nameCamelCase = nameSnakeCase.camelCase;

    return [self functionWithName:nameCamelCase Contents:contents];
}

+ (JSValue *)functionWithName:(NSString *)name Contents:(NSString *)contents {

    NSString *functionText = [NSString stringWithFormat:@"func %@(item, value) {\n    %@\n}\n",
                              name, contents];

    JSContext *context = [JSContext shared];

    [context evaluateScript:functionText];

    JSValue *function = context[name];

    return function;
}

@end
