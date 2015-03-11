
import Foundation
import SceneKit
import JavaScriptCore




@objc class Floor: Shape {
    
    var floor: SCNFloor {
        set { geometry = newValue        }
        get { return geometry as SCNFloor }
    }
    
    override var size: CGFloat {
        set {                                }
        get { return CGFloat(Float.infinity) }
    }
    
    override init() {
        super.init(geometry: SCNFloor())
    }
}

