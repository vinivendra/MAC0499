

#import "FunctionAction.h"

#import "ObjectiveSugar.h"
#import "JSValue+Extension.h"


@implementation FunctionAction

@dynamic target;

- (instancetype)initWithJSValue:(JSValue *)value
                      arguments:(id)arguments {
    if (self = [super initWithTarget:value
                            selector:nil
                           arguments:arguments]) {
    }
    return self;
}

- (void)call {
    JSValue *function = self.target;
    [function callWithArguments:[self evaluateArguments]];
}

- (void)callWithArguments:(id)arguments {
    JSValue *function = self.target;
    id evaluatedArguments = [self evaluateArgumentsWithTailArgument:arguments];
    [function callWithArguments:evaluatedArguments];
}

- (id)callAndReturn {
    JSValue *function = self.target;
    return [function callWithArguments:[self evaluateArguments]];
}

- (id)callAndReturnWithArguments:(id)arguments {
    JSValue *function = self.target;
    id evaluatedArguments = [self evaluateArgumentsWithTailArgument:arguments];
    return [function callWithArguments:evaluatedArguments];
}

- (NSString *)description {

    if ([self.target isKindOfClass:[JSValue class]]) {
        JSValue *function = self.target;
        return function.functionName;
    }

    return nil;
}

- (NSString *)JSString {

    NSString *result = [NSString stringWithFormat:@"TriggerManager.addActionForTrigger(%@, {",
                        self.description];

    return result;
}

@end
