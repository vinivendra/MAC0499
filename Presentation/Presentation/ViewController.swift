

import UIKit
import EngineKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let sceneView = SCNView()
        sceneView.frame = view.frame
        view.addSubview(sceneView)

        let sceneManager = SceneManager()
        sceneManager.runOnSceneView(sceneView)

//        let item = Box.create()
//        item.color = "blue"
//        item.scale = 2.0

        var light = Light.create()
        light.type = "ambient"

        light = Light.create()
        light.type = "omni"
        light.position = [3, 3, 3]

//        let node = item.node

//        node.rotation = SCNVector4(x: 1.0, y: 1.0, z: 0.0, w: 0.0)

//        let spin = CABasicAnimation(keyPath: "rotation.w") // only animate the angle
//        spin.toValue = 2.0*M_PI
//        spin.duration = 3
//        spin.repeatCount = HUGE // for infinity
//        node.addAnimation(spin, forKey: "spin around")

//        let jsValue = sceneManager.javaScript.context.objectForKeyedSubscript("addAnimation")
//        jsValue.callWithArguments([item, "rotation.w", 2.0 * M_PI, 3, HUGE])
//        jsValue.callWithArguments([item, "position.x", 1, 1, HUGE, true])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

