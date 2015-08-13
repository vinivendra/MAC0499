

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

    func testIsApproximatelyEqual() {

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

            XCTAssert(vector1 ==~ vector2)
            XCTAssert(vector1 !=~ vector3)
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
            let point = CGPointMake(CGFloat(array[0]), CGFloat(array[1]))
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

    func testInitWithDictionary() {
        for (var i = 0; i < standardArrays.count; i++) {
            // Gold Standard
            let standard = standardVectors[i]

            // Actual Result
            let dictionary1 = ["x": standard.x, "y": standard.y, "z":standard.z];
            let dictionary2 = ["X": standard.x, "Y": standard.y, "Z":standard.z];
            let dictionary3 = ["0": standard.x, "1": standard.y, "2":standard.z];
            let result1 = Vector(dictionary:dictionary1)
            let result2 = Vector(dictionary:dictionary2)
            let result3 = Vector(dictionary:dictionary3)

            // Comparison
            XCTAssert(standard == result1)
            XCTAssert(standard == result2)
            XCTAssert(standard == result3)
        }
    }

    func testInitString() {
        for (var i = 0; i < standardArrays.count; i++) {
            // Gold Standard
            let standard = standardVectors[i]

            // Actual Result
            let format1 = "[%lf, %lf, %lf]"
            let format2 = "vn %lf %lf %lf"
            let format3 = "(%lf %lf %lf)"
            let string1 = String(format: format1, arguments: [standard.x, standard.y, standard.z])
            let string2 = String(format: format2, arguments: [standard.x, standard.y, standard.z])
            let string3 = String(format: format3, arguments: [standard.x, standard.y, standard.z])
            let result1 = Vector(string: string1)
            let result2 = Vector(string: string2)
            let result3 = Vector(string: string3)

            // Comparison
            XCTAssert(standard ==~ result1)
            XCTAssert(standard ==~ result2)
            XCTAssert(standard ==~ result3)
        }
    }

    func testInitWithVector() {
        for (var i = 0; i < standardArrays.count; i++) {
            // Gold Standard
            let standard = standardVectors[i]

            // Actual Result
            let result = Vector(vector:standard)

            // Comparison
            XCTAssert(standard == result)
        }
    }

    func testInitWithObject() {
        for (var i = 0; i < standardArrays.count; i++) {
            // Gold Standard
            let standard = standardArrays[i]
            var standards: [Vector] = []

            let point = CGPointMake(CGFloat(standard[0]), CGFloat(standard[1]))
            standards.append(Vector(point: point))

            standards.append(Vector(number: standard[0]))
            standards.append(Vector(number: standard[1]))
            standards.append(Vector(number: standard[2]))

            standards.append(Vector(array: standard))

            let dictionary1 = ["x": standard[0], "y": standard[1], "z":standard[2]];
            let dictionary2 = ["X": standard[0], "Y": standard[1], "Z":standard[2]];
            let dictionary3 = ["0": standard[0], "1": standard[1], "2":standard[2]];
            standards.append(Vector(dictionary:dictionary1))
            standards.append(Vector(dictionary:dictionary2))
            standards.append(Vector(dictionary:dictionary3))

            let format1 = "[%lf, %lf, %lf]"
            let format2 = "vn %lf %lf %lf"
            let format3 = "(%lf %lf %lf)"
            let string1 = String(format: format1, arguments: [standard[0], standard[1], standard[2]])
            let string2 = String(format: format2, arguments: [standard[0], standard[1], standard[2]])
            let string3 = String(format: format3, arguments: [standard[0], standard[1], standard[2]])
            standards.append(Vector(string: string1))
            standards.append(Vector(string: string2))
            standards.append(Vector(string: string3))

            // Actual Result

            var results: [Vector] = []

            results.append(Vector(object: point))

            results.append(Vector(object: standard[0]))
            results.append(Vector(object: standard[1]))
            results.append(Vector(object: standard[2]))

            results.append(Vector(object: standard))

            results.append(Vector(object:dictionary1))
            results.append(Vector(object:dictionary2))
            results.append(Vector(object:dictionary3))

            results.append(Vector(object: string1))
            results.append(Vector(object: string2))
            results.append(Vector(object: string3))

            // Comparison
            for (var i = 0; i < standards.count; i++) {
                XCTAssert(standards[i] ==~ results[i])
            }
        }
    }
}





