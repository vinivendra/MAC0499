

@class Floor;


@protocol FloorExport <JSExport>
+ (instancetype)create;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) id scale;
//
@property (nonatomic, strong) id color;
@property (nonatomic, strong) id physics;
//
+ (instancetype)floor;
@end


/*!
 An inifinite plane, usually representing a floor or some type of background for
 a scene. Able to reflect the scene in front of it. Essentially, a wrapper for
 @p SCNFloor.
 */
@interface Floor : Shape <FloorExport>
/*!
 Creates a new instance of @p Floor, spaning the @p xz plane and with @p y=0 (in
 its local coordinate space).
 @return a new instance of @p Floor.
 */
+ (instancetype)floor;
@end
