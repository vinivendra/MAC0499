

import Foundation
import SceneKit


let originVector = Vector(x:0, y:0, z:0)


public class Vector {

    let vector: SCNVector3

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

//------------------------------------------------------------------------------
// MARK: - Comparing objects
//------------------------------------------------------------------------------

    public func isEqual(object: Any) -> Bool {
        if let other = object as? Vector {
            return SCNVector3EqualToVector3(vector, other.vector)
        }
        return false
    }


}

public func == (left: Vector, right:Vector) -> Bool {
    return left.isEqual(right)
}

public func != (left: Vector, right:Vector) -> Bool {
    return !left.isEqual(right)
}
