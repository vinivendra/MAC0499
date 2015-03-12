//TODO: Separate Vector from Point from Axis
//TODO: Find out if the rotation axis needs to be normalized
//TODO: Add rotation and position to copy() method
//TODO: Create tests for JS

//TODO: Find out what other properties should be added to Item

//TODO: Repeat the process used on Box to the other shapes



////////////////////////////////////////////////////////////////////////////////////////////
//TODO: rotation = [[0.2, 0.3, 0.4], 3]
//TODO: rotation = [[x:0.2, y:0.3, z:0.4], 3]

//TODO: JS: var rotation = {"AXIS": ...}
//              rotation["AXIS"] = [...]    --> Subclass NSDictionary and set a delegate to warn about changes?
//                                          --> May not be possible :/

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
            node.position = SCNVector3Make(0, 0, 5)
        scene.rootNode.addChildNode(node)
        
        //
        var light = Light()
            light.type = SCNLightTypeOmni
            light.color = Color.lightGrayColor()
        
            node = Node()
            node.light = light
            node.position = SCNVector3Make(3, 3, 3)
        scene.rootNode.addChildNode(node)
        
        //
            light = Light()
            light.type = SCNLightTypeOmni
            light.color = Color.darkGrayColor()
        
            node = Node()
            node.light = light
            node.position = SCNVector3Make(-3, -3, -3)
        scene.rootNode.addChildNode(node)
        
        //
            light = Light()
            light.type = SCNLightTypeAmbient
            light.color = Color.darkGrayColor()
        
            node = Node()
            node.light = light
            node.position = SCNVector3Make(0, 0, 0)
        scene.rootNode.addChildNode(node)
        
        
        sceneView.scene = scene
    }

}

