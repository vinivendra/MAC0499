


import Foundation
import SceneKit


let _x = SCNVector3Make(1, 0, 0)
let _y = SCNVector3Make(1, 0, 0)
let _z = SCNVector3Make(1, 0, 0)

let _nil = SCNVector3Make(0, 0, 0)


func floatValue(any: AnyObject) -> Float {
    if let value = any as? NSNumber {
        return value.floatValue
    }
    else if let value = any as? NSString {
        return value.floatValue
    }
    
    assertionFailure("Error: trying to create Float from unsupported variable: \(any).")
    return 0
}


class Vector {
    
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
        vector = _nil
    }
    
    convenience init(anyObject: AnyObject) {
        if let array = anyObject as? NSArray {
            self.init(array: array)
        }
        else if let dictionary = anyObject as? NSDictionary {
            self.init(dictionary: dictionary)
        }
        else if let name = anyObject as? String {
            self.init(name: name)
        }
        else {
            assertionFailure("Error: couldn't find a suitable vector initialization method for the variable: \(anyObject).")
            self.init()
        }
    }
    
    convenience init(any: Any) {
        if let vector = any as? SCNVector3 {
            self.init(vector: vector)
        }
        else if let vector = any as? SCNVector4 {
            self.init(vector: vector)
        }
        else if let array = any as? NSArray {
            self.init(array: array)
        }
        else if let dictionary = any as? NSDictionary {
            self.init(dictionary: dictionary)
        }
        else if let name = any as? String {
            self.init(name: name)
        }
        else {
            assertionFailure("Error: couldn't find a suitable vector initialization method for the variable: \(any).")
            self.init()
        }
    }
    
    init(_ x: Float, _ y: Float, _ z: Float) {
        self.vector = SCNVector3Make(x, y, z)
    }
    
    init(vector: SCNVector3) {
        self.vector = vector
    }
    
    init(vector: SCNVector4) {
        self.vector = SCNVector3Make(vector.x, vector.y, vector.z)
    }
    
    init(array: NSArray) {
        var success = false
        
        self.vector = _nil
        
        if let x = array[0] as? Float {
            if let y = array[1] as? Float {
                if let z = array[2] as? Float {
                    self.vector = SCNVector3Make(x, y, z)
                    success = true
                }
            }
        }
        
        assert(success, "Error: trying to initialize an Vector using an invalid array: \(array).")
    }
    
    convenience init(dictionary: NSDictionary) {
    
        if let value:AnyObject = dictionary["axis"] {
            self.init(anyObject: value)
        }
        else if let value:AnyObject = dictionary["vector"] {
            self.init(anyObject: value)
        }
        else if let x:AnyObject = dictionary["x"] {
                let y:AnyObject = dictionary["y"]!
                let z:AnyObject = dictionary["z"]!
            
            self.init(floatValue(x), floatValue(y), floatValue(z))
        }
        else {
            assertionFailure("Error: trying to initialize an Vector using an invalid dictionary: \(dictionary).")
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
            vector = _nil
        }
    }
    
    func toVector3() -> SCNVector3 {
        return SCNVector3Make(x, y, z)
    }
}



class Rotation {
    
    var axis: Vector
 
    var angle: Float
    
    
    init() {
        axis = Vector()
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
        axis = Vector(vector: vector)
        angle = vector.w
    }
    
    init(array: NSArray) {
        axis = Vector(array: array)
        angle = 0
        
        if let w = array[3] as? Float {
            angle = w
        }
        else {
            assertionFailure("Error trying to initialize Rotation using an invalid array: \(array).")
        }
    }
    
    init(dictionary: NSDictionary) {
        axis = Vector(dictionary: dictionary)
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
    
    
    func toVector4() -> SCNVector4 {
        return SCNVector4Make(axis.x, axis.y, axis.z, angle)
    }
}