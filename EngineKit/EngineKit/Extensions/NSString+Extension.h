

#import <Foundation/Foundation.h>


@interface NSString (Extension)
/*!
 The value of the string as an NSNumber. Obtained by using the string's
 doubleValue property, so it follows basically the same rules.
 @see doubleValue
 */
@property (nonatomic, readonly, weak) NSNumber *numberValue;

/*!
 Checks if the string is empty or contains only whitespace.
 @return @p YES if the string is valid, @p NO otherwise.
 */
@property (nonatomic, readonly) BOOL valid;
/*!
 Returns the number of whitespace characters preceding a non-whitespace
 character in a line of text. Tabs, spaces and newlines are all counted as one
 character.
 @return A number representing the string's indentation level.
 */
@property (nonatomic, readonly) NSUInteger indentation;
// TODO: doc
+ (NSString *)stringFromFloat:(float) val;
@end
