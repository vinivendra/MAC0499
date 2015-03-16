

#import "Shape.h"


@implementation Shape

- (void)setColor:(id)newValue {
    Color *color = [Color colorWithObject:newValue];
    
    SCNMaterial *material = [SCNMaterial new];
    
    material.ambient.contents = [color times:0.7];
    material.diffuse.contents = [color times:0.9];
    material.specular.contents = color;
    
    self.geometry.materials = @[material];
    
    self.position = SCNVector3Make(0, 0, -2);
}

- (id)color {
    assert(NO); // Assignment to writeonly property.
    return nil;
}

@end
