

#import <SceneKit/SceneKit.h>

#import "Item.h"


typedef SCNScene Scene;


@interface SCNScene (Extension)
/*!
 The singleton instance of a scene, meant to be used by the whole application.
 If multiple scenes are needed, one might consider changing this approach.
 @return An initialized instance of SCNScene.
 */
+ (SCNScene *)shared;
/*!
 Adds an @p Item to the scene, much like adding an SCNNode as a subnode to the
 scene's rootNode.
 @param item The Item to be added to the scene.
 */
- (void)addItem:(Item *)item;
@end


