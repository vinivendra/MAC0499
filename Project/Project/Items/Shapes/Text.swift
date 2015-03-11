
import Foundation
import SceneKit
import JavaScriptCore




@objc class Text: Shape {
    
    var string: AnyObject {
        set { text.string = newValue }
        get { return text.string     }
    }
    
    var depth: CGFloat {
        set { extrusionDepth = newValue }
        get {return extrusionDepth      }
    };  var extrusionDepth: CGFloat {
        set { text.extrusionDepth = newValue }
        get {return text.extrusionDepth      }
    }
    
    override var size: CGFloat {
        set { text.font = text.font.fontWithSize(newValue) }
        get { return text.font.pointSize                   }
    }
    
    var text: SCNText {
        set { geometry = newValue        }
        get { return geometry as SCNText }
    }
    
    override init() {
        super.init(geometry: SCNText())
    }
}

