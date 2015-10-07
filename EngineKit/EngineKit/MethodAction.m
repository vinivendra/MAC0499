

#import "MethodAction.h"
#import <JavaScriptCore/JavaScriptCore.h>


@implementation MethodAction
- (instancetype)initWithTarget:(id)target
                      selector:(SEL)selector
                     arguments:(id)arguments {
    if (self = [super init]) {
        self.target = target;
        self.selector = selector;
        self.arguments = arguments;
    }
    return self;
}

- (instancetype)initWithTarget:(id)target
                    methodName:(NSString *)name
                     arguments:(id)arguments {
    if (self = [super init]) {
        self.target = target;
        self.selector = [self selectorForMethodNameWithArguments:name];
        self.arguments = arguments;
    }
    return self;
}

- (instancetype)initWithTarget:(id)target
                    methodName:(NSString *)name {
    if (self = [super init]) {
        self.target = target;
        self.selector = [self selectorForMethodName:name];
    }
    return self;
}

- (SEL)selectorForMethodNameWithArguments:(NSString *)name {
    NSString *nameWithArguments = [name stringByAppendingString:@":"];
    return NSSelectorFromString(nameWithArguments);
}

- (SEL)selectorForMethodName:(NSString *)name {
    return NSSelectorFromString(name);
}


////////////////////////////////////////////////////////////////////////////////
- (void)call {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.target performSelector:self.selector
                      withObject:[self evaluateArguments]];
#pragma clang diagnostic pop
}

- (id)callAndReturn {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [self.target performSelector:self.selector
                             withObject:[self evaluateArguments]];
#pragma clang diagnostic pop
}

- (id)evaluateArguments {
    if ([self.arguments isKindOfClass:[MethodAction class]]) {
        MethodAction *newAction = self.arguments;
        return [(JSValue *)[newAction callAndReturn] toObject];
    }
    else {
        return self.arguments;
    }
}

- (void)callWithArguments:(id)arguments {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self.target
     performSelector:self.selector
     withObject:[self evaluateArgumentsWithTailArgument:arguments]];
#pragma clang diagnostic pop
}

- (id)callAndReturnWithArguments:(id)arguments {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [self.target
            performSelector:self.selector
            withObject:[self evaluateArgumentsWithTailArgument:arguments]];
#pragma clang diagnostic pop
}

- (id)evaluateArgumentsWithTailArgument:(id)argument {
    if ([self.arguments isKindOfClass:[MethodAction class]]) {
        MethodAction *newAction = self.arguments;
        return [(JSValue *)[newAction callAndReturnWithArguments:argument]
                toObject];
    }
    else if(!self.arguments) {
        return argument;
    }
    else {
        return self.arguments;
    }
}
@end
