

#import <Foundation/Foundation.h>


@interface NSString (Extension)
@property (nonatomic, readonly, weak) NSNumber *numberValue;

- (BOOL)valid;
@end
