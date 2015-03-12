//TODO: Try implementing rotation on Item back to get-set instead of didSet
//TODO: Get rotation and position working on JS
//TODO: Add rotation and position to copy() method
//TODO: Find out what other properties should be added to Item

//TODO: Repeat the process used on Box to the other shapes

//TODO: Create tests for JS

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

