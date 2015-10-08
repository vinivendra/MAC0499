

#import "JSValue+Extension.h"
#import "ObjectiveSugar.h"


@implementation JSValue (Extension)

- (NSString *)functionName {
    NSString *functionString = self.toString;
    NSArray *functionElements = [functionString split];
    NSString *functionHeader = functionElements[1];
    return [functionHeader split:@"("][0];
}

@end
