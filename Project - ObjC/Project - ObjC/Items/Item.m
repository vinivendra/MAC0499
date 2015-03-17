

#import "Item.h"


@implementation Item

+ (instancetype)create {
    return [self new];
}

- (instancetype)init {
    if (self = [super init]) {
        [[SCNScene shared] addItem:self];
    }
    return self;
}

@end
