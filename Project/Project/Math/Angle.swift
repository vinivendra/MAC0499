//
//  Angle.swift
//  Project
//
//  Created by Vinicius Vendramini on 13/03/15.
//  Copyright (c) 2015 Vinicius Vendramini. All rights reserved.
//

import Foundation


class Angle {
    
    let angle: Float
 
    var value: Float {
        get { return angle     }
    }
    
    init (radians: Float) {
        self.angle = radians
    }
    
    init (degrees: Float) {
        self.angle = degrees / 180 * Float(M_PI)
    }
    
    init(_ dictionary: NSDictionary) {
        var success = false
        angle = Float.infinity
        
        let subscripts = ["w", "W", "a", "A", "3", "angle", "Angle", "ANGLE"]
        
        for index in subscripts {
            if let value = dictionary[index] as? Float {
                angle = value
                success = true
            }
            else if let array = dictionary[index] as? NSArray {
                angle = array[4] as Float
                success = true
            }
        }
        
        assert(success, "Error: couldn't find angle for Rotation when initializing with dictionary: \(dictionary).")
    }
    
    init(_ array: NSArray) {
        angle = array[3] as Float
    }
    
    func toRadians() -> Float {
        return angle
    }
    
    func toDegrees() -> Float {
        return angle * 180 / Float(M_PI)
    }
}