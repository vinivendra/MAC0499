

#import <JavaScriptCore/JavaScriptCore.h>


@interface JSContext (Extension)
/*!
 The instance of JSContext meant to be used throughout the appication.
 @note If ever multiple JS files are used, one might consider creating some type
 of Manager class to manage the multiple contexts that might be needed.
 @return A singleton instance of JSContext.
 */
+ (JSContext *)shared;
@end
