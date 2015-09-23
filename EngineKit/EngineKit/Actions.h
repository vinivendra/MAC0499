

#import "Common.h"


@interface Actions : NSObject
+ (id<Action>)actionForStrings:(NSArray <NSString *> *)strings;
@end
