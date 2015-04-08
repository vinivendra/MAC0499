

#import "Parser.h"


static NSString *cleanLine;


@implementation Parser

+ (void)parseFile:(NSString *)filename {
    NSString *contents = [FileHelper openTextFile:filename];

    NSLog(@"Contents:\n%@", contents);
    NSLog(@"Parsing:\n");

    NSArray *lines = [contents split:@"\n"];

    NSMutableArray *itemsStack = [NSMutableArray new];
    NSMutableArray *indentationsStack = [NSMutableArray new];
    id currentItem = @"";
    NSUInteger currentIndentation = 0;
    NSUInteger lastIndentation = 0;

    for (NSString *line in lines) {

        cleanLine = [self stripComments:line];

        unless([cleanLine valid]) continue;

        currentIndentation = cleanLine.indentation;

        if (currentIndentation > lastIndentation) {
            [itemsStack push:currentItem];
            [indentationsStack push:@(currentIndentation)];
            currentItem = cleanLine;
        }

        while (1) {
            lastIndentation = ((NSNumber *)indentationsStack.lastObject)
                                  .unsignedIntegerValue;
            if (lastIndentation > currentIndentation) {
                [indentationsStack pop];
                [itemsStack pop];
            } else {
                break;
            }
        }

        NSLog(@"Parsing command: %@ on item: %@",
              cleanLine,
              itemsStack.lastObject);

        lastIndentation = currentIndentation;
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
