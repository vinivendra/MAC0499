// TODO: Make the parser a normal instance (not a singleton), maybe associated
// with a JavaScript object.

#import "Parser.h"

#import "FileHelper.h"

#import "Box.h"
#import "Capsule.h"
#import "Cone.h"
#import "Cylinder.h"
#import "Floor.h"
#import "Plane.h"
#import "Pyramid.h"
#import "Sphere.h"
#import "Text.h"
#import "Torus.h"
#import "Tube.h"

#import "ObjectiveSugar.h"
#import "NSString+Extension.h"
#import "NSNumber+Extension.h"


static NSString *defaultFilename = @"scene.fmt";

static NSString *cleanLine;

static NSArray *properties;
static NSDictionary *itemClasses;

typedef NS_ENUM(NSUInteger, State) { None, Templates, Items };


@interface Parser ()
@property (nonatomic, strong) NSMutableArray *itemsStack;
@property (nonatomic, strong) NSMutableArray *indentationsStack;
@property (nonatomic, strong) NSMutableArray *scopesStack;
@property (nonatomic, strong) NSMutableDictionary *templates;

@property (nonatomic) State state;
@end


@implementation Parser

+ (Parser *)shared {
    static Parser *singleton;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      singleton = [self new];
                  });

    return singleton;
}

- (instancetype)init {
    if (self = [super init]) {

        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,
                      ^{
                          properties = @[
                              @"color",
                              @"physics",
                              @"position",
                              @"scale",
                              @"rotation",
                              @"width",
                              @"length",
                              @"height",
                              @"chamferRadius",
                              @"radius",
                              @"topRadius",
                              @"bottomRadius",
                              @"innerRadius",
                              @"outerRadius",
                              @"ringRadius",
                              @"pipeRadius",
                              @"depth",
                              @"string",
                          ];
                          itemClasses = @{
                              @"box" : [Box class],
                              @"capsule" : [Capsule class],
                              @"cone" : [Cone class],
                              @"cylinder" : [Cylinder class],
                              @"floor" : [Floor class],
                              @"plane" : [Plane class],
                              @"pyramid" : [Pyramid class],
                              @"sphere" : [Sphere class],
                              @"text" : [Text class],
                              @"torus" : [Torus class],
                              @"tube" : [Tube class]
                          };
                      });
    }
    return self;
}


/*!
 Resets the parser's state so that it's ready to parse a new file.
 */
- (void)reset {
    self.templates = [NSMutableDictionary new];

    self.itemsStack = [NSMutableArray new];
    self.indentationsStack = [NSMutableArray new];
    self.scopesStack =
        [NSMutableArray arrayWithObject:[NSMutableDictionary new]];
}

- (void)parseFile:(NSString *)filename {

    [self reset];

    if (!filename) {
        filename = defaultFilename;
    }

    self.state = None;

    NSString *contents = [FileHelper openTextFile:filename];
    NSArray *lines = [contents split:@"\n"];

    Item *currentItem;
    NSUInteger currentIndentation = 0;
    NSUInteger lastIndentation = 0;


    for (NSString *line in lines) {

        cleanLine = [self stripComments:line];

        if (![cleanLine valid])
            continue;


        currentIndentation = cleanLine.indentation;

        if (currentIndentation > lastIndentation) {
            [self pushScopeWithItem:currentItem indentation:currentIndentation];
        }


        while (1) {
            lastIndentation = ((NSNumber *)self.indentationsStack.lastObject)
                                  .unsignedIntegerValue;

            if (lastIndentation > currentIndentation) {
                [self popScope];
            } else {
                break;
            }
        }


        NSUInteger statementLength = cleanLine.length - currentIndentation;
        NSRange whitespaceRange
            = NSMakeRange(currentIndentation, statementLength);
        cleanLine = [cleanLine substringWithRange:whitespaceRange];

        NSMutableArray *components = [[cleanLine split:@" "] mutableCopy];
        for (NSInteger i = 0; i < components.count; i++) {
            if (![components[i] valid]) {
                [components removeObjectAtIndex:i];
                i--;
            }
        }

        NSString *itemName = components.firstObject;
        NSString *propertyName = components.firstObject;

        if ([self currentScopeHasTemplate:itemName]) {
            [currentItem addItem:(Item *)[self.templates[itemName] deepCopy]];
        } else if ([properties containsObject:propertyName]) {
            [self setPropertyFromLine:components onItem:currentItem];
        } else if ([itemName isEqualToString:@"templates"]) {
            self.state = Templates;
        } else if ([itemName isEqualToString:@"items"]) {
            self.state = Items;
        } else {
            Class class = itemClasses[components.lastObject];

            if (!class)
                class = [Item class];


            switch (self.state) {
            case Templates: {
                NSString *templateName = components.firstObject;

                Item *newTemplate = [class template];

                self.templates[templateName] = newTemplate;

                currentItem = newTemplate;

                NSMutableDictionary *currentScope = self.scopesStack.lastObject;
                currentScope[templateName] = templateName;

                break;
            }
            case Items:
            case None:
            default:
                [self.templates[components.firstObject] create];
                break;
            }
        }


        lastIndentation = currentIndentation;
    }
}

/*!
 Interprets the @p line array as a text line separated by spaces. This method
 assumes the line represents an assignment to a property (i.e. "color is red")
 and assigns the value to the property (if the property and the value exist and
 are valid, and if the given Item contains that property).
 In the following case:
 @code
 ball sphere
    color is red
 @endcode
 The line would have been formatted as ["color", "is", "red"] and the Item would
 be the Sphere called "ball".
 @param line The text line, separated by spaces and formatted as an array. For
 instance: ["color", "is", "red"].
 @param item The Item whose property should be set, i.e. the @p Sphere called
 "ball".
 */
- (void)setPropertyFromLine:(NSMutableArray *)line onItem:(Item *)item {
    if ([line.firstObject isEqualToString:@"color"]) {
        NSString *value = line.lastObject;
        ((Shape *)item).color = value;
    } else if ([line.firstObject isEqualToString:@"scale"]) {
        NSNumber *value = [NSNumber numberWithString:line.lastObject];
        ((Shape *)item).scale = value;
    } else if ([line.firstObject isEqualToString:@"physics"]) {
        NSString *value = line.lastObject;
        ((Shape *)item).physics = value;
    } else if ([line.firstObject isEqualToString:@"position"]) {

        NSNumber *z = [NSNumber numberWithString:[line pop]];
        NSNumber *y = [NSNumber numberWithString:[line pop]];
        NSNumber *x = [NSNumber numberWithString:[line pop]];

        ((Shape *)item).position = @[ x, y, z ];
    } else if ([line.firstObject isEqualToString:@"rotation"]) {

        NSNumber *w = [NSNumber numberWithString:[line pop]];
        NSNumber *z = [NSNumber numberWithString:[line pop]];
        NSNumber *y = [NSNumber numberWithString:[line pop]];
        NSNumber *x = [NSNumber numberWithString:[line pop]];

        ((Shape *)item).rotation = @[ x, y, z, w ];
    } else if ([line.firstObject isEqualToString:@"string"]) {
        NSRange stringRange;
        NSIndexSet *stringIndexes;
        NSString *string;

        stringRange = NSMakeRange(2, line.count - 2);
        stringIndexes = [NSIndexSet indexSetWithIndexesInRange:stringRange];
        string = [[line objectsAtIndexes:stringIndexes] join:@" "];

        [item setValue:string forKey:@"string"];
    } else {
        NSNumber *value = [NSNumber numberWithString:line.lastObject];
        [item setValue:value forKey:line.firstObject];
    }
}

/*!
 Takes a line of text and removes comments from it. Supported comments should be
 formatted as
 @code
 [some commands] //[comments]
 @endcode
 where both `[some commands]` and `[comments]` are optional. In this case, both
 the `[comments]` and the slashes would be removed, leaving only the `[some
 commands]`.
 @param string The line of text whose comments will be removed.
 @return A copy of the given string, without the comments.
 */
- (NSString *)stripComments:(NSString *)string {
    NSRange slashes = [string rangeOfString:@"//"];

    if (slashes.location == NSNotFound)
        return string;
    else if (slashes.location == 0)
        return nil;

    NSUInteger length = string.length - slashes.location;
    NSRange comment = NSMakeRange(slashes.location, length);

    return [string stringByReplacingCharactersInRange:comment withString:@""];
}

/*!
 Pushes the necessary information about the current scope onto the appropriate
 stacks.
 @param currentItem        The Item object that is currently being configured.
 @param currentIndentation The indentation level of the current commands.
 */
- (void)pushScopeWithItem:(Item *)currentItem
              indentation:(NSUInteger)currentIndentation {
    [self.itemsStack push:currentItem ?: [NSNull null]];
    [self.scopesStack push:[NSMutableDictionary new]];
    [self.indentationsStack push:@(currentIndentation)];
}

/*!
 Pops the appropriate scope information from the stacks. Essentially returns the
 scope's state to the last pushed state.
 */
- (void)popScope {
    [self.itemsStack pop];
    [self.scopesStack pop];
    [self.indentationsStack pop];
}

/*!
 Attempts to find a reference to a template, if that reference is accessible
 from the current scope.
 @param templateName The name of the referenced template.
 @return @p YES if the template is acessible by the current scope; @p NO
 otherwise.
 */
- (BOOL)currentScopeHasTemplate:(NSString *)templateName {
    for (NSInteger i = (NSInteger)self.scopesStack.count - 1; i >= 0; i--) {

        if (((NSMutableDictionary *)self.scopesStack[i])[templateName])
            return YES;
    }
    return NO;
}

@end
