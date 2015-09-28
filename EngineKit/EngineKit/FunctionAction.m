

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

- (id)call {
    JSValue *function = self.target;
    return [function callWithArguments:[self evaluateArguments]];
}

- (id)callWithArguments:(id)arguments {
    JSValue *function = self.target;
    id evaluatedArguments = [self evaluateArgumentsWithTailArgument:arguments];
    return [function callWithArguments:evaluatedArguments];
}
@end
