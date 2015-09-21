

#import <Foundation/Foundation.h>


@interface NSNumber (Extension)
/*!
 Creates an NSNumber by using the string's @p doubleValue method.
 @param string A string starting with the desired number.
 @return An NSNumber object.
 @see NSString's doubleValue
 */
+ (NSNumber *)numberWithString:(NSString *)string;
/*!
 Creates an NSNumber based on the given object. Currently supports NSStrings and
 NSNumbers.
 @param object The object from which to obtain the number.
 @return A new NSNumber.
 */
+ (NSNumber *)numberWithObject:(id)object;
@end
