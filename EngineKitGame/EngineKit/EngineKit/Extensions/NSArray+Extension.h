

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSArray (Extension)
/*!
 Checks if the array is valid, which means that it exists and is not empty.
 @warning A valid array may still contain only @p NSNulls.
 @return @p YES if the array is valid, @p NO otherwise.
 */
- (BOOL)valid;
/*!
 Returns an NSNumber with the value from the given @p index, using NSNumber's @p
 -numberWithObject: method. If the index goes past the array's bounds, returns
 @(0).
 @param index The index in the array from which to get the number.
 @return An NSNumber index.
 */
- (NSNumber *)numberAtIndex:(NSUInteger)index;
/*!
 Returns a CGFloat with the value from the given @p index, using NSNumber's @p
 -numberWithObject: method. If the index goes past the array's bounds, returns
 0.0f.
 @param index The index in the array from which to get the number.
 @return An NSNumber index.
 */
- (CGFloat)floatAtIndex:(NSUInteger)index;
/*!
 Returns the object at the selected index. If the index is out of bounds,
 returns nil.
 @param index The index from which to get the object.
 @return The object at the given index.
 */
- (id)at:(NSUInteger)index;
@end
