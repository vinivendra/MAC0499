

import Foundation
import SceneKit

@objc protocol CreatableExport: JSExport {
    class func template() -> JSValue
    class func create() -> JSValue
    func create() -> JSValue
}

@objc protocol ItemExport: JSExport, CreatableExport {
    var name: String? {get set}
    var items: [Item] {get}
    var rotation: AnyObject {get set}
    
    func addItem(item: Item)
}

@objc class Item: NSObject, NSCopying, Printable, ItemExport {
    
    // MARK: Properties
    
    var name : String? {
        set { node.name = newValue }
        get { return node.name     }
    }
    
    var items = [Item]()
    
    let node = SCNNode()
    
    var position: SCNVector3 {
        set { node.position = newValue }
        get { return node.position     }
    }
    
    var rotation: AnyObject {
        didSet {
            var success = false
            
            var nsarray: NSArray?
            
            if let array = rotation as? NSArray {
                nsarray = array
            }
            
            if let value = rotation as? JSValue {
                if let array = value.toObjectOfClass(NSArray) as? NSArray {
                    nsarray = array
                }
            }
            
            if let array = nsarray {
                if array.count == 4 {
                    if let x = array[0] as? Float {
                        if let y = array[1] as? Float {
                            if let z = array[2] as? Float {
                                if let w = array[3] as? Float {
                                    node.rotation = SCNVector4Make(x, y, z, w)
                                    success = true
                                }
                            }
                        }
                    }
                }
            }
            
            assert(success, "Error: rotation method not implemented yet!")
        }
    }
    
    override var description: String {
        get {
            if let optional = name {
                return optional
            }
            else {
                return "unnamed"
            }
        }
    }
    
    // MARK: Lifecycle
    
    override init() {
        rotation = [1, 0, 0, 0]
        
        super.init()
    }
    
    init(geometry: SCNGeometry) {
        
        node.geometry = geometry
        rotation = [1, 0, 0, 0]
        
        super.init()
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        
        let copy = Item()
            copy.name = name
        
        for item in items {
            copy.items.append(item.copy() as Item)
        }
        
        return copy
    }
    
    class func template() -> JSValue {
        return self.templateWithItem(Item())
    }
    
    class func create() -> JSValue {
        return self.createWithItem(Item())
    }
    
    func create() -> JSValue {
        return Item.createWithItem(self.copy() as Item)
    }
    
    class func createWithItem(item: Item) -> JSValue {
        scene.addItem(item)
        
        let value = JSValue(object: item, inContext: JavaScript.sharedContext())
        
        return value
    }
    
    class func templateWithItem(item: Item) -> JSValue {
        let value = JSValue(object: item, inContext: JavaScript.sharedContext())
        
        return value
    }
    
    //MARK: Public Methods
    
    func addItem(item: Item) {
        items.append(item)
        
        node.addChildNode(item.node)
    }
}