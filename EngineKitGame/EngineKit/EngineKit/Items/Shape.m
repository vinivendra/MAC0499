

#import "Shape.h"

#import "UIColor+Extension.h"


@implementation Shape

- (void)assertTheresNoPhysicsBody {
    assert(!self.physicsBody); // Error: change the shape's dimensions only
                               // before choosing a physics type! This shape's
                               // physics have already been calculated and can't
                               // change now to reflect its new size.
}

///////////////////////////////////////////////////////////////////////////////////
#pragma mark - Property Overriding

- (void)setColor:(id)newValue {
    Color *color = [Color colorWithObject:newValue];

    SCNMaterial *material = [SCNMaterial new];

    material.ambient.contents = color;
    material.diffuse.contents = color;
    material.specular.contents = color;

    self.geometry.materials = @[ material ];
}

- (id)color {
    assert(NO); // Assignment to writeonly property.
    return nil;
}

- (void)setPhysics:(id)physics {
    assert(!self.physicsBody); // Physics type can only be chosen once!

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

    assert(self.physicsBody); // Oops, trying to set an unsupported object.
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
