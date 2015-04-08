// TODO: Implement other properties, add other Items.

#import "Parser.h"


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

- (instancetype)init {
    if (self = [super init]) {
        self.templates = [NSMutableDictionary new];

        self.itemsStack = [NSMutableArray new];
        self.indentationsStack = [NSMutableArray new];
        self.scopesStack =
            [NSMutableArray arrayWithObject:[NSMutableDictionary new]];

        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,
                      ^{
                          properties =
                              @[ @"color", @"physics", @"position", @"scale" ];
                          itemClasses = @{
                              @"sphere" : [Sphere class],
                              @"pyramid" : [Pyramid class]
                          };
                      });
    }
    return self;
}

- (void)parseFile:(NSString *)filename {

    self.state = None;

    NSString *contents = [FileHelper openTextFile:filename];
    NSArray *lines = [contents split:@"\n"];

    Item *currentItem;
    NSUInteger currentIndentation = 0;
    NSUInteger lastIndentation = 0;


    for (NSString *line in lines) {

        cleanLine = [self stripComments:line];

        unless([cleanLine valid]) continue;


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

        NSArray *components = [cleanLine split:@" "];

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

- (void)setPropertyFromLine:(NSArray *)line onItem:(Item *)item {
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
        NSMutableArray *mutableLine = line.mutableCopy;

        NSNumber *z = [NSNumber numberWithString:[mutableLine pop]];
        NSNumber *y = [NSNumber numberWithString:[mutableLine pop]];
        NSNumber *x = [NSNumber numberWithString:[mutableLine pop]];

        ((Shape *)item).position = @[ x, y, z ];
    }
}

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

- (void)pushScopeWithItem:(Item *)currentItem
              indentation:(NSUInteger)currentIndentation {
    [self.itemsStack push:currentItem ?: [NSNull null]];
    [self.scopesStack push:[NSMutableDictionary new]];
    [self.indentationsStack push:@(currentIndentation)];
}

- (void)popScope {
    [self.itemsStack pop];
    [self.scopesStack pop];
    [self.indentationsStack pop];
}

- (BOOL)currentScopeHasTemplate:(NSString *)templateName {
    for (NSInteger i = (NSInteger)self.scopesStack.count - 1; i >= 0; i--) {

        if (((NSMutableDictionary *)self.scopesStack[i])[templateName])
            return YES;
    }
    return NO;
}

@end
