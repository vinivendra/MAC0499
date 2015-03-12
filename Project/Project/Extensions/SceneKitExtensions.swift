//
//  SceneKitExtensions.swift
//  Project
//
//  Created by Vinicius Vendramini on 09/03/15.
//  Copyright (c) 2015 Vinicius Vendramini. All rights reserved.
//

import Foundation
import SceneKit



let scene = SCNScene()

extension SCNScene {
    
    func addItem(item : Item) {
        rootNode.addChildNode(item.node)
    }
    
}





