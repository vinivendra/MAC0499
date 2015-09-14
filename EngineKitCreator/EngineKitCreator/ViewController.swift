

import UIKit
import EngineKit


enum ViewControllerStates {
    case Neutral
    case ChoosingObject
    case ChangingProperties
}


class ViewController: UIViewController {

    @IBOutlet weak var propertiesButton: UIButton!
    @IBOutlet weak var objectsButton: UIButton!
    @IBOutlet weak var engineKitView: SCNView!

    var menuView: MenuView?
    var menuController: MenuController?

    var state: ViewControllerStates? {
        willSet {
            setState(newValue)
        }
    }

    func setState(newValue: ViewControllerStates?) {
        if (state == .Neutral) {
            if (newValue == .ChoosingObject) {
                menuController = ObjectsMenuController()
                showMenuForButton(objectsButton)
            } else if (newValue == .ChangingProperties) {
                menuController = PropertiesMenuViewController(item: SceneManager.shared.selectedItem)
                showMenuForButton(propertiesButton)
            }
        }
        else if (state == .ChoosingObject) {
            if (newValue == .Neutral) {
                hideMenu()
            } else if (newValue == .ChangingProperties) {
                state = .Neutral
                state = .ChangingProperties
            }
        }
        else if (state == .ChangingProperties) {
            if (newValue == .Neutral) {
                hideMenu()
            } else if (newValue == .ChoosingObject) {
                hideMenu()
                state = .Neutral
                state = .ChoosingObject
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

        let gestures = Gestures.shared()
        let options = gestures.options

        gestures.sceneView = engineKitView
        gestures.gesturesView = engineKitView

        let pan = NSNumber(unsignedLong: GestureRecognizers.PanRecognizer.rawValue)
        options[pan] = NSNumber(bool: true)

        gestures.setupGestures()
    }

    // MARK: - IBActions

    @IBAction func propertiesButtonTap(sender: AnyObject) {
        if (state == .ChangingProperties) {
            state = .Neutral
        }
        else {
            state = .ChangingProperties
        }
    }

    @IBAction func objectsButtonTap(sender: UIView) {
        if (state == .ChoosingObject) {
            state = .Neutral
        }
        else {
            state = .ChoosingObject
        }
    }
    
}

