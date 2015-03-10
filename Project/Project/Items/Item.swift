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
    var name: String {get set}
    
    var items: [Item] {get}
    
    func create() ->JSValue
    
    func addItem(item: Item)
}

@objc class Item: NSObject, NSCopying, Printable, ItemExport, CreatableExport {
    
    // MARK: Properties
    
    var name : String {
        set {
            node.name = newValue
        }
        get {
            if let optional = node.name {
                return optional
            }
            else {
                node.name = ""
                return node.name!
            }
        }
    }
    
    var items = [Item]()
    
    let node = SCNNode()
    var position: SCNVector3 = origin {
        didSet {
            node.position = position
        }
    }
    
    override var description: String {
        get {
            return name
        }
    }
    
    // MARK: Lifecycle
    
    override init() {
        
    }
    
    init(geometry: SCNGeometry) {
        
        node.geometry = geometry
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        
        let copy = Item.allocWithZone(zone)
            copy.name = name
        
        for item in items {
            copy.items.append(item.copy() as Item)
        }
        
        return copy
    }
    
    class func create() -> JSValue {
        let newItem = Item()
        
        let value = JSValue(object: newItem, inContext: JavaScript.sharedContext())
        
        return value
    }
    
    func create() ->JSValue {
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