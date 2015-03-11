
import Foundation
import SceneKit
import JavaScriptCore



extension SCNCylinder {
    var size: CGFloat {
        set {
            radius = newValue / 2
            height = newValue
        }
        get {
            return max(radius * 2, height)
        }
    }
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
    
    var cylinder: SCNCylinder {
        set { geometry = newValue            }
        get { return geometry as SCNCylinder }
    }
    
    override init() {
        super.init(geometry: SCNCylinder())
    }
}