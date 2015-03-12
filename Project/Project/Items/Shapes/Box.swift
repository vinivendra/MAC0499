
import Foundation
import SceneKit


@objc protocol BoxExport: JSExport {
    var length:        CGFloat {get set}
    var height:        CGFloat {get set}
    var width:         CGFloat {get set}
    var chamferRadius: CGFloat {get set}
    var size:          CGFloat {get set}
}


@objc class Box: Shape {
    
    var length: CGFloat {
        set { box.length = newValue }
        get { return box.length     }
    }
    
    var height: CGFloat {
        set { box.height = newValue }
        get { return box.height     }
    }
    
    var width: CGFloat {
        set { box.width = newValue }
        get { return box.width     }
    }
    
    var chamferRadius: CGFloat {
        set { box.chamferRadius = newValue }
        get { return box.chamferRadius     }
    }
 
    override var size: CGFloat {
        set {
            width = newValue
            height = newValue
            length = newValue
        }
        get {
            return max(max(width, height), length)
        }
    }
    
    var box: SCNBox {
        set { geometry = newValue       }
        get { return geometry as SCNBox }
    }
    
    
    override init() {
        super.init(geometry: SCNBox())
    }
}

