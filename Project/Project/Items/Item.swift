//
//  Item.swift
//  Project
//
//  Created by Vinicius Vendramini on 08/03/15.
//  Copyright (c) 2015 Vinicius Vendramini. All rights reserved.
//

import Foundation
import SceneKit



@objc protocol ItemExport: JSExport {
    var name: String? {get set}
    
    var items: [Item] {get}
    
    func create() ->JSValue
    
    func addItem(item: Item)
}

@objc class Item: NSObject, NSCopying, Printable, ItemExport, CreatableExport {
    
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
    
    var rotation: SCNVector4 {
        set { node.rotation = newValue }
        get { return node.rotation     }
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
    
    func commonInit() {
        scene.addItem(self)
    }
    
    override init() {
        super.init()
        commonInit()
    }
    
    init(geometry: SCNGeometry) {
        
        node.geometry = geometry
        
        super.init()
        commonInit()
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        
        let copy = Item.allocWithZone(zone)
            copy.commonInit()
            copy.name = name
        
        for item in items {
            copy.items.append(item.copy() as Item)
        }
        
        return copy
    }
    
    class func template() -> JSValue {
        return self.create()
    }
    
    class func create() -> JSValue {
        let newItem = Item()
        
        let value = JSValue(object: newItem, inContext: JavaScript.sharedContext())
        
        return value
    }
    
    func create() -> JSValue {
        let newItem = self.copy() as Item
        
        let value = JSValue(object: newItem, inContext: JavaScript.sharedContext())
        
        return value
    }
    
    //MARK: Public Methods
    
    func addItem(item: Item) {
        items.append(item)
        
        node.addChildNode(item.node)
    }
}