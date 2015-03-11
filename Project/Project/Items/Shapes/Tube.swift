
import Foundation
import SceneKit
import JavaScriptCore




@objc class Tube: Shape {
    
    var radius: CGFloat {
        set { outerRadius = newValue }
        get { return outerRadius     }
    };  var outerRadius: CGFloat {
        set { tube.outerRadius = newValue }
        get { return tube.outerRadius     }
    }
    
    var innerRadius: CGFloat {
        set { tube.innerRadius = newValue }
        get { return tube.innerRadius     }
    }
    
    var height: CGFloat {
        set { tube.height = newValue }
        get { return tube.height     }
    }
    
    override var size: CGFloat {
        set {
            if size == 0 {
                println("Warning: Setting tube size to 0; proportions will be lost.")
            }
            
            if outerRadius != 0 {
                let ratio = innerRadius / outerRadius
                
                if innerRadius > outerRadius {
                    innerRadius = newValue / 2
                    outerRadius = innerRadius / ratio
                }
                else {
                    outerRadius = newValue / 2
                    innerRadius = outerRadius * ratio
                }
            }
            else if innerRadius != 0 {
                let ratio = outerRadius / innerRadius
                
                if innerRadius > outerRadius {
                    innerRadius = newValue / 2
                    outerRadius = innerRadius * ratio
                }
                else {
                    outerRadius = newValue / 2
                    innerRadius = outerRadius / ratio
                }
            }
            else {
                outerRadius = newValue / 2
                innerRadius = outerRadius / 2
            }
        }
        get {
            return max(outerRadius * 2, height)
        }
    }
    
    var tube: SCNTube {
        set { geometry = newValue        }
        get { return geometry as SCNTube }
    }
    
    override init() {
        super.init(geometry: SCNTube())
    }
}

