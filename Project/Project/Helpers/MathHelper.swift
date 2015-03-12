


import Foundation
import SceneKit


let _x = Vector(1, 0, 0)
let _y = Vector(1, 0, 0)
let _z = Vector(1, 0, 0)

let _invalid = Vector(0, 0, 0)

class Axis {
    
    var vector: SCNVector3
    
    var x: Float {
        set { vector.x = newValue }
        get {return vector.x      }
    }
    var y: Float {
        set { vector.y = newValue }
        get {return vector.y      }
    }
    var z: Float {
        set { vector.z = newValue }
        get {return vector.z      }
    }
    
    
    init() {
        vector = _invalid
    }
    
    init(vector: SCNVector3) {
        self.vector = vector
    }
    
    init(vector: SCNVector4) {
        self.vector = Vector(vector.x, vector.y, vector.z)
    }
    
    init(array: NSArray) {
        var success = false
        
        self.vector = _invalid
        
        if let x = array[0] as? Float {
            if let y = array[1] as? Float {
                if let z = array[2] as? Float {
                    self.vector = Vector(x, y, z)
                    success = true
                }
            }
        }
        
        assert(success, "Error: trying to initialize an Axis using an invalid array: \(array).")
    }
    
    convenience init(dictionary: NSDictionary) {
    
        if let value:AnyObject = dictionary["axis"] {
            if let name = value as? String {
                self.init(name: name)
            }
            else if let array = value as? NSArray {
                self.init(array: array)
            }
            else {
                assertionFailure("Error: trying to initialize an Axis using an invalid dictionary: \(dictionary).")
                self.init()
            }
        }
        else {
            assertionFailure("Error: trying to initialize an Axis using an invalid dictionary: \(dictionary).")
            self.init()
        }
    }
    
    init(name: String) {
        if name == "x" {
            vector = _x
        }
        else if name == "y" {
            vector = _y
        }
        else if name == "z" {
            vector = _z
        }
        else {
            vector = _invalid
        }
    }
}



class Rotation {
    
    var axis: Axis
 
    var angle: Float
    
    
    init() {
        axis = Axis()
        angle = 0
    }
    
    convenience init(anyObject: AnyObject) {
        if let array = anyObject as? NSArray {
            self.init(array: array)
        }
        else if let dictionary = anyObject as? NSDictionary {
            self.init(dictionary: dictionary)
        }
        else {
            assertionFailure("Error: couldn't find a suitable rotation initialization method for the variable: \(anyObject).")
            self.init()
        }
    }
    
    convenience init(any: Any) {
        if let vector = any as? SCNVector4 {
            self.init(vector: vector)
        }
        else if let array = any as? NSArray {
            self.init(array: array)
        }
        else if let dictionary = any as? NSDictionary {
            self.init(dictionary: dictionary)
        }
        else {
            assertionFailure("Error: couldn't find a suitable rotation initialization method for the variable: \(any).")
            self.init()
        }
    }
    
    init(vector: SCNVector4) {
        axis = Axis(vector: vector)
        angle = vector.w
    }
    
    init(array: NSArray) {
        axis = Axis(array: array)
        angle = 0
        
        if let w = array[3] as? Float {
            angle = w
        }
        else {
            assertionFailure("Error trying to initialize Rotation using an invalid array: \(array).")
        }
    }
    
    init(dictionary: NSDictionary) {
        axis = Axis(dictionary: dictionary)
        angle = 0
        
        if let value = dictionary["angle"] as? Float {
            angle = value
        }
        else if let array = dictionary["angle"] as? NSArray {
            if let value = array[4] as? Float {
                angle = value
            }
        }
    }
    
    
    func toVector() -> SCNVector4 {
        return SCNVector4Make(axis.x, axis.y, axis.z, angle)
    }
}