

#import "SCNScene+Extension.h"


@implementation SCNScene (Extension)

+ (SCNScene *)shared {
    static SCNScene *singleton;
    
    static dispatch_once_t onceToken;
    dispatch_once( &onceToken,
                  ^{
                      singleton = [self new];
                  } );
    
    return singleton;
}


- (void)addItem:(Item *)item {
    [self.rootNode addChildNode:item];
}

@end
