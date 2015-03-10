//
//  Sphere.swift
//  Project
//
//  Created by Vinicius Vendramini on 09/03/15.
//  Copyright (c) 2015 Vinicius Vendramini. All rights reserved.
//

import Foundation
import SceneKit
import JavaScriptCore



@objc class Sphere: ItemGeometry {
    
    var radius: CGFloat {
        set {
            sphere.radius = newValue
        }
        get {
            return sphere.radius
        }
    }
    
    var sphere: SCNSphere {
        set {
            geometry = newValue
        }
        get {
            return geometry as SCNSphere
        }
    }
    
    override init() {
        
        super.init(geometry: SCNSphere())
    }
    
}