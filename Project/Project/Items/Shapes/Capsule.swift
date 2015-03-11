
import Foundation
import SceneKit
import JavaScriptCore




@objc class Capsule: Shape {
    
    var radius: CGFloat {
        set { capRadius = newValue }
        get { return capRadius     }
    };  var capRadius: CGFloat {
        set { capsule.capRadius = newValue }
        get { return capsule.capRadius     }
    }
    
    var height: CGFloat {
        set { capsule.height = newValue }
        get { return capsule.height     }
    }
    
    override var size: CGFloat {
        set {
            radius = newValue / 4
            height = newValue
        }
        get {
            return max(radius * 2, height)
        }
    }
    
    var capsule: SCNCapsule {
        set { geometry = newValue        }
        get { return geometry as SCNCapsule }
    }
    
    override init() {
        super.init(geometry: SCNCapsule())
    }
}

