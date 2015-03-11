
import Foundation
import SceneKit
import JavaScriptCore



@objc class Sphere: Shape {
    
    var radius: CGFloat {
        set { sphere.radius = newValue }
        get { return sphere.radius     }
    }
    
    override var size: CGFloat {
        set {
            radius = newValue / 2
        }
        get {
            return radius * 2
        }
    }

    var sphere: SCNSphere {
        set { geometry = newValue          }
        get { return geometry as SCNSphere }
    }
    
    override init() {
        super.init(geometry: SCNSphere())
    }
}

