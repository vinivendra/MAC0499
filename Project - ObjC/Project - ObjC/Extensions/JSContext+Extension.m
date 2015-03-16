

#import "JSContext+Extension.h"


@implementation JSContext ( Extension )

+ (JSContext *)shared {
    static JSContext *singleton;

    static dispatch_once_t onceToken;
    dispatch_once( &onceToken,
                   ^{
                       singleton = [self new];
                   } );

    return singleton;
}

@end
