

#import "Light.h"

#import "Sphere.h"

#import "UIColor+Extension.h"


@interface Light ()
@property (nonatomic, weak) SCNLight *light;
@end


@implementation Light

- (instancetype)init {
    if (self = [super init]) {
        [self addSCNLight];
    }
    return self;
}

- (instancetype)initAndAddToScene {
    if (self = [super initAndAddToScene]) {
        [self addSCNLight];
    }
    return self;
}

- (void)addSCNLight {
    self.node.light = [SCNLight new];
    self.position = [[Position alloc] initWithX:0 Y:0 Z:10];
}

- (NSString *)lightTypeForString:(NSString *)string {
    static NSDictionary *types;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      types = @{SCNLightTypeAmbient.lowercaseString: SCNLightTypeAmbient,
                                SCNLightTypeDirectional.lowercaseString: SCNLightTypeDirectional,
                                SCNLightTypeOmni.lowercaseString: SCNLightTypeOmni,
                                SCNLightTypeSpot.lowercaseString: SCNLightTypeSpot,
                                @"ambient".lowercaseString: SCNLightTypeAmbient,
                                @"directional".lowercaseString: SCNLightTypeAmbient,
                                @"omni".lowercaseString: SCNLightTypeAmbient,
                                @"spot".lowercaseString: SCNLightTypeAmbient};
                  });

    return types[string.lowercaseString];
}

- (NSString *)stringForLightType:(NSString *)type {
    static NSDictionary *strings;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      strings = @{SCNLightTypeAmbient: @"ambient",
                                  SCNLightTypeAmbient: @"directional",
                                  SCNLightTypeAmbient: @"omni",
                                  SCNLightTypeAmbient: @"spot"};
                  });

    return strings[type];
}

#pragma mark - Override

- (void)copyInfoTo:(Item *)item {
    [super copyInfoTo:item];

    if ([item isKindOfClass:[Light class]]) {
        Light *light = (Light *)item;
        light.type = self.type;
        light.color = self.color;
    }
}

- (NSMutableArray *)propertyStringsBasedOnTemplate:(Light *)template {
    NSMutableArray *statements;
    statements = [super propertyStringsBasedOnTemplate:template];
    
    if (![self.type isEqual:template.type]) {
        [statements addObject:[NSString stringWithFormat:@"type is %@",
                               [self stringForLightType:self.type]]];
    }
    if (![self.color isEqual:template.color]) {
        [statements addObject:[NSString stringWithFormat:@"color is %@",
                               ((UIColor *)self.color).name]];
    }

    return statements;
}

#pragma mark - Property Overrides

- (SCNLight *)light {
    return self.node.light;
}

- (void)setLight:(SCNLight *)light {
    self.node.light = light;
}

- (id)color {
    return self.light.color;
}

- (void)setColor:(id)newValue {
    UIColor *color = [UIColor colorWithObject:newValue];
    self.light.color = color;
}

- (void)setType:(NSString *)type {
    self.light.type = [self lightTypeForString:type];
}

- (NSString *)type {
    return self.light.type;
}

@end
