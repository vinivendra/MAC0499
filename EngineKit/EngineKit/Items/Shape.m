

#import "Shape.h"

#import "UIColor+Extension.h"


@interface Shape ()
@end


@implementation Shape

- (void)assertTheresNoPhysicsBody {
    assert(!self.physicsBody); // Error: change the shape's dimensions only
                               // before choosing a physics type! This shape's
                               // physics have already been calculated and can't
                               // change now to reflect its new size.
}

- (NSString *)stringForPhysicsBody:(SCNPhysicsBody *)physicsBody {

    if (physicsBody.type == SCNPhysicsBodyTypeDynamic) {
        return @"dynamic";
    }
    else if (physicsBody.type == SCNPhysicsBodyTypeStatic) {
        return @"static";
    }
    else if (physicsBody.type == SCNPhysicsBodyTypeKinematic) {
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
                               [self stringForPhysicsBody:self.physicsBody]]];
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

    SCNMaterial *material = [SCNMaterial new];

    material.ambient.contents = color;
    material.diffuse.contents = color;
    material.specular.contents = color;

    self.materials = @[material];
}

- (id)color {

    NSArray <SCNMaterial *> *materials = self.geometry.materials;

    if (materials.count == 0)
        return nil;

    SCNMaterial *material = materials[0];

    UIColor *ambientColor, *diffuseColor, *specularColor;

    id ambient = material.ambient.contents;
    if ([ambient isKindOfClass:[UIColor class]]) {
        ambientColor = (UIColor *)ambient;
    }
    id diffuse = material.diffuse.contents;
    if ([diffuse isKindOfClass:[UIColor class]]) {
        diffuseColor = (UIColor *)diffuse;
    }
    id specular = material.specular.contents;
    if ([specular isKindOfClass:[UIColor class]]) {
        specularColor = (UIColor *)specular;
    }

    if ([ambientColor isEqual:diffuseColor] &&
        [diffuseColor isEqual:specularColor]) {
        return ambientColor;
    }

    return nil;
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

    item.geometry.materials = self.geometry.materials;
}

- (void)copyPhysicsTo:(Shape *)item {
    if (self.physicsBody)
        item.physicsBody =
            [SCNPhysicsBody bodyWithType:self.physicsBody.type
                                   shape:self.physicsBody.physicsShape];
}

@end
