

import UIKit
import EngineKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let sceneView = SCNView()
        sceneView.frame = view.frame
        view.addSubview(sceneView)

        sceneView.antialiasingMode = .Multisampling4X;

        sceneView.backgroundColor = UIColor(red: 0.78, green: 0.77, blue: 0.70, alpha: 1)

        let sceneManager = SceneManager(script: "main.js", scene: "scene.fmt")

        sceneManager.runOnSceneView(sceneView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

