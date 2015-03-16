

#import "Shape.h"


@implementation Shape

- (void)setColor:(UIColor *)color {
    SCNMaterial *material = [SCNMaterial new];
    
    material.ambient.contents = [color times:0.7];
    material.diffuse.contents = [color times:0.9];
    material.specular.contents = color;
    
    self.geometry.materials = @[material];
}

- (UIColor *)color {
    assert(NO); // Assignment to writeonly property.
    return nil;
}

@end
