

#import <JavaScriptCore/JavaScriptCore.h>
#import <SceneKit/SceneKit.h>

#import "TriggerActionManager.h"


@protocol ParserExport <JSExport>
- (void)parseFile:(NSString *)filename;
@end


/*!
 The Parser class is responsible for interpreting the *.fmt files, creating the
 templates and items and adding them to the scene as necessary. To use it,
 et the shared instance and call its parseFile method on the file that should be
 interpreted.
 */
@interface Parser : NSObject <ParserExport>
/*!
 Interprets the given file, creates the necessary Templates and Items, sets
 their properties and adds them to the scene as requested.
 @param filename The name of the file, as should be recognized by FileHelper's
 -openTextFile: method.
 */
- (void)parseFile:(NSString *)filename;
// TODO: doc
- (void)parseString:(NSString *)contents;
- (NSString *)writeFileForScene:(SCNScene *)scene;
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) TriggerActionManager *triggerActionManager;
@end
