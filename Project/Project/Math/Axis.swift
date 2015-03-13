


import Foundation
import SceneKit
import JavaScriptCore

let _x = SCNVector3Make(1, 0, 0)
let _y = SCNVector3Make(1, 0, 0)
let _z = SCNVector3Make(1, 0, 0)


@objc protocol AxisExport: JSExport {
    var x: Float {get set}
    var y: Float {get set}
    var z: Float {get set}
}


@objc class Axis: NSObject, AxisExport {
    
    var axis: SCNVector3
    
    var x: Float {
        set { axis.x = newValue }
        get {return axis.x      }
    }
    var y: Float {
        set { axis.y = newValue }
        get {return axis.y      }
    }
    var z: Float {
        set { axis.z = newValue }
        get {return axis.z      }
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
    
    
    
    convenience init(_ anyObject: AnyObject) {
        if let array = anyObject as? NSArray {
            self.init(array)
        }
        else if let dictionary = anyObject as? NSDictionary {
            self.init(dictionary)
        }
        else if let name = anyObject as? NSString {
            self.init(name)
        }
        else {
            assertionFailure("Error: couldn't find a suitable axis initialization method for the variable: \(anyObject).")
        }
    }
    
    convenience init(_ any: Any) {
        if let axis = any as? SCNVector3 {
            self.init(axis)
        }
        else if let axis = any as? SCNVector4 {
            self.init(axis)
        }
        else if let array = any as? NSArray {
            self.init(array)
        }
        else if let dictionary = any as? NSDictionary {
            self.init(dictionary)
        }
        else if let name = any as? NSString {
            self.init(name)
        }
        else {
            assertionFailure("Error: couldn't find a suitable axis initialization method for the variable: \(any).")
        }
    }
    
    init(_ x: Float, _ y: Float, _ z: Float) {
        self.axis = SCNVector3Make(x, y, z)
    }
    
    init(_ vector: SCNVector3) {
        self.axis = vector
    }
    
    init(_ vector: SCNVector4) {
        self.axis = SCNVector3Make(vector.x, vector.y, vector.z)
    }
    
    init(_ array: NSArray) {
        
        let x = array[0] as Float
        let y = array[1] as Float
        let z = array[2] as Float
        self.axis = SCNVector3Make(x, y, z)
    }
    
    convenience init(_ dictionary: NSDictionary) {
        
        let subscripts = ["axis", "Axis", "AXIS"]
        
        for index in subscripts {
            if let value:AnyObject = dictionary[index] {
                self.init(value)
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
            assertionFailure("Error: trying to initialize an Axis using an invalid dictionary: \(dictionary).")
        }
    }
    
    init(_ name: String) {
        if name == "x" || name == "X" {
            axis = _x
        }
        else if name == "y" || name == "Y" {
            axis = _y
        }
        else if name == "z" || name == "Z" {
            axis = _z
        }
        else {
            assertionFailure("Error: trying to initialize an Axis using an invalid name: \(name).")
            axis = _nilVector3
        }
    }
    
    
    func toVector3() -> SCNVector3 {
        return SCNVector3Make(x, y, z)
    }
}




