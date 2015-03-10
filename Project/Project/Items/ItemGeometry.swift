//
//  ItemGeometry.swift
//  Project
//
//  Created by Vinicius Vendramini on 10/03/15.
//  Copyright (c) 2015 Vinicius Vendramini. All rights reserved.
//

import Foundation
import SceneKit

@objc protocol ItemGeometryExport : JSExport {
    var color: Color {get set}
}

@objc class ItemGeometry: Item, ItemGeometryExport {
    
    var color: Color = Color.lightGrayColor() {
        didSet {
            let material = SCNMaterial()
                material.ambient.contents  = color
                material.diffuse.contents  = color
                material.specular.contents = color
            
            geometry.materials = [material]
        }
    }
    
    var geometry: SCNGeometry {
        set {
            node.geometry = newValue
        }
        get {
            if let optional = node.geometry {
                return optional
            }
            else {
                node.geometry = SCNGeometry()
                return node.geometry!
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    override init(geometry: SCNGeometry) {
        
        super.init()
        
        self.geometry = geometry
    }
}
