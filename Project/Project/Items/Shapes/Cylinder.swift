
import Foundation
import SceneKit
import JavaScriptCore



let cylinder_radius: CGFloat = 1
let cylinder_height: CGFloat = 1

func default_cylinder() -> SCNCylinder {
    return SCNCylinder(radius: cylinder_radius, height: cylinder_height)
}



@objc class Cylinder: Shape {
    
    var radius: CGFloat {
        set { cylinder.radius = newValue }
        get { return cylinder.radius     }
    }
    
    var height: CGFloat {
        set { cylinder.height = newValue }
        get { return cylinder.height     }
    }
    
    override var size: CGFloat {
        set {
            cylinder.radius = newValue / 2
            cylinder.height = newValue
        }
        get {
            return 0;
        }
    }
    
    var cylinder: SCNCylinder {
        set { geometry = newValue }
        get {
            if let optional = geometry as? SCNCylinder {
                return optional
            }
            else {
                geometry = default_cylinder()
                return geometry as SCNCylinder
            }
        }
    }
    
    override init() {
        super.init(geometry: default_cylinder())
    }
}