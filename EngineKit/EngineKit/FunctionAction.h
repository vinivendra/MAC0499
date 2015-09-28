

#import "MethodAction.h"
#import <JavaScriptCore/JavaScriptCore.h>


@interface FunctionAction : MethodAction
- (instancetype)initWithJSValue:(JSValue *)value
                      arguments:(id)arguments;
@end
