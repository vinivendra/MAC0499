

#import "Item.h"


@implementation Item

- (instancetype)init {
    if (self = [super init]) {
        [[SCNScene shared] addItem:self];
    }
    return self;
}

@end
