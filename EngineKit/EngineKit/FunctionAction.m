

#import "FunctionAction.h"


@implementation FunctionAction

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

@end
