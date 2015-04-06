

#import <SceneKit/SceneKit.h>


@interface SCNNode (Extension)
/*!
 A reference to the node's Item, enabling one to find the Item that encapsulates
 some node when given only the node, such as in SCNPhysics callbacks.
 */
@property (nonatomic, strong) Item *item;
/*!
 Factory method used to create a copy with any relevant information from the
 receiver.
 @return A new instance of SCNNode, representing a deep copy of the receiver.
 */
- (instancetype)deepCopy;
@end