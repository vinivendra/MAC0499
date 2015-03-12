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
        let camera = Camera()
        
        var node = Node()
            node.camera = camera
            node.position = Vector(0, 0, 5)
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


