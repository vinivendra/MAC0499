


import Foundation
import SceneKit
import JavaScriptCore


@objc protocol PointExport: JSExport {
    var x: Float {get set}
    var y: Float {get set}
    var z: Float {get set}
}


@objc class Point: NSObject, PointExport {
    
    var point: SCNVector3
    
    var x: Float {
        set { point.x = newValue }
        get {return point.x      }
    }
    var y: Float {
        set { point.y = newValue }
        get {return point.y      }
    }
    var z: Float {
        set { point.z = newValue }
        get {return point.z      }
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
        point = _nilVector3
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
            assertionFailure("Error: couldn't find a suitable point initialization method for the variable: \(anyObject).")
            self.init()
        }
    }
    
    convenience init(any: Any) {
        if let point = any as? SCNVector3 {
            self.init(point: point)
        }
        else if let point = any as? SCNVector4 {
            self.init(point: point)
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
            assertionFailure("Error: couldn't find a suitable point initialization method for the variable: \(any).")
            self.init()
        }
    }
    
    init(_ x: Float, _ y: Float, _ z: Float) {
        self.point = SCNVector3Make(x, y, z)
    }
    
    init(point: SCNVector3) {
        self.point = point
    }
    
    init(point: SCNVector4) {
        self.point = SCNVector3Make(point.x, point.y, point.z)
    }
    
    init(array: NSArray) {
        
        let x = array[0] as Float
        let y = array[1] as Float
        let z = array[2] as Float
        self.point = SCNVector3Make(x, y, z)
    }
    
    convenience init(dictionary: NSDictionary) {
        
        let subscripts = ["point", "Point", "POINT"]
        
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
            assertionFailure("Error: trying to initialize an Point using an invalid dictionary: \(dictionary).")
            self.init()
        }
    }
    
    init(name: String) {
        if name == "x" || name == "X" {
            point = _x
        }
        else if name == "y" || name == "Y" {
            point = _y
        }
        else if name == "z" || name == "Z" {
            point = _z
        }
        else {
            assertionFailure("Error: trying to initialize an Point using an invalid name: \(name).")
            point = _nilVector3
        }
    }
    
    
    func toVector3() -> SCNVector3 {
        return SCNVector3Make(x, y, z)
    }
}




