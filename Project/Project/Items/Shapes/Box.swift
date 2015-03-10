//
//  Box.swift
//  Project
//
//  Created by Vinicius Vendramini on 10/03/15.
//  Copyright (c) 2015 Vinicius Vendramini. All rights reserved.
//

import Foundation
import SceneKit

let _height : CGFloat = 1
let _length : CGFloat = 1
let _width : CGFloat = 1
let _chamferRadius : CGFloat = 0

func _box() -> SCNBox {
    return SCNBox(width: _width,
        height: _height,
        length: _length,
        chamferRadius: _chamferRadius)
}

class Box: Shape {
    
    var length: CGFloat {
        set { box.length = newValue }
        get { return box.length     }
    }
    
    var height: CGFloat {
        set { box.height = newValue }
        get { return box.height     }
    }
    
    var width: CGFloat {
        set { box.width = newValue }
        get { return box.width     }
    }
    
    var chamferRadius: CGFloat {
        set { box.chamferRadius = newValue }
        get { return box.chamferRadius     }
    }
    
    /*! Auto-created */
    var box: SCNBox {
        set { geometry = newValue       }
        get {
            if let optional = geometry as? SCNBox {
                return optional
            }
            else {
                geometry = _box()
                return geometry as SCNBox
            }
        }
    }
    
    override init() {
        super.init(geometry: _box())
    }
}