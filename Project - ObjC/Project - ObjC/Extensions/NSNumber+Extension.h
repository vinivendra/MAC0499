

@interface NSNumber (Extension)
/*!
 Creates an NSNumber by using the string's @p doubleValue method.
 @param string A string starting with the desired number.
 @return An NSNumber object.
 @see NSString's doubleValue
 */
+ (NSNumber *)numberWithString:(NSString *)string;
@end
