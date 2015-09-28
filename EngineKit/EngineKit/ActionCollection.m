

#import "ActionCollection.h"


@implementation ActionCollection
@synthesize arrays = _arrays;
- (NSMutableDictionary *)arrays {
    if (!_arrays) {
        _arrays = [NSMutableDictionary new];
    }
    return _arrays;
}
- (NSArray <MethodAction *> *)actionsForKey:(NSString *)key {
    return self.arrays[key];
}
- (void)addAction:(MethodAction *)action forKey:(NSString *)key {
    NSMutableArray *array = self.arrays[key];
    if (!array) {
        array = [NSMutableArray new];
        self.arrays[key] = array;
    }

    [array addObject:action];
}
@end