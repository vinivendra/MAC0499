
import Foundation
import UIKit


class ViewController: UIViewController {

    @IBOutlet var sceneView: SCNView?
    @IBOutlet var controlView: UIView?
    
    override func viewDidLoad() {

        super.viewDidLoad()

        let physics = Physics.shared() // TODO: property

        let scene: SCNScene = physics.scene
        self.sceneView!.scene = scene

        var node: SCNNode

        var light = SCNLight()
            light.color = UIColor(white: 1.0, alpha: 1.0)
            node = SCNNode()
            node.light = light
            node.position = SCNVector3Make(3 ,3 ,3)
        scene.rootNode.addChildNode(node)

            light = SCNLight()
            light.color = UIColor(white: 0.7, alpha: 1.0)
            node = SCNNode()
            node.light = light
            node.position = SCNVector3Make(-3 ,-3 ,-3)
        scene.rootNode.addChildNode(node)

            light = SCNLight()
            light.color = UIColor(white: 0.4, alpha: 1.0)
            light.type = SCNLightTypeAmbient
            node = SCNNode()
            node.light = light
            node.position = SCNVector3Make(-3 ,-3 ,-3)
        scene.rootNode.addChildNode(node)

        UI.shared().view = self.controlView // TODO: Property

        let javaScript = JavaScript()
            javaScript.load()
            javaScript.update()
    }

}