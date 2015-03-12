

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
    var position: AnyObject {get set}
    
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
    
    var position: AnyObject {
        set { node.position = Vector(anyObject: newValue).toVector3() }
        get { return Vector(any: node.position)                       }
    }
    
    var rotation: AnyObject {
        set { node.rotation = Rotation(anyObject: newValue).toVector4() }
        get { return Rotation(any: node.rotation)                       }
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
        
        super.init()
    }
    
    init(geometry: SCNGeometry) {
        
        node.geometry = geometry
        
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