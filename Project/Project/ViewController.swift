//
//  ViewController.swift
//  Project
//
//  Created by Vinicius Vendramini on 06/03/15.
//  Copyright (c) 2015 Vinicius Vendramini. All rights reserved.
//

import UIKit
import SceneKit
import JavaScriptCore


class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!

    var javaScript = JavaScript()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        javaScript.load()

        
        //
        let scene = SCNScene()
        
        let earth = Sphere()
            earth.position = Vector(0, 0, -2)
            earth.color = Color.blueColor()
            earth.size = 0.6
        scene.addItem(earth)
        
        let moon = Cone()
            moon.position = Vector(Float(earth.radius * 3), 0, 0)
            moon.color = Color.lightGrayColor()
            moon.size = earth.radius / 2
        earth.addItem(moon)
        
        //
        let camera = Camera()
        
        let node = Node()
            node.camera = camera
            node.position = Vector(0, 0, 2)
        
            scene.rootNode.addChildNode(node)
        
        sceneView.scene = scene
    }

}


