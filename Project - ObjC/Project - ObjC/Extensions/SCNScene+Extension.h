

#import <SceneKit/SceneKit.h>

#import "Item.h"


typedef SCNScene Scene;


@interface SCNScene (Extension)
+ (SCNScene *)shared;
- (void)addItem:(Item *)item;
@end
