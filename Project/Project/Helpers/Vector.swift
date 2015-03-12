


import Foundation
import SceneKit
import JavaScriptCore

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


@objc protocol VectorExport: JSExport {
    var x: Float {get set}
    var y: Float {get set}
    var z: Float {get set}
}


@objc class Vector: NSObject, VectorExport {
    
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
    
    
    subscript(index: Int) -> Float {
        switch index {
        case 0:
            return x
        case 1:
            return y
        case 2:
            return z
        default:
            assertionFailure("Error: trying to get invalid subscript: \(index).")
            return 0
        }
   }
    
    subscript(index: String) -> Float {
        switch index {
        case "x", "X", "0":
            return x
        case "y", "Y", "1":
            return y
        case "z", "Z", "2":
            return z
        default:
            assertionFailure("Error: trying to get invalid subscript: \(index).")
            return 0
        }
    }
    
    
    override init() {
        vector = _nil
    }
    
    convenience init(anyObject: AnyObject) {
        if let array = anyObject as? NSArray {
            self.init(array: array)
        }
        else if let dictionary = anyObject as? NSDictionary {
            self.init(dictionary: dictionary)
        }
        else if let name = anyObject as? NSString {
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
        else if let name = any as? NSString {
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
        
        let x = array[0] as Float
        let y = array[1] as Float
        let z = array[2] as Float
        self.vector = SCNVector3Make(x, y, z)
    }
    
    convenience init(dictionary: NSDictionary) {
        
        let subscripts = ["axis", "Axis", "AXIS", "vector", "Vector", "VECTOR"]
        
        for index in subscripts {
            if let value:AnyObject = dictionary[index] {
                self.init(anyObject: value)
                return
            }
        }
        
        if let x:AnyObject = dictionary["x"] {
           let y:AnyObject = dictionary["y"]!
           let z:AnyObject = dictionary["z"]!
            
            self.init(floatValue(x), floatValue(y), floatValue(z))
        }
        else if let x:AnyObject = dictionary["X"] {
                let y:AnyObject = dictionary["Y"]!
                let z:AnyObject = dictionary["Z"]!
            
            self.init(floatValue(x), floatValue(y), floatValue(z))
        }
        else if let x:AnyObject = dictionary["0"] {
                let y:AnyObject = dictionary["1"]!
                let z:AnyObject = dictionary["2"]!
            
            self.init(floatValue(x), floatValue(y), floatValue(z))
        }
        else {
            assertionFailure("Error: trying to initialize an Vector using an invalid dictionary: \(dictionary).")
            self.init()
        }
    }
    
    init(name: String) {
        if name == "x" || name == "X" {
            vector = _x
        }
        else if name == "y" || name == "Y" {
            vector = _y
        }
        else if name == "z" || name == "Z" {
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




