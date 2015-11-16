

import UIKit
import EngineKit


let darkBlue = UIColor(red: 0.035, green: 0.090, blue: 0.098, alpha: 1)
let lightBlue = UIColor(red: 0.843, green: 0.92, blue: 0.920, alpha: 1)


class ViewController: UIViewController {

    var backgroundIsDark: Bool?
    var sceneView: SCNView?

    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundIsDark = false;

        sceneView = SCNView()
        sceneView?.frame = view.frame
        view.addSubview(sceneView!)

        sceneView?.antialiasingMode = .Multisampling4X;

        sceneView?.backgroundColor = UIColor(red: 0.843, green: 0.92, blue: 0.92, alpha: 1)

        let sceneManager = SceneManager(script: "main.js", scene: "scene.fmt")

        sceneManager.runOnSceneView(sceneView)

        let toggleBackgroundBlock: @convention(block) Item -> Void = { _ in
            self.toggleBackground()
        }
        let block = unsafeBitCast(toggleBackgroundBlock, AnyObject.self)
        sceneManager?.javaScript.context.setObject(block, forKeyedSubscript: "toggleBackground")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func toggleBackground() {
        if (backgroundIsDark == true) {
            UIView.animateWithDuration(5, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
                self.sceneView?.backgroundColor = lightBlue
                }, completion: nil)
        }
        else {
            UIView.animateWithDuration(5, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
                self.sceneView?.backgroundColor = darkBlue
                }, completion: nil)
        }

        backgroundIsDark = !(backgroundIsDark!)
    }

}

