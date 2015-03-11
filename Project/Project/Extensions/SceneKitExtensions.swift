//
//  SceneKitExtensions.swift
//  Project
//
//  Created by Vinicius Vendramini on 09/03/15.
//  Copyright (c) 2015 Vinicius Vendramini. All rights reserved.
//

import Foundation
import SceneKit


let origin = Vector(0, 0, 0)

func Vector(x : Float, y : Float, z : Float) -> SCNVector3 {
    return SCNVector3Make(x, y, z)
}




extension SCNScene {
    
    func addItem(item : Item) {
        rootNode.addChildNode(item.node)
    }
    
}





