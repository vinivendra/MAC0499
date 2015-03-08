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
        let material = SCNMaterial()
            material.ambient.contents  = UIColor(red: 0.1, green: 0.1, blue: 0.3, alpha: 1.0)
            material.diffuse.contents  = UIColor(red: 0.2, green: 0.2, blue: 0.8, alpha: 1.0)
            material.specular.contents = UIColor(red: 0.8, green: 0.8, blue: 1.0, alpha: 1.0)
        
        let earth = SCNSphere()
            earth.materials = [material]
        
        var node = SCNNode(geometry: earth)
            node.position = SCNVector3Make(0, 0, -2)
        
        let scene = SCNScene()
            scene.rootNode.addChildNode(node)
        
        //
        let camera = SCNCamera()
        
            node = SCNNode()
            node.camera = camera
            node.position = SCNVector3Make(0, 0, 2)
            
            scene.rootNode.addChildNode(node)
        
        
        sceneView.scene = scene
    }

}

