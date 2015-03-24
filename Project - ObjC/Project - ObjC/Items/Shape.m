

#import "Shape.h"


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

@end
