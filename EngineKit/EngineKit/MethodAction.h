
#import "Common.h"


@interface MethodAction : NSObject
- (instancetype)initWithTarget:(id)target
                      selector:(SEL)selector
                     arguments:(id)arguments;

- (instancetype)initWithTarget:(id)target
                    methodName:(NSString *)name
                     arguments:(id)arguments;

- (instancetype)initWithTarget:(id)target
                    methodName:(NSString *)name;


- (id)call;
- (id)callWithArguments:(id)arguments;

// Protected
- (id)evaluateArguments;
- (id)evaluateArgumentsWithTailArgument:(id)argument;

@property (nonatomic) id target;
@property (nonatomic) SEL selector;
@property (nonatomic, strong) id arguments;
@end
