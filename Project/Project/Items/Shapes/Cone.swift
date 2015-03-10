
import Foundation
import SceneKit
import JavaScriptCore



let cone_radius: CGFloat = 1
let cone_topRadius: CGFloat = 0
let cone_height: CGFloat = 1

func default_cone() -> SCNCone {
    return SCNCone(topRadius: cone_topRadius, bottomRadius: cone_radius, height: cone_height)
}



@objc class Cone: Shape {
    
    
    var radius: CGFloat {
        set { cone.bottomRadius = newValue }
        get { return cone.bottomRadius     }
    };  var bottomRadius: CGFloat {
        set { cone.bottomRadius = newValue }
        get { return cone.bottomRadius     }
    }
    
    var topRadius: CGFloat {
        set { cone.topRadius = newValue }
        get { return cone.topRadius     }
    }
    
    var height: CGFloat {
        set { cone.height = newValue }
        get { return cone.height     }
    }
    
    override var size: CGFloat {
        set {
            let ratio = bottomRadius != 0 ?
                        topRadius / bottomRadius : 1
            
            height = newValue
            radius = newValue / 2
            topRadius = radius * ratio
        }
        get {
            return 0;
        }
    }
    
    var cone: SCNCone {
        set { geometry = newValue }
        get {
            if let optional = geometry as? SCNCone {
                return optional
            }
            else {
                geometry = default_cone()
                return geometry as SCNCone
            }
        }
    }
    
    override init() {
        super.init(geometry: default_cone())
    }
}