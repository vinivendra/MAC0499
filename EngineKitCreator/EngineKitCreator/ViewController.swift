

import UIKit
import EngineKit


enum ViewControllerStates {
    case Neutral
    case ChoosingObject
    case ChangingProperties
    case ChoosingItem
    case Playing
}


protocol MenuManager {
    func dismissMenu()
}


class ViewController: UIViewController, MenuManager {

    @IBOutlet weak var itemsButton: UIButton!
    @IBOutlet weak var propertiesButton: UIButton!
    @IBOutlet weak var objectsButton: UIButton!
    @IBOutlet weak var engineKitView: SCNView!
    @IBOutlet weak var playButton: UIButton!

    var editorSceneManager: EditorSceneManager?
    var playerSceneManager: PlayerSceneManager?

    var menuView: MenuView?
    var menuController: MenuController?

    var cameraX: Vector?
    var cameraY: Vector?
    var cameraZ: Vector?

    var state: ViewControllerStates? {
        willSet {
            if (state != newValue) {
                if (state == .Neutral) {            // From neutral
                    if (newValue != .Neutral) {     // To something
                        changeState(state, toState: newValue)
                    }
                }
                else {                              // From something
                    if (newValue == .Neutral) {     // To neutral
                        changeState(state, toState: newValue)
                    }
                    else {                          // To something else
                        changeState(state, toState: .Neutral)
                        changeState(.Neutral, toState: newValue)
                    }
                }
            }
        }
    }

    func changeState(fromState: ViewControllerStates?, toState: ViewControllerStates?) {
        if (fromState == .Neutral) {
            if (toState == .ChoosingObject) {
                menuController = ObjectsMenuController()
                showMenuForButton(objectsButton)
            }
            else if (toState == .ChangingProperties) {
                if let selectedItem = editorSceneManager?.selectedItem {
                    menuController = PropertiesMenuViewController(item: selectedItem)
                    showMenuForButton(propertiesButton)
                }
            }
            else if (toState == .ChoosingItem) {
                let itemController = ItemsMenuViewController()
                itemController.manager = self
                menuController = itemController
                showMenuForButton(itemsButton)
            }
            else if (toState == .Playing) {
                hideUI()
                createPlayScene()
                switchToSceneManager(playerSceneManager)
            }
        }
        else if (fromState == .Playing) {
            showUI()
            switchToSceneManager(editorSceneManager)
        }
        else {
            hideMenu()
        }
    }

    // MARK: - MenuManager

    func dismissMenu() {
        state = .Neutral
    }

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        editorSceneManager = EditorSceneManager(script:"editor.js")
        editorSceneManager?.runOnSceneView(self.engineKitView)
        switchToSceneManager(editorSceneManager)

        self.propertiesButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Disabled)

        state = .Neutral

        Parser.shared().writeFileForScene(editorSceneManager?.scene);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions

    // MARK: UI Actions

    func updatePropertiesButtonForSelectedItem(selectedItem: Item?) {
        if (selectedItem != nil) {
            propertiesButton.enabled = true
        }
        else {
            propertiesButton.enabled = false
        }
    }

    func hideUI() {
        hideMenu()
        hideButtons()
        playButton.setTitle("Edit", forState: UIControlState.Normal)
    }

    func showUI() {
        showButtons()
        playButton.setTitle("Play", forState: UIControlState.Normal)
    }

    func hideButtons() {
        objectsButton.hidden = true
        propertiesButton.hidden = true
        itemsButton.hidden = true
    }

    func showButtons() {
        objectsButton.hidden = false
        propertiesButton.hidden = false
        itemsButton.hidden = false
    }

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

    // MARK: Scene Actions

    func createPlayScene() {
        playerSceneManager = PlayerSceneManager()
        playerSceneManager?.runOnSceneView(self.engineKitView)
    }

    func switchToSceneManager(sceneManager: SceneManager?) {
        engineKitView.scene = sceneManager?.scene
        sceneManager?.makeCurrentSceneManager()
    }

    // MARK: - IBActions

    @IBAction func playButtonPressed(sender: AnyObject) {
        if (state == .Neutral) {
            state = .Playing
        }
        else {
            state = .Neutral
        }
    }

    @IBAction func itemsButtonTap(sender: AnyObject) {
        if (state == .Neutral) {
            state = .ChoosingItem
        }
        else {
            state = .Neutral
        }
    }

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

