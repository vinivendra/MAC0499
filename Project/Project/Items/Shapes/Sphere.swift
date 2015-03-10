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

let _radius: CGFloat = 1

func _sphere() -> SCNSphere {
    return SCNSphere(radius: _radius)
}

@objc class Sphere: Shape {
    
    var radius: CGFloat {
        set { sphere.radius = newValue }
        get { return sphere.radius     }
    }
    
    /*! Auto-created */
    var sphere: SCNSphere {
        set { geometry = newValue }
        get {
            if let optional = geometry as? SCNSphere {
                return optional
            }
            else {
                geometry = _sphere()
                return geometry as SCNSphere
            }
        }
    }
    
    override init() {
        super.init(geometry: _sphere())
    }
}