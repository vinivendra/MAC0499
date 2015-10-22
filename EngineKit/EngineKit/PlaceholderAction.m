

#import "PlaceholderAction.h"


@implementation PlaceholderAction

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.target = name;
    }
    return self;
}

- (instancetype)initWithTarget:(id)target methodName:(NSString *)name {
    if (self = [super init]) {
        self.target = name;
    }
    return self;
}

- (instancetype)initWithTarget:(id)target
                    methodName:(NSString *)name
                     arguments:(id)arguments {
    if (self = [super init]) {
        self.target = name;
    }
    return self;
}

- (instancetype)initWithTarget:(id)target
                      selector:(SEL)selector
                     arguments:(id)arguments {
    if (self = [super init]) {
        NSString *name = NSStringFromSelector(selector);
        self.target = name;
    }
    return self;
}

- (NSString *)description {
    return self.target;
}

- (NSString *)name {
    return self.target;
}

- (NSString *)options {
    return nil;
}

@end
