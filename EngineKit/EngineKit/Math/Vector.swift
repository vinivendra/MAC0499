

import Foundation
import SceneKit


let originVector = Vector(x:0, y:0, z:0)


public class Vector: DebugPrintable {

    let vector: SCNVector3

    public var debugDescription: String {
        get {
            return String(format: "(x = %lf, y = %lf, z = %lf)",
                          arguments: [vector.x, vector.y, vector.z])
        }
    }

    public var x: Float { get { return vector.x } }
    public var y: Float { get { return vector.y } }
    public var z: Float { get { return vector.z } }

    init() {
        vector = SCNVector3Zero
    }

//------------------------------------------------------------------------------
// MARK: - Getting the Vector's information
//------------------------------------------------------------------------------

    public func notZero() -> Bool {
        return !(x == 0 && y == 0 && z == 0)
    }

    public func toArray() -> [Float] {
        return [x, y, z]
    }

    public func toSCNVector3() -> SCNVector3 {
        return vector
    }

    public func toSCNVector4() -> SCNVector4 {
        return SCNVector4Make(x, y, z, 0)
    }

//------------------------------------------------------------------------------
// MARK: - Creating Vector objects
//------------------------------------------------------------------------------

    public static func origin() -> Vector {
        return originVector
    }

    public init(x: Float, y: Float, z: Float) {
        vector = SCNVector3Make(x, y, z)
    }

    public convenience init(point: CGPoint) {
        self.init(x:Float(point.x), y:Float(-point.y), z:0.0)
    }

    public convenience init(number: Float) {
        self.init(x: number, y: number, z: number)
    }

    public convenience init(array: [Float]) {
        var x: Float = 0.0
        var y: Float = 0.0
        var z: Float = 0.0

        if (array.count > 0) {
            x = array[0]
        }
        if (array.count > 1) {
            y = array[1]
        }
        if (array.count > 2) {
            z = array[2]
        }

        self.init(x:x, y:y, z:z)
    }

    public convenience init(dictionary: [String : Float]) {
        var x: Float = 0.0
        var y: Float = 0.0
        var z: Float = 0.0

        if let result = dictionary["x"] {
            x = result
        } else if let result = dictionary["X"] {
            x = result
        } else if let result = dictionary["0"] {
            x = result
        }

        if let result = dictionary["y"] {
            y = result
        } else if let result = dictionary["Y"] {
            y = result
        } else if let result = dictionary["1"] {
            y = result
        }

        if let result = dictionary["z"] {
            z = result
        } else if let result = dictionary["Z"] {
            z = result
        } else if let result = dictionary["2"] {
            z = result
        }

        self.init(x:x, y:y, z:z)
    }

    public convenience init(string: String) {
        let scanner = NSScanner(string: string)
        let numbers = NSCharacterSet(charactersInString: "-0123456789.")
        var array: [Float] = []

        var done = false
        var contents = 0

        while (!done && contents != 3) {
            var number: NSString? = ""

            scanner.scanUpToCharactersFromSet(numbers, intoString: nil)

            done = !(scanner.scanCharactersFromSet(numbers, intoString: &number))

            if let float = number?.floatValue {
                array.append(float)
                contents++
            }
        }

        self.init(array:array)
    }

    public convenience init(vector: Vector) {
        self.init(x:vector.x, y:vector.y, z:vector.z)
    }

    public convenience init(object: Any) {
        if let point = object as? CGPoint {
            self.init(point: point)
        }
        else if let float = object as? Float {
            self.init(number: float)
        }
        else if let array = object as? [Float] {
            self.init(array: array)
        }
        else if let dictionary = object as? [String: Float] {
            self.init(dictionary: dictionary)
        }
        else if let string = object as? String {
            self.init(string: string)
        }
        else {
            self.init(x:0, y:0, z:0)
        }
    }

//------------------------------------------------------------------------------
// MARK: - Common overrides
//------------------------------------------------------------------------------

    public func isEqual(object: Any) -> Bool {
        if let other = object as? Vector {
            return SCNVector3EqualToVector3(vector, other.vector)
        }
        return false
    }

    public func isApproximatelyEqual(object: Any) -> Bool {
        let margin: Float = 0.00001

        if let otherVector = object as? Vector {
            let other = otherVector.vector
            if (Float.abs(vector.x - other.x) > Float.abs((vector.x * margin) + margin)) {
                return false
            }
            if (Float.abs(vector.y - other.y) > Float.abs((vector.y * margin) + margin)) {
                return false
            }
            if (Float.abs(vector.z - other.z) > Float.abs((vector.z * margin) + margin)) {
                return false
            }
        }
        return true
    }
}

infix operator ==~ {associativity left precedence 130}
infix operator !=~ {associativity left precedence 130}

public func == (left: Vector, right:Vector) -> Bool {
    return left.isEqual(right)
}

public func != (left: Vector, right:Vector) -> Bool {
    return !left.isEqual(right)
}

public func ==~ (left: Vector, right:Vector) -> Bool {
    return left.isApproximatelyEqual(right)
}

public func !=~ (left: Vector, right:Vector) -> Bool {
    return !left.isApproximatelyEqual(right)
}
