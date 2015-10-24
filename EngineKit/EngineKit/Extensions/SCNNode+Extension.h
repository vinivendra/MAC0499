

#import <SceneKit/SceneKit.h>

#import "Item.h"


@interface SCNNode (Extension)
/*!
 A reference to the node's Item, enabling one to find the Item that encapsulates
 some node when given only the node, such as in SCNPhysics callbacks.
 */
@property (nonatomic, strong) Item *item;
@end