
import Foundation
import SceneKit
import JavaScriptCore




@objc class Plane: Shape {
    
    var width: CGFloat {
        set { plane.width = newValue }
        get { return plane.width     }
    }
    
    var height: CGFloat {
        set { plane.height = newValue }
        get { return plane.height     }
    }
    
    override var size: CGFloat {
        set {
            width = newValue
            height = newValue
        }
        get {
            return max(width, height)
        }
    }
    
    var plane: SCNPlane {
        set { geometry = newValue        }
        get { return geometry as SCNPlane }
    }
    
    override init() {
        super.init(geometry: SCNPlane())
    }
}

