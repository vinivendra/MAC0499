

@interface NSArray (Extension)
/*!
 Checks if the array is valid, which means that it exists and is not empty.
 @warning A valid array may still contain only @p NSNulls.
 @return @p YES if the array is valid, @p NO otherwise.
 */
- (BOOL)valid;
@end
