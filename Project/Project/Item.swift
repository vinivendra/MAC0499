//
//  Item.swift
//  Project
//
//  Created by Vinicius Vendramini on 08/03/15.
//  Copyright (c) 2015 Vinicius Vendramini. All rights reserved.
//

import Foundation
import SceneKit

@objc protocol ItemExport : JSExport {
    var name : String {get set}
    
    var subnode1 : String {get set}
}

@objc class Item : NSObject, NSCopying, Printable, ItemExport, CreatableExport {
    
    var name = "john doe"
    
    var subnode1 : String
    
    override var description : String {
        get {
            return self.name.capitalizedString
        }
    }
    
    override init() {
        
        self.name = "joao"
        
        self.subnode1 = "joana"
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject {
        
        let copy = Item.allocWithZone(zone)
            copy.name = "\(self.name)!!"
        
        return copy
    }
    
    class func create() -> JSValue {
        let value = JSValue(object: Item(), inContext: JavaScript.sharedContext())
            value.setValue("7991103", forProperty: "id")
        
        return value
    }
}