

#import "FileHelper.h"


@implementation FileHelper

+ (NSString *)openTextFile:(NSString *)filename {

    NSString *path = [self pathForFilename:filename];

    assert(path);

    NSError *error;

    NSString *contents = [NSString stringWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];

    assert(!error);

    return contents;
}

+ (NSString *)pathForFilename:(NSString *)filename {

    NSString *mainName = [filename stringByDeletingPathExtension];

    assert(mainName.length != filename.length); // Missing extension!

    NSRange mainNameRange = NSMakeRange(0, mainName.length);
    NSString *extension =
    [filename stringByReplacingCharactersInRange:mainNameRange
                                      withString:@""];


    return [[NSBundle mainBundle] pathForResource:mainName ofType:extension];
}

@end
