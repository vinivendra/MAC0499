
import Foundation
import SceneKit


@objc protocol BoxExport: ShapeExport {
    var length:         CGFloat   {get set}
    var height:         CGFloat   {get set}
    var width:          CGFloat   {get set}
    var chamferRadius:  CGFloat   {get set}
    var size:           CGFloat   {get set}
}


@objc class Box: Shape, BoxExport {
    
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
    
    override class func template() -> JSValue {
        return self.templateWithItem(Box())
    }
    
    override class func create() -> JSValue {
        return Box.createWithItem(Box())
    }
    
    override func create() -> JSValue {
        return Box.createWithItem(self.copy() as Box)
    }
    
    override func copyWithZone(zone: NSZone) -> AnyObject {
        
        let copy = Box()
            copy.name          = name
            copy.width         = width
            copy.height        = height
            copy.length        = length
            copy.chamferRadius = chamferRadius
        
        for item in items {
            copy.items.append(item.copy() as Item)
        }
        
        return copy
    }
    
}

