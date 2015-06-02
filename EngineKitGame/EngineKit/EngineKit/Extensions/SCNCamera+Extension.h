

#import <SceneKit/SceneKit.h>

#import "Item.h"


@interface SCNCamera (Extension)
/*!
 A singleton `Item` that contains the shared singleton of the `SCNCamera` class.
 @return An `Item` containing an `SCNCamera`.
 */
+ (Item *)shared;
@end
