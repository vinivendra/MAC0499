
import Foundation
import SceneKit
import JavaScriptCore



let sphere_radius: CGFloat = 1

func default_sphere() -> SCNSphere {
    return SCNSphere(radius: sphere_radius)
}



@objc class Sphere: Shape {
    
    var radius: CGFloat {
        set { sphere.radius = newValue }
        get { return sphere.radius     }
    }
    
    override var size: CGFloat {
        set {
            sphere.radius = newValue / 2
        }
        get {
            return 0;
        }
    }
    
    var sphere: SCNSphere {
        set { geometry = newValue }
        get {
            if let optional = geometry as? SCNSphere {
                return optional
            }
            else {
                geometry = default_sphere()
                return geometry as SCNSphere
            }
        }
    }
    
    override init() {
        super.init(geometry: default_sphere())
    }
}