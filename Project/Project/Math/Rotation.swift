

import Foundation
import JavaScriptCore
import SceneKit


@objc protocol RotationExport: JSExport {
    var axis:   Vector {get set}
    var vector: Vector {get set}
    var x:      Float  {get set}
    var y:      Float  {get set}
    var z:      Float  {get set}
    
    var angle:  Float  {get set}
    var w:      Float  {get set}
    var a:      Float  {get set}
}

@objc class Rotation: NSObject, RotationExport {
    
    var axis: Vector
    
    var vector: Vector {
        set { axis = newValue }
        get { return axis     }
    }
    
    var x: Float {
        set { axis.x = newValue }
        get { return axis.x     }
    }
    
    var y: Float {
        set { axis.y = newValue }
        get { return axis.y     }
    }
    
    var z: Float {
        set { axis.z = newValue }
        get { return axis.z     }
    }
    
    var angle: Float
    
    var w: Float {
        set { angle = newValue }
        get { return angle     }
    }
    
    var a: Float {
        set { angle = newValue }
        get { return angle     }
    }
    
    subscript(index: Int) -> Float {
        switch index {
        case 0:
            return x
        case 1:
            return y
        case 2:
            return z
        case 3:
            return w
        default:
            assertionFailure("Error: trying to get invalid subscript: \(index).")
            return 0
        }
    }
    
    subscript(index: String) -> Any {
        switch index {
        case "axis", "Axis", "AXIS", "vector", "Vector", "VECTOR":
            return axis
        case "x", "X", "0":
            return x
        case "y", "Y", "1":
            return y
        case "z", "Z", "2":
            return z
        case "w", "W", "a", "A", "3", "angle", "Angle", "ANGLE":
            return w
            
        default:
            assertionFailure("Error: trying to get invalid subscript: \(index).")
            return 0
        }
    }
    
    override init() {
        axis = Vector()
        angle = 0
    }
    
    convenience init(_ x: Float, _ y: Float, _ z: Float, _ w: Float) {
        self.init(vector: SCNVector4Make(x, y, z, w))
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
        angle = array[3] as Float
    }
    
    init(dictionary: NSDictionary) {
        axis = Vector(dictionary: dictionary)
        angle = Float.infinity
        
        var success = false
        
        let subscripts = ["w", "W", "a", "A", "3", "angle", "Angle", "ANGLE"]
        
        for index in subscripts {
            if let value = dictionary[index] as? Float {
                angle = value
                success = true
            }
            else if let array = dictionary[index] as? NSArray {
                if let value = array[4] as? Float {
                    angle = value
                    success = true
                }
            }
        }
        
        assert(success, "Error: couldn't find angle for Rotation when initializing with dictionary: \(dictionary).")
    }
    
    
    func toVector4() -> SCNVector4 {
        return SCNVector4Make(axis.x, axis.y, axis.z, angle)
    }
}