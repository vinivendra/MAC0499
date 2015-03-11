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
        
        let moon = Capsule()
            moon.position = Vector(0, 0, -1)
            moon.color = Color.lightGrayColor()
            moon.size = 1
        scene.addItem(moon)
        
        moon.rotation = SCNVector4Make(0.2, 0.4, 0.3, 1.5)
        
        
        
        //
        let camera = Camera()
        
        var node = Node()
            node.camera = camera
            node.position = Vector(0, 0, 2)
        scene.rootNode.addChildNode(node)
        
        //
        var light = Light()
            light.type = SCNLightTypeOmni
            light.color = Color.lightGrayColor()
        
            node = Node()
            node.light = light
            node.position = Vector(3, 3, 3)
        scene.rootNode.addChildNode(node)
        
        //
            light = Light()
            light.type = SCNLightTypeOmni
            light.color = Color.darkGrayColor()
        
            node = Node()
            node.light = light
            node.position = Vector(-3, -3, -3)
        scene.rootNode.addChildNode(node)
        
        //
            light = Light()
            light.type = SCNLightTypeAmbient
            light.color = Color.darkGrayColor()
        
            node = Node()
            node.light = light
            node.position = Vector(0, 0, 0)
        scene.rootNode.addChildNode(node)
        
        
        sceneView.scene = scene
    }

}


