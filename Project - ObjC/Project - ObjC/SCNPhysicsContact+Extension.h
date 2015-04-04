

@class SCNPhysicsContact;


@protocol SCNPhysicsContactExport <JSExport>
@property (nonatomic, readonly) Item *firstItem;
@property (nonatomic, readonly) Item *secondItem;
@property (nonatomic, readonly) Vector *normal;
@property (nonatomic, readonly) Position *point;
@property (nonatomic, readonly) NSNumber *impulse;
@property (nonatomic, readonly) NSNumber *overlap;
@end


@interface SCNPhysicsContact (Extension) <SCNPhysicsContactExport>
@end
