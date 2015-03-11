//
//  ProjectTests.swift
//  ProjectTests
//
//  Created by Vinicius Vendramini on 06/03/15.
//  Copyright (c) 2015 Vinicius Vendramini. All rights reserved.
//

import UIKit
import XCTest
import SceneKit

class SphereTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        var sphere = Sphere()
            sphere.position = Vector(0, 0, 0)
            sphere.color = Color.lightGrayColor()
            sphere.rotation = SCNVector4Make(1, 0, 0, Float(M_PI_2))
            sphere.size = 1
            sphere.radius = 2
        
        XCTAssertNotNil(sphere, "Failed to initialize a sphere!!")
    }
    
}
