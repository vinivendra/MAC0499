

#import <SceneKit/SceneKit.h>

#import "Item.h"


@protocol SceneExport <JSExport>
- (Item *)itemNamed:(NSString *)name;
@end


@interface SCNScene (Extension) <SceneExport>
// TODO: doc
+ (SCNScene *)currentScene;
- (void)makeCurrentScene;
/*!
 Adds an @p Item to the scene, much like adding an SCNNode as a subnode to the
 scene's rootNode.
 @param item The Item to be added to the scene.
 */
- (void)addItem:(Item *)item;
// TODO: doc
- (void)deepCopyToScene:(SCNScene *)scene;
- (Item *)itemNamed:(NSString *)name;
@end


