
import Foundation
import SceneKit
import JavaScriptCore




@objc class Cone: Shape {
    
    
    var radius: CGFloat {
        set { bottomRadius = newValue }
        get { return bottomRadius     }
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
            
            if size == 0 {
                println("Warning: Setting torus size to 0; proportions will be lost.")
            }
            
            if bottomRadius != 0 {
                let ratio = topRadius / bottomRadius
                
                if topRadius > bottomRadius {
                    topRadius = newValue / 2
                    bottomRadius = topRadius / ratio
                }
                else {
                    bottomRadius = newValue / 2
                    topRadius = bottomRadius * ratio
                }
            }
            else if topRadius != 0 {
                let ratio = bottomRadius / topRadius
                
                if topRadius > bottomRadius {
                    topRadius = newValue / 2
                    bottomRadius = topRadius * ratio
                }
                else {
                    bottomRadius = newValue / 2
                    topRadius = bottomRadius / ratio
                }
            }
     
            else {
                bottomRadius = newValue / 2
                topRadius = 0
            }
            
            height = newValue
        }
        get {
            return max(max(bottomRadius * 2, topRadius * 2), height)
        }
    }
    
    var cone: SCNCone {
        set { geometry = newValue        }
        get { return geometry as SCNCone }
    }
    
    override init() {
        super.init(geometry: SCNCone())
    }
}

