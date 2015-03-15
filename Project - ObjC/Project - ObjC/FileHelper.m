

#import "FileHelper.h"


@implementation FileHelper

+ (NSString *)openTextFile:(NSString *)filename {
    
    NSString *path = [self pathForFilename:filename];
    
    NSError *error;
    
    NSString *contents = [NSString stringWithContentsOfFile:path
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];
    
    assert(!error);
    
    return contents;
}

+ (NSString *)pathForFilename:(NSString *)filename {
    
    NSMutableArray *filenameParts = [[filename componentsSeparatedByString:@"."] mutableCopy];
    
    NSString *extension = [filenameParts pop];
    
    NSString *mainName = [filenameParts join:@"."];
    
    return [[NSBundle mainBundle] pathForResource:mainName ofType:extension];
}

@end
