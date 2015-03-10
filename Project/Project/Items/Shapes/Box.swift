
import Foundation
import SceneKit



let box_height : CGFloat = 1
let box_length : CGFloat = 1
let box_width : CGFloat = 1
let box_chamferRadius : CGFloat = 0

func default_box() -> SCNBox {
    return SCNBox(width: box_width,
                 height: box_height,
                 length: box_length,
          chamferRadius: box_chamferRadius)
}



class Box: Shape {
    
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
            box.width = newValue
            box.height = newValue
            box.length = newValue
        }
        get {
            return 0;
        }
    }
    
    var box: SCNBox {
        set { geometry = newValue       }
        get {
            if let optional = geometry as? SCNBox {
                return optional
            }
            else {
                geometry = default_box()
                return geometry as SCNBox
            }
        }
    }
    
    override init() {
        super.init(geometry: default_box())
    }
}