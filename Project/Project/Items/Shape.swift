//
//  ItemGeometry.swift
//  Project
//
//  Created by Vinicius Vendramini on 10/03/15.
//  Copyright (c) 2015 Vinicius Vendramini. All rights reserved.
//

import Foundation
import SceneKit

@objc protocol ShapeExport : JSExport {
    var color: Color? {get set}
}

@objc class Shape: Item, ShapeExport {
    
    var color: Color? {
        set {
            let material = SCNMaterial()
                material.ambient.contents  = newValue
                material.diffuse.contents  = newValue
                material.specular.contents = newValue
            
            geometry.materials = [material]
        }
        get { return self.color }
    }
    
    var size: CGFloat {
        set { assertionFailure("(Shape): Attempted to write to 'size', a virtual property.\n") }
        get { return 0                                                                         }
    }
    
    var geometry: SCNGeometry {
        set { node.geometry = newValue }
        get { return node.geometry!    }
    }
    
    override init() { super.init() }
    
    override init(geometry: SCNGeometry) { super.init(geometry: geometry) }
}