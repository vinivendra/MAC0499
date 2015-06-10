

#import "Position.h"


@interface Position ()
@property (nonatomic) SCNVector3 vector;
@end


@implementation Position


//------------------------------------------------------------------------------
#pragma mark Getting the Position's information
//------------------------------------------------------------------------------


- (SCNVector4)toSCNVector4 {
    return SCNVector4Make(self.x, self.y, self.z, 0.0);
}

//------------------------------------------------------------------------------
#pragma mark - Common Position constants
//------------------------------------------------------------------------------

+ (instancetype)origin {
    return [[[self class] alloc] initWithVector:[Vector origin]];
}

//------------------------------------------------------------------------------
#pragma mark - Initializing Position objects
//------------------------------------------------------------------------------

- (instancetype)initWithVector:(Vector *)vector {
    self = [self initWithSCNVector3:vector.toSCNVector3];
    return self;
}

@end
