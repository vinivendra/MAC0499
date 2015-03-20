

/*!
 A simple helper class used to facilitate file management.
 */
@interface FileHelper : NSObject
/*!
 Opens a text file specified by the given @p filename, which is actually a path
 relative to the project folder.
 @param filename The path to the file, relative to the project foler.
 @return An NSString with the file's contents.
 */
+ (NSString *)openTextFile:(NSString *)filename;
/*!
 Used mostly internally by the FileHelper, returns a path to the file specified
 by the given @p filename, which should actually be a path relative to the
 project folder.. The path returned should be ready to be opened by system
 methods such as @p -stringWithContentsOfFile.
 @param filename The path to the file, relative to the project foler.
 @return A path to the specified file.
 */
+ (NSString *)pathForFilename:(NSString *)filename;
@end
