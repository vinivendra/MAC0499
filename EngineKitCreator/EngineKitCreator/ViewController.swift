

import UIKit
import EngineKit


enum ViewControllerStates {
    case Neutral
    case ChoosingObject
    case ChangingProperties
}


class ViewController: UIViewController, GestureDelegate {

    @IBOutlet weak var propertiesButton: UIButton!
    @IBOutlet weak var objectsButton: UIButton!
    @IBOutlet weak var engineKitView: SCNView!

    var menuView: MenuView?
    var menuController: MenuController?

    var cameraX: Vector?
    var cameraY: Vector?
    var cameraZ: Vector?

    var previousMaterials: AnyObject?

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
                if let selectedItem = SceneManager.shared.selectedItem {
                    menuController = PropertiesMenuViewController(item: selectedItem)
                    showMenuForButton(propertiesButton)
                }
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

    // Mark: - GestureDelegate

    func callGestureCallbackForGesture(gesture: UIGestures, state: UIGestureRecognizerState, withArguments arguments: [AnyObject]!) {
        if (gesture == UIGestures.PanGesture && state == UIGestureRecognizerState.Changed) {
            handlePan(arguments)
        }
        if (gesture == UIGestures.TapGesture) {
            handleTap(arguments)
        }
    }

    // MARK: Gestures

    func handlePan(arguments: [AnyObject]!) {
        if let numberOfTouches = arguments[2] as? Int,
            translation = arguments[0] as? Vector {

                if (numberOfTouches == 1) {
                    let camera = Camera.shared()

                    cameraX = camera.rotation.rotate(Axis.x())
                    cameraY = camera.rotation.rotate(Axis.y())

                    let resized = translation.times(0.02)

                    let axis: Vector = (cameraX?.times(resized.y).plus(cameraY?.times(-resized.x)))!

                    let rot = Rotation.create([axis, resized.normSquared])
                    
                    camera.rotate(rot, around: Position.origin())
                }
        }
    }

    func handleTap(arguments: [AnyObject]!) {
        if let items = arguments[0] as? [Item]
            where items.count > 0 {
                if let item = items[0] as? Shape {
                    SceneManager.shared.selectedItem = item
                    previousMaterials = item.materials
                    item.color = "red"
                }
        }
        else {
            if let shape = SceneManager.shared.selectedItem {
                shape.materials = previousMaterials
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
        let tap = NSNumber(unsignedLong: GestureRecognizers.TapRecognizer.rawValue)
        options[tap] = NSNumber(bool: true)

        gestures.setupGestures()

        gestures.delegate = self


        let camera = Camera.shared()
        cameraX = camera.rotation.rotate(Axis.x())
        cameraY = camera.rotation.rotate(Axis.y())
        cameraZ = camera.rotation.rotate(Axis.z())
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

