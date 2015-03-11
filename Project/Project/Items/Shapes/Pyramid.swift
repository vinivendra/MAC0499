
import Foundation
import SceneKit
import JavaScriptCore




@objc class Pyramid: Shape {
    
    
    var width: CGFloat {
        set { pyramid.width = newValue }
        get { return pyramid.width     }
    }
    
    var height: CGFloat {
        set { pyramid.height = newValue }
        get { return pyramid.height     }
    }
    
    var length: CGFloat {
        set { pyramid.length = newValue }
        get { return pyramid.length     }
    }
    
    override var size: CGFloat {
        set {
            width = newValue
            height = newValue
            length = newValue
        }
        get {
            return max(max (width, height), length)
        }
    }
    
    var pyramid: SCNPyramid {
        set { geometry = newValue        }
        get { return geometry as SCNPyramid }
    }
    
    override init() {
        super.init(geometry: SCNPyramid())
    }
}

