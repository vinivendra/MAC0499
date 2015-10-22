
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


- (void)call;
- (id)callAndReturn;
- (void)callWithArguments:(id)arguments;
- (id)callAndReturnWithArguments:(id)arguments;

// Protected
- (id)evaluateArguments;
- (id)evaluateArgumentsWithTailArgument:(id)argument;

@property (nonatomic) id target;
@property (nonatomic) SEL selector;
@property (nonatomic, strong) id arguments;

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSMutableDictionary *options;
@end
