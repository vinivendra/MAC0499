

#import <JavaScriptCore/JavaScriptCore.h>
#import "Common.h"


@interface JSValue (Extension)
@property (nonatomic, readonly) NSString *functionName;
@end
