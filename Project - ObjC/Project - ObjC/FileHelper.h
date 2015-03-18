

#import <Foundation/Foundation.h>


@interface FileHelper : NSObject
+ (NSString *)openTextFile:(NSString *)filename;
+ (NSString *)pathForFilename:(NSString *)filename;
@end
