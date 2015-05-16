

#import <JavaScriptCore/JavaScriptCore.h>
#import <SceneKit/SceneKit.h>


@class Physics;


@protocol PhysicsExport <JSExport>
@property (nonatomic, weak) id addContact;
@property (nonatomic, strong) id gravity;
@end


/*!
 Used to manage global physics properties, such as gravity, force fields, etc.
 Meant as a replacement for the scene's physicsWorld property.
 */
@interface Physics : NSObject <PhysicsExport, SCNPhysicsContactDelegate>
/*!
 The singleton instance of the Physics class. The class is meant to be used as a
 singleton and manages only other singleton instances, such as the SCNScene
 singleton.
 @return A singleton instance of the Physics class.
 */
+ (Physics *)shared;
/*!
 An easy way to access the shared SCNScene instance.
 @return The SCNScene singleton.
 */
- (SCNScene *)scene;
/*!
 Used to set the SCNScene's Physics World's gravity property. If the object is
 an NSNumber, the gravity will be a vector pointing in the negative y direction
 with the NSNumber as its magnitude. Otherwise, the object will be used to
 instantiate a Vector, which will then be set.
 
 The getter always returns a Vector version of the physics world's SCNVector3.
 */
@property (nonatomic, strong) id gravity;

/*!
 @p addContact is a property used only for its setter. It's the main way to register a Contact object, which is used to handle contacts in JavaScript code.
 */
@property (nonatomic, weak) id addContact;
@end
