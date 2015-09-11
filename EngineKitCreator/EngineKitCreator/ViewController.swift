

import UIKit
import EngineKit


enum ViewControllerStates {
    case Neutral
    case ChoosingObject
}


class ViewController: UIViewController {

    @IBOutlet weak var objectsButton: UIButton!
    @IBOutlet weak var engineKitView: SCNView!

    var menuView: MenuView?
    var menuController: MenuController?

    var state: ViewControllerStates? {
        willSet {
            if (state == .Neutral) {
                if (newValue == .ChoosingObject) {
                    menuController = ObjectsMenuController()
                    showMenuForButton(objectsButton)
                }
            }
            else if (state == .ChoosingObject) {
                if (newValue == .Neutral) {
                    hideMenu()
                }
            }
        }
    }

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        self.engineKitView.scene = SCNScene.shared()

        sceneSetup()

        state = .Neutral
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    func hideMenu() {
        menuView?.removeFromSuperview()
    }

    func showMenuForButton(button:UIButton) {
        hideMenu()

        menuView = MenuView(fromView: button, inView: view, orientation: .Vertical, sizeRatio: 0.3)
        menuView?.backgroundColor = UIColor.orangeColor()

        menuController!.setupMenuView(menuView!)

        view.addSubview(menuView!)
    }

    func sceneSetup() {
        let scene = SCNScene.shared()

        var node = SCNNode()
        var light = SCNLight()

        light.color = UIColor(white: 1.0, alpha: 1.0)
        node.light = light
        node.position = SCNVector3Make(3, 3, 3)
        scene.rootNode.addChildNode(node)

        light = SCNLight()
        node = SCNNode()
        light.color = UIColor(white: 0.7, alpha: 1.0)
        node.light = light
        node.position = SCNVector3Make(-3, -3, -3)
        scene.rootNode.addChildNode(node)

        light = SCNLight()
        node = SCNNode()
        light.color = UIColor(white: 0.4, alpha: 1.0)
        light.type = SCNLightTypeAmbient
        node.light = light
        node.position = SCNVector3Make(-3, -3, -3)
        scene.rootNode.addChildNode(node)
    }

    // MARK: - IBActions

    @IBAction func objectsButtonTap(sender: UIView) {
        if (state == .ChoosingObject) {
            state = .Neutral
        }
        else {
            state = .ChoosingObject
        }
    }
    
}

