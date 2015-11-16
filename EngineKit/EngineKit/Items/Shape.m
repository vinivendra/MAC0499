

#import "Shape.h"

#import "UIColor+Extension.h"


@interface Shape ()
@end


@implementation Shape

@synthesize color = _color;

- (NSArray <NSString *>*)numericProperties {
    return @[];
}

- (NSString *)stringForPhysicsBody {

    if (self.physicsBody.type == SCNPhysicsBodyTypeDynamic) {
        return @"dynamic";
    }
    else if (self.physicsBody.type == SCNPhysicsBodyTypeStatic) {
        return @"static";
    }
    else if (self.physicsBody.type == SCNPhysicsBodyTypeKinematic) {
        return @"kinematic";
    }

    return nil;
}

- (NSMutableArray *)propertyStringsBasedOnTemplate:(Shape *)aTemplate {
    NSMutableArray *statements;
    statements = [super propertyStringsBasedOnTemplate:aTemplate];

    if (![self.color isEqual:aTemplate.color]) {
        [statements addObject:[NSString stringWithFormat:@"color is %@",
                               ((UIColor *)self.color).name]];
    }
    if ((self.physicsBody.type != aTemplate.physicsBody.type)
        || (self.physicsBody && !aTemplate.physicsBody)
        || (!self.physicsBody && aTemplate.physicsBody)) {
        [statements addObject:[NSString stringWithFormat:@"physics is %@",
                               [self stringForPhysicsBody]]];
    }

    return statements;
}

////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setMaterials:(id)materials {
    self.geometry.materials = materials;
}

- (id)materials {
    return self.geometry.materials;
}

- (void)setColor:(id)newValue {
    UIColor *color = [UIColor colorWithObject:newValue];

    _color = color;

    SCNMaterial *material = [SCNMaterial new];

    material.ambient.contents = color;
    material.diffuse.contents = color;
    material.specular.contents = color;

    self.materials = @[material];
}

- (id)color {

    return _color;
}

- (void)setPhysics:(id)physics {
    if ([physics isKindOfClass:[NSString class]]) {
        NSString *string = (NSString *)physics;
        if ([string containsString:@"dynamic"]) {
            self.node.physicsBody = [SCNPhysicsBody dynamicBody];
        } else if ([string containsString:@"static"]) {
            self.node.physicsBody = [SCNPhysicsBody staticBody];
        } else if ([string containsString:@"kinematic"]) {
            self.node.physicsBody = [SCNPhysicsBody staticBody];
        }
    }
}

- (id)physics {
    return self.physicsBody;
}

- (void)setPhysicsBody:(SCNPhysicsBody *)physicsBody {
    self.node.physicsBody = physicsBody;
}

- (SCNPhysicsBody *)physicsBody {
    return self.node.physicsBody;
}

- (void)setVelocity:(id)velocity {
    Vector *vector;

    if ([velocity isKindOfClass:[NSNumber class]]) {
        CGFloat scalar = ((NSNumber *)velocity).doubleValue;
        Vector *old =
            [[Vector alloc] initWithSCNVector3:self.node.physicsBody.velocity];
        vector = [[old normalize] times:scalar];
    } else {
        vector = [[Vector alloc] initWithObject:velocity];
    }

    self.node.physicsBody.velocity = vector.toSCNVector3;
}

- (id)velocity {
    return [[Vector alloc] initWithSCNVector3:self.node.physicsBody.velocity];
}

- (Item *)deepCopy {
    Shape *newItem = [[self class] new];
    [self copyInfoTo:newItem];
    [self copyPhysicsTo:newItem];
    return newItem;
}

- (void)copyInfoTo:(Shape *)item {
    [super copyInfoTo:item];

    item.geometry.materials = self.geometry.materials.copy;
}

- (void)copyPhysicsTo:(Shape *)item {
    if (self.physicsBody) {
        item.physicsBody =
            [SCNPhysicsBody bodyWithType:self.physicsBody.type
                                   shape:self.physicsBody.physicsShape];
        item.velocity = self.velocity;
    }
}

- (NSNumber *)mass {
    return @(self.physicsBody.mass);
}

- (void)setMass:(NSNumber *)mass {
    self.physicsBody.mass = mass.doubleValue;
}

@end
