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
        
        let moon = Cone()
            moon.position = Vector(0, 0, -1)
            moon.color = Color.lightGrayColor()
            moon.bottomRadius = 0
            moon.topRadius = 1
        scene.addItem(moon)
        
        //
        let camera = Camera()
        
        let node = Node()
            node.camera = camera
            node.position = Vector(0, 0, 2)
        
            scene.rootNode.addChildNode(node)
        
        sceneView.scene = scene
    }

}


