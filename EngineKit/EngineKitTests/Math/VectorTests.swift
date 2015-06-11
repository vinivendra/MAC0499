

import XCTest
import EngineKit
import SceneKit


let standardArrays: [[Float]] = standardArrayInit()
let standardVectors: [Vector] = standardVectorInit()


func standardArrayInit() -> [[Float]] {
    var standardArrays: [[Float]] = []
    standardArrays.append([0, 0, 0])
    standardArrays.append([1, 0, 0])
    standardArrays.append([0, -1, 0])
    standardArrays.append([0, 0, 2])

    for (var i = 0; i < 10; i++) {
        standardArrays.append([randomFloat(), randomFloat(), randomFloat()])
    }

    return standardArrays
}

func standardVectorInit() -> [Vector] {
    var standardVectors: [Vector] = []

    for (let array) in standardArrays {
        standardVectors.append(Vector(x:array[0], y: array[1], z:array[2]))
    }

    return standardVectors
}


class VectorTests: XCTestCase {

    override func setUp() {
        super.setUp()

        setupRandomSeed()
    }
    
    override func tearDown() {
        super.tearDown()
    }

//------------------------------------------------------------------------------
// MARK: - Basis
//------------------------------------------------------------------------------

    func testInitWithXYZAndEquals() {

        for (var i = 0; i < standardArrays.count; i++) {
            // Bijection
            let vectorArray = standardArrays[i]
            let nextVectorArray = standardArrays[(i+1) % standardArrays.count]

            let vector1 = Vector(x: vectorArray[0],
                                 y: vectorArray[1],
                                 z: vectorArray[2])
            let vector2 = Vector(x: vectorArray[0],
                                 y: vectorArray[1],
                                 z: vectorArray[2])
            let vector3 = Vector(x: nextVectorArray[0],
                                 y: nextVectorArray[1],
                                 z: nextVectorArray[2])

            XCTAssert(vector1 == vector2)
            XCTAssert(vector1 != vector3)
        }
    }

//------------------------------------------------------------------------------
// MARK: Getting the Vector's information
//------------------------------------------------------------------------------

    func testXYZ() {
        for (var i = 0; i < standardArrays.count; i++) {
            // Gold Standard
            let vectorArray = standardArrays[i]
            let xStandard = vectorArray[0]
            let yStandard = vectorArray[1]
            let zStandard = vectorArray[2]

            // Actual Result
            let vector = standardVectors[i]
            let xResult = vector.x
            let yResult = vector.y
            let zResult = vector.z

            // Comparison
            XCTAssertEqualWithAccuracy(xStandard, xResult,
                                       fabs(xStandard / 1000) + 0.00001)
            XCTAssertEqualWithAccuracy(yStandard, yResult,
                                       fabs(yStandard / 1000) + 0.00001)
            XCTAssertEqualWithAccuracy(zStandard, zResult,
                                       fabs(zStandard / 1000) + 0.00001)
        }
    }

    func testNotZero() {
        XCTAssertFalse(Vector(x:0, y:0, z:0).notZero());
        XCTAssert(Vector(x:1, y:0, z:0).notZero());
        XCTAssert(Vector(x:2, y:0, z:3).notZero());
        XCTAssert(Vector(x:-4, y:5, z:0).notZero());
        XCTAssert(Vector(x:1, y:-6, z:7).notZero());
        XCTAssert(Vector(x:0, y:9, z:0).notZero());
        XCTAssert(Vector(x:0, y:-2, z:4000).notZero());
        XCTAssert(Vector(x:0, y:0, z:-1000).notZero());
    }

    func testToArray() {
        for (let vector) in standardVectors {
            XCTAssertEqual(vector.x, vector.toArray()[0])
            XCTAssertEqual(vector.y, vector.toArray()[1])
            XCTAssertEqual(vector.z, vector.toArray()[2])
            XCTAssert(vector.toArray().count == 3)
        }
    }

    func testToSCNVector3() {
        for (var i = 0; i < standardArrays.count; i++) {
            // Gold Standard
            let vectorArray = standardArrays[i]

            let standard = SCNVector3Make(vectorArray[0],
                                          vectorArray[1],
                                          vectorArray[2])

            // Actual result
            let result = standardVectors[i].toSCNVector3()

            // Comparison
            XCTAssert(SCNVector3EqualToVector3(standard, result))
        }
    }

    func testToSCNVector4() {
        for (var i = 0; i < standardArrays.count; i++) {
            // Gold Standard
            let vectorArray = standardArrays[i]

            let standard = SCNVector4Make(vectorArray[0],
                                          vectorArray[1],
                                          vectorArray[2],
                                          0.0)

            // Actual result
            let result = standardVectors[i].toSCNVector4()

            // Comparison
            XCTAssert(SCNVector4EqualToVector4(standard, result))
        }
    }

//------------------------------------------------------------------------------
// MARK: - Creation
//------------------------------------------------------------------------------

    func testOrigin() {
        // Gold Standard
        let standard = Vector(x: 0, y: 0, z: 0)

        // Actual Result
        let result = Vector.origin()

        // Comparison
        XCTAssert(standard == result)
    }

    func testInitWithCGPoint() {
        for (let array) in standardArrays {
            // Gold Standard
            var point = CGPointMake(CGFloat(array[0]), CGFloat(array[1]))
            let standard = Vector(x: Float(point.x), y: Float(-point.y), z: 0)

            // Actual Result
            let result = Vector(point:point)

            // Comparison
            XCTAssert(standard == result)
        }
    }

    func testInitWithNumber() {
        for (let array) in standardArrays {
            for (let number) in array {
                // Gold Standard
                let standard = Vector(x: number, y: number, z: number)

                // Actual Result
                let result = Vector(number: number)

                // Comparison
                XCTAssert(standard == result)
            }
        }
    }

    func testInitWithArray() {
        for (var i = 0; i < standardArrays.count; i++) {
            // Gold Standard
            let standard = standardVectors[i]

            // Actual Result
            let result = Vector(array:standard.toArray())

            // Comparison
            XCTAssert(standard == result)
        }
    }

}





