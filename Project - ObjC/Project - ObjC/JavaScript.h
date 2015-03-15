

#import <Foundation/Foundation.h>

@interface JavaScript : NSObject
+ (JavaScript *)shared;
- (instancetype)initWithFile:(NSString *)filename;

- (void)setup;
- (void)load;
@end
