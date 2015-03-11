
import Foundation
import SceneKit
import JavaScriptCore




@objc class Torus: Shape {
    
    var radius: CGFloat {
        set { ringRadius = newValue }
        get { return ringRadius     }
    };  var ringRadius: CGFloat {
        set {
            torus.ringRadius = newValue
        }
        get { return torus.ringRadius     }
    }
    
    var pipeRadius: CGFloat {
        set { torus.pipeRadius = newValue }
        get { return torus.pipeRadius     }
    }
    
    override var size: CGFloat {
        set {
            if newValue == 0 {
                println("Warning: Setting torus size to 0; proportions will be lost.")
            }

            if ringRadius != 0 {
                let ratio = pipeRadius / ringRadius
                
                if pipeRadius > ringRadius {
                    pipeRadius = newValue / 2
                    ringRadius = pipeRadius / ratio
                }
                else {
                    ringRadius = newValue / 2
                    pipeRadius = ringRadius * ratio
                }
            }
            else if pipeRadius != 0 {
                let ratio = ringRadius / pipeRadius
                
                if pipeRadius > ringRadius {
                    pipeRadius = newValue / 2
                    ringRadius = pipeRadius * ratio
                }
                else {
                    ringRadius = newValue / 2
                    pipeRadius = ringRadius / ratio
                }
            }
            else {
                ringRadius = newValue * (1/3)
                pipeRadius = (newValue / 2) - ringRadius
            }
        }
        get {
            return ringRadius + pipeRadius
        }
    }
    
    var torus: SCNTorus {
        set { geometry = newValue        }
        get { return geometry as SCNTorus }
    }
    
    override init() {
        super.init(geometry: SCNTorus())
    }
}

