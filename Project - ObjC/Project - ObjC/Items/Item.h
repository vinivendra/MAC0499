

@interface Item : NSObject
@property (nonatomic, strong) SCNNode *node;
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) SCNGeometry *geometry;

+ (instancetype)create;
@end
