

@class SCNHitTestResult;


@protocol SCNHitTestResultExport <JSExport>
@property (nonatomic, weak, readonly) Item *item;
@property (nonatomic, weak, readonly) Vector *itemPoint;
@property (nonatomic, weak, readonly) Vector *point;
@property (nonatomic, weak, readonly) Vector *itemNormal;
@property (nonatomic, weak, readonly) Vector *normal;
@end


@interface SCNHitTestResult (Export) <SCNHitTestResultExport>
/*!
 The intersected item.
 */
@property (nonatomic, weak, readonly) Item *item;
/*!
 The point of intersection between the hit's ray and the item, measured in the
 item's coordinate space.
 */
@property (nonatomic, weak, readonly) Vector *itemPoint;
/*!
 The point of intersection between the hit's ray and the item, measured in the
 world's coordinate space.
 */
@property (nonatomic, weak, readonly) Vector *point;
/*!
 The normal at the point of intersection between the hit's ray and the item,
 measured in the item's coordinate space.
 */
@property (nonatomic, weak, readonly) Vector *itemNormal;
/*!
 The normal at the point of intersection between the hit's ray and the item,
 measured in the world's coordinate space.
 */
@property (nonatomic, weak, readonly) Vector *normal;
@end
