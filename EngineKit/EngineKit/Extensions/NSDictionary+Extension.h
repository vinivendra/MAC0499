

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


@interface NSDictionary (Extension)
/*!
 Returns an NSNumber with the value from the given @p key, using NSNumber's @p
 -numberWithObject: method. If the key does not exist, returns @(0).
 @param key The key in the dictionary from which to get the number.
 @return An NSNumber.
 */
- (NSNumber *)numberForKey:(id<NSCopying>)key;
/*!
 Returns an CGFloat with the value from the given @p key, using NSNumber's @p
 -numberWithObject: method. If the key does not exist, returns 0.0.
 @param key The key in the dictionary from which to get the number.
 @return A CGFloat.
 */
- (CGFloat)floatForKey:(id<NSCopying>)key;
/*!
 Returns an CGFloat with the value from the given @p key, using NSNumber's @p
 -numberWithObject: method. If the key does not exist, returns 0.0. Checks for
 the key in lowercase and uppercase as well.
 @param key The key in the dictionary from which to get the number.
 @return A CGFloat.
 */
- (CGFloat)floatForStringKey:(NSString *)key;
@end
