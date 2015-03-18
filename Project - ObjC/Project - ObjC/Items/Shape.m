

#import "Shape.h"


@implementation Shape

- (void)setColor:(id)newValue {
    Color *color = [Color colorWithObject:newValue];
    
    SCNMaterial *material = [SCNMaterial new];
    
    material.ambient.contents = color;
    material.diffuse.contents = color;
    material.specular.contents = color;
    
    self.geometry.materials = @[material];
}

- (id)color {
    assert(NO); // Assignment to writeonly property.
    return nil;
}

@end
