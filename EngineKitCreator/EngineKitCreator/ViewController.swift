

import UIKit
import EngineKit


enum ViewControllerStates {
    case Neutral
    case CreatingTemplate
    case ChoosingObject
    case ChangingProperties
    case ChoosingItem
    case ChoosingActions
    case Playing
}


protocol MenuManager {
    func dismissMenu(object: AnyObject?)
    func dismissMenuAndRespond()
}


class ViewController: UIViewController, MenuManager {

    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var actionsButton: UIButton!
    @IBOutlet weak var exportButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var itemsButton: UIButton!
    @IBOutlet weak var propertiesButton: UIButton!
    @IBOutlet weak var objectsButton: UIButton!
    @IBOutlet weak var engineKitView: SCNView!
    @IBOutlet weak var playButton: UIButton!

    var placeholderTriggerManager: TriggerActionManager?

    var editorSceneManager: EditorSceneManager?
    var templateSceneManager: TemplateEditorSceneManager?
    var playerSceneManager: PlayerSceneManager?

    var menuView: MenuView?
    var menuController: MenuController?

    var cameraX: Vector?
    var cameraY: Vector?
    var cameraZ: Vector?

    var state: ViewControllerStates? {
        willSet {
            if (state != newValue) {
                changeState(state, toState: newValue)

                if (newValue == .CreatingTemplate) {
                    nameTextField.hidden = false
                }
                else if (newValue == .Neutral) {
                    nameTextField.hidden = true
                }
            }
        }
    }

    func changeState(fromState: ViewControllerStates?, toState: ViewControllerStates?) {
        if (fromState == .Neutral || fromState == .CreatingTemplate) {
            if (toState == .ChoosingObject) {
                let objectsController = ObjectsMenuController()
                objectsController.shouldShowPlusCell = (fromState == .Neutral);
                menuController = objectsController
                menuController?.manager = self
                showMenuForButton(objectsButton)
                return
            }
            else if (toState == .ChangingProperties) {
                if let editorSceneManager = SceneManager.currentSceneManager() as? EditorSceneManager,
                    let selectedItem = editorSceneManager.selectedItem {
                        menuController = PropertiesMenuViewController(item: selectedItem)
                        menuController?.manager = self
                        showMenuForButton(propertiesButton)
                }
                return
            }
            else if (toState == .ChoosingItem) {
                let itemController = ItemsMenuViewController()
                itemController.manager = self
                menuController = itemController
                showMenuForButton(itemsButton)
                return
            }
            else if (toState == .ChoosingActions) {
                let selectedItem: Item?
                if (SceneManager.currentSceneManager() == templateSceneManager) {
                    selectedItem = templateSceneManager!.topItem
                }
                else {
                    selectedItem = editorSceneManager?.selectedItem
                }

                let triggerController = TriggerActionViewController(item: selectedItem,
                    triggerActionManager:placeholderTriggerManager)
                menuController = triggerController
                showMenuForButton(actionsButton)
                return
            }
        }
        if (fromState == .Neutral) {
            if (toState == .Playing) {
                hideUI()
                createPlayScene()
                switchToSceneManager(playerSceneManager)
                return
            }
            else if (toState == .CreatingTemplate) {
                createTemplateScene()
                switchToSceneManager(templateSceneManager)
                return
            }
        }
        else {
            if (toState == .Neutral) {
                if (fromState == .Playing) {
                    showUI()
                    switchToSceneManager(editorSceneManager)
                    return
                }
                else if (fromState == .CreatingTemplate) {
                    registerTemplate()
                    switchToSceneManager(editorSceneManager)
                    return
                }
                else {
                    hideMenu()
                    return
                }
            }
            else if (toState == .CreatingTemplate) {
                if (SceneManager.currentSceneManager() == templateSceneManager) {
                    hideMenu()
                    return
                }
                else {
                    changeState(fromState, toState: .Neutral)
                    changeState(.Neutral, toState: toState)
                }
            }
            else {
                let intermediateState: ViewControllerStates;
                if (SceneManager.currentSceneManager() == templateSceneManager) {
                    intermediateState = .CreatingTemplate
                }
                else {
                    intermediateState = .Neutral
                }
                changeState(fromState, toState: intermediateState)
                changeState(intermediateState, toState: toState)
                return
            }
        }
    }

    // MARK: - MenuManager

    func dismissMenu(object: AnyObject?) {
        if (SceneManager.currentSceneManager() == templateSceneManager) {
            state = .CreatingTemplate

            if let item = object as? Item {
                templateSceneManager?.addItem(item)
            }
        }
        else {
            state = .Neutral
        }
    }

    func dismissMenuAndRespond() {
        state = .CreatingTemplate
    }

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        editorSceneManager = EditorSceneManager(script:"editor.js")
        editorSceneManager?.runOnSceneView(self.engineKitView)
        switchToSceneManager(editorSceneManager)

        placeholderTriggerManager = PlaceholderTriggerActionManager()

        editorSceneManager?.parser.triggerActionManager = placeholderTriggerManager
        editorSceneManager?.parser.parseFile("scene.fmt")

        self.propertiesButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Disabled)

        state = .Neutral
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

        menuView = MenuView(fromView: button, inView: view, orientation: .Vertical, sizeRatio: 0.7)
        menuView?.backgroundColor = UIColor.orangeColor()

        menuController!.setupMenuView(menuView!)

        view.addSubview(menuView!)
    }

    // MARK: Scene Actions

    func createPlayScene() {
        let scene = editorSceneManager!.scene
        let parser = editorSceneManager?.parser
        let exportedFormatFileContents = parser?.writeFileForScene(scene)

        playerSceneManager = PlayerSceneManager()
        playerSceneManager?.runOnSceneView(self.engineKitView)
        playerSceneManager?.parser.parseString(exportedFormatFileContents)
        addRealActionsForItems(playerSceneManager!)
    }

    func addRealActionsForItems(playerSceneManager: PlayerSceneManager) {
        let scene = playerSceneManager.scene
        let nodes = scene.rootNode.childNodes

        let manager = playerSceneManager.javaScript.triggerActionManager

        for node in nodes {
            let item = node.item
            let oldActionCollection = item.actionCollection

            let newActionCollection = ActionCollection()
            item.actionCollection = newActionCollection

            for (key, value) in oldActionCollection.arrays {

                if let trigger = key as? String,
                    let actionsArray = value as? [MethodAction] {
                        for action in actionsArray {
                            manager.addActionNamed(action.description, forTrigger: trigger)
                        }
                }
            }
        }
    }

    func createTemplateScene() {
        templateSceneManager = TemplateEditorSceneManager(script: "editor.js")
        templateSceneManager?.runOnSceneView(self.engineKitView)
    }

    func registerTemplate() {
        Item.registerTemplate(templateSceneManager?.topItem)
    }

    func switchToSceneManager(sceneManager: SceneManager?) {
        engineKitView.scene = sceneManager?.scene
        sceneManager?.makeCurrentSceneManager()
    }

    // MARK: - IBActions

    @IBAction func doneButtonPressed(sender: AnyObject) {
        if (SceneManager.currentSceneManager() == templateSceneManager
            && state != .CreatingTemplate) {
                state = .CreatingTemplate
        }
        else {
            state = .Neutral
        }
    }

    @IBAction func playButtonPressed(sender: AnyObject) {
        if (state == .Playing) {
            state = .Neutral
        }
        else {
            state = .Playing
        }
    }

    @IBAction func actionsButtonPressed(sender: AnyObject) {
        if (state == .ChoosingActions) {
            dismissMenu(nil)
        }
        else {
            state = .ChoosingActions
        }
    }

    @IBAction func exportButtonPressed(sender: AnyObject) {
        let triggerManager = editorSceneManager?.parser.triggerActionManager

        editorSceneManager?.parser.triggerActionManager = placeholderTriggerManager
        let string = editorSceneManager?.parser.writeFileForScene(editorSceneManager!.scene)

        print(NSString(string: string!));

        editorSceneManager?.parser.triggerActionManager = triggerManager

        SceneManager.currentSceneManager().javaScript.triggerActionManager.writeToFile()
    }

    @IBAction func itemsButtonTap(sender: AnyObject) {
        if (state == .ChoosingItem) {
            dismissMenu(nil)
        }
        else {
            state = .ChoosingItem
        }
    }

    @IBAction func propertiesButtonTap(sender: AnyObject) {
        if (state == .ChangingProperties) {
            dismissMenu(nil)
        }
        else {
            state = .ChangingProperties
        }
    }

    @IBAction func objectsButtonTap(sender: UIView) {
        if (state == .ChoosingObject) {
            dismissMenu(nil)
        }
        else {
            state = .ChoosingObject
        }
    }
    
}

