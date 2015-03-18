

@class Floor;


@protocol FloorExport <JSExport>
+ (instancetype)create;
//
@property (nonatomic, strong) id position;
@property (nonatomic, strong) id rotation;
@property (nonatomic, strong) id scale;
//
@property (nonatomic, strong) id color;

//
+ (instancetype)floor;
@end


@interface Floor : Shape <FloorExport>
+ (instancetype)floor;
@end
