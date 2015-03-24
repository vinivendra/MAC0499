

@class Physics;


@protocol PhysicsExport <JSExport>
@property (nonatomic, strong) id gravity;
@end


/*!
 Used to manage global physics properties, such as gravity, force fields, etc.
 Meant as a replacement for the scene's physicsWorld property.
 */
@interface Physics : NSObject <PhysicsExport>
/*!
 Used to set the SCNScene's Physics World's gravity property. If the object is
 an NSNumber, the gravity will be a vector pointing in the negative y direction
 with the NSNumber as its magnitude. Otherwise, the object will be used to
 instantiate a Vector, which will then be set.

 The getter always returns a Vector version of the physics world's SCNVector3.
 */
@property (nonatomic, strong) id gravity;
@end
