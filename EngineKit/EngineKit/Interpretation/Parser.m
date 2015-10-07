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
#import "Camera.h"
#import "Light.h"

#import "ObjectiveSugar.h"
#import "NSString+Extension.h"
#import "NSNumber+Extension.h"
#import "SCNNode+Extension.h"


static NSString *defaultFilename = @"scene.fmt";

static NSString *cleanLine;

typedef NS_ENUM(NSUInteger, State) { None, Templates, Items };


@interface Parser ()
@property (nonatomic, strong) NSMutableArray *itemsStack;
@property (nonatomic, strong) NSMutableArray *indentationsStack;

@property (nonatomic) State state;
@end


@implementation Parser

+ (Parser *)shared {
    static Parser *singleton;

    if (!singleton) {
        singleton = [self new];
    }

    return singleton;
}

- (instancetype)init {
    if (self = [super init]) {

      [Item registerTemplate:[Box template]];
      [Item registerTemplate:[Capsule template]];
      [Item registerTemplate:[Cone template]];
      [Item registerTemplate:[Cylinder template]];
      [Item registerTemplate:[Floor template]];
      [Item registerTemplate:[Plane template]];
      [Item registerTemplate:[Pyramid template]];
      [Item registerTemplate:[Sphere template]];
      [Item registerTemplate:[Text template]];
      [Item registerTemplate:[Torus template]];
      [Item registerTemplate:[Tube template]];

      [Item registerTemplate:[Light template]];
      [Item registerTemplate:[Camera template]];
    }
    return self;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Reading

/*!
 Resets the parser's state so that it's ready to parse a new file.
 */
- (void)reset {
    self.itemsStack = [NSMutableArray new];
    self.indentationsStack = [NSMutableArray new];
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
    Item *nextItem;
    NSUInteger currentIndentation = 0;
    NSUInteger lastIndentation = 0;


    for (NSString *line in lines) {

        //// Clean up the line
        cleanLine = [self stripComments:line];

        if (![cleanLine valid])
            continue;


        //// Handle Indentation
        currentIndentation = cleanLine.indentation;

        // If we're going one level deeper
        if (currentIndentation > lastIndentation) {
            [self pushScopeWithItem:currentItem indentation:currentIndentation];
            currentItem = nextItem;
        }

        // If we're going back one (or more) level(s)
        while (YES) {
            NSNumber *lastIndentationAux = self.indentationsStack.lastObject;
            lastIndentation = lastIndentationAux.unsignedIntegerValue;

            if (lastIndentation > currentIndentation) {
                id lastItem = self.itemsStack.lastObject;
                if (lastItem == [NSNull null]) {
                    lastItem = nil;
                }
                currentItem = lastItem;

                [self popScope];
            } else {
                break;
            }
        }

        // FIXME: This shouldn't be hard coded
        if (currentIndentation == 4) {
            currentItem = nil;
        }

        //// Clean up the line
        NSUInteger statementLength = cleanLine.length - currentIndentation;
        NSRange whitespaceRange
        = NSMakeRange(currentIndentation, statementLength);
        cleanLine = [cleanLine substringWithRange:whitespaceRange];

        //// Split the line
        NSMutableArray *components = [[cleanLine split:@" "] mutableCopy];
        for (NSInteger i = 0; i < components.count; i++) {
            if (![components[i] valid]) {
                [components removeObjectAtIndex:i];
                i--;
            }
        }

        //// Analyze the line
        NSString *itemName = components.firstObject;

        // If we're adding a new Item to a Template that's being created
        if (self.state == Templates &&
            [Item templateNamed:itemName] &&
            currentItem) {

            Item *template = [Item templateNamed:itemName];
            Item *newItem = [template create];
            newItem.templateName = itemName;
            [currentItem addItem:newItem];
            nextItem = newItem;
        }
        // If we're starting the Templates section
        else if ([itemName isEqualToString:@"templates"]) {
            self.state = Templates;
            currentItem = nil;
            nextItem = nil;
        }
        // If we're starting the Items section
        else if ([itemName isEqualToString:@"items"]) {
            self.state = Items;
            currentItem = nil;
            nextItem = nil;
        }
        else {
            BOOL done = NO;

            switch (self.state) {
                case Templates: {
                    NSString *templateName = components.lastObject;
                    Item *existingTemplate = [Item templateNamed:templateName];

                    if (existingTemplate) {
                        NSString *newTemplateName = components.firstObject;
                        Item *newTemplate = [existingTemplate template];

                        newTemplate.templateName = newTemplateName;

                        [Item registerTemplate:newTemplate];

                        currentItem = newTemplate;
                        nextItem = newTemplate;

                        done = YES;
                    }

                    break;
                }
                case Items: {
                    NSString *templateName = components.firstObject;

                    Item *chosenItem;
                    chosenItem = [currentItem childItemWithName:templateName
                                                    recursively:NO];
                    if (chosenItem) {
                        nextItem = chosenItem;
                        done = YES;
                    }
                    else {
                        Item *template = [Item templateNamed:itemName];

                        if (template) {
                            Item *newItem = [template create];
                            newItem.templateName = itemName;
                            [currentItem addItem:newItem];
                            nextItem = newItem;

                            done = YES;
                        }
                    }

                    break;
                }
                default: {
                    break;
                }
            }

            if (!done) {
                [self setPropertyFromLine:components
                                   onItem:currentItem];
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
        id value;

        NSCharacterSet *digits = [NSCharacterSet decimalDigitCharacterSet];
        NSRange digitRange = [line.lastObject rangeOfCharacterFromSet:digits];
        if (digitRange.location != NSNotFound) {
            value = [NSNumber numberWithString:line.lastObject];
        }
        else {
            value = line.lastObject;
        }

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
    [self.indentationsStack push:@(currentIndentation)];
}

/*!
 Pops the appropriate scope information from the stacks. Essentially returns the
 scope's state to the last pushed state.
 */
- (void)popScope {
    [self.itemsStack pop];
    [self.indentationsStack pop];
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Writing

- (void)writeFileForScene:(SCNScene *)scene {
    [self reset];

    NSMutableArray *statements = [NSMutableArray new];
    [statements addObject:@"templates"];

    for (id object in [Item templates]) {
        
        Item *template = (Item *)object;
        NSString *templateName = template.templateName;
        NSString *className = NSStringFromClass([template class]);
        BOOL templateIsOriginal = [className isEqualToString:templateName];

        if (!templateIsOriginal) {
            Item *originalTemplate = [Item templateNamed:className];

            if (!originalTemplate) {
                originalTemplate = [Item template];
            }

            NSString *templateString;
            templateString = [template
                              parserStringBasedOnTemplate:originalTemplate
                              withTemplateName:YES];
            [statements addObject:templateString];
        }
    }


    [statements addObject:@"\nitems"];
    
    for (SCNNode *node in scene.rootNode.childNodes) {
        Item *item = node.item;
        
        NSString *itemString = [item parserString];;

        unless([item isKindOfClass:[Camera class]])
            [statements addObject:itemString];
    }
    
    NSString *result = [statements join:@"\n"];
    
    NSLog(@"\n\n%@", result);
}


@end
