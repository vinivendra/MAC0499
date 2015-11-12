

#import "Text.h"

#import "ObjectiveSugar.h"
#import "NSString+Extension.h"


static NSString *fontName = @"HelveticaNeue";
static NSInteger fontSize = 1;


@implementation Text

- (NSArray <NSString *>*)numericProperties {
    return @[@"depth",
             @"string"];
}

+ (instancetype)text {
    return [self new];
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initAndAddToScene {
    if (self = [super initAndAddToScene]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.text = [SCNText new];
    self.text.extrusionDepth = 0.1;
    self.weight = @"Light";
}

- (instancetype)initWithString:(id)string depth:(CGFloat)depth {
    if (self = [super initAndAddToScene]) {
        self.text = [SCNText textWithString:string extrusionDepth:depth];
    }
    return self;
}

- (Item *)deepCopy {
    Shape *newItem = [[self class] new];
    [self copyInfoTo:newItem];
    [super copyPhysicsTo:newItem];
    return newItem;
}

- (void)copyInfoTo:(Text *)item {
    [super copyInfoTo:item];

    item.depth = self.depth;
    item.string = self.string;
    item.text.font = self.text.font;
}

- (NSMutableArray *)propertyStringsBasedOnTemplate:(Text *)template {
    NSMutableArray *statements = [NSMutableArray new];

    if (![self.depth isEqual:template.depth]) {
        [statements addObject:[NSString stringWithFormat:@"depth is %@",
                               self.depth]];
    }
    if (![self.string isEqualToString:template.string]) {
        [statements addObject:[NSString stringWithFormat:@"string is %@",
                               self.string]];
    }

    NSMutableArray *superStatements;
    superStatements = [super propertyStringsBasedOnTemplate:template];
    statements = [[statements arrayByAddingObjectsFromArray:superStatements]
                  mutableCopy];
    return statements;
}

- (NSString *)processString:(id)newValue {
    if ([newValue isKindOfClass:[NSString class]]) {
        NSString *string = newValue;

        string = [string stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];

        return string;
    }

    return newValue;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setText:(SCNText *)text {
    self.geometry = text;
}

- (SCNText *)text {
    return (SCNText *)self.geometry;
}


- (void)setString:(id)string {
    self.text.string = [self processString:string];
}

- (id)string {
    return self.text.string;
}

- (void)setDepth:(NSNumber *)depth {
    self.text.extrusionDepth = depth.doubleValue;
}

- (NSNumber *)depth {
    return @(self.text.extrusionDepth);
}

- (NSString *)weight {
    NSString *name = self.text.font.fontName;
    NSArray *components = [name split:@"-"];
    if (components.count > 1) {
        return components.lastObject;
    }
    else {
        return @"regular";
    }
}

- (void)setWeight:(NSString *)weight {
    NSString *name;

    if ([weight caseInsensitiveCompare:@"regular"] == NSOrderedSame
        || !weight.valid) {
        name = fontName;
    }
    else {
        weight = weight.capitalizedString;
        name = [NSString stringWithFormat:@"%@-%@", fontName, weight];
    }

    UIFont *font = [UIFont fontWithName:name size:fontSize];
    self.text.font = font;
}

@end
