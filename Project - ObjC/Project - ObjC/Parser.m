

#import "Parser.h"


@implementation Parser

+ (void)parseFile:(NSString *)filename {
    NSString *contents = [FileHelper openTextFile:filename];

    NSLog(@"Contents:\n%@", contents);
    NSLog(@"Parsing:\n");

    NSArray *lines = [contents split:@"\n"];
    
    for (NSString *line in lines) {
        
        NSString *cleanLine = [self stripComments:line];

        unless([cleanLine valid]) continue;
        
        
    }
}

+ (NSString *)stripComments:(NSString *)string {
    NSRange slashes = [string rangeOfString:@"//"];

    if (slashes.location == NSNotFound)
        return string;
    else if (slashes.location == 0)
        return nil;

    NSUInteger length = string.length - slashes.location;
    NSRange comment = NSMakeRange(slashes.location, length);

    return [string stringByReplacingCharactersInRange:comment withString:@""];
}

@end
