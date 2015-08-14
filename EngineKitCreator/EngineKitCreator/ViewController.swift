

import UIKit
import EngineKit


enum ViewControllerStates {
    case Neutral
    case ChoosingObject
}


class ViewController: UIViewController {

    @IBOutlet weak var objectsButton: UIButton!
    @IBOutlet weak var engineKitView: EngineKitView!

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

        menuView = MenuView(fromView: button, inView: view, orientation: .Vertical)
        menuView?.backgroundColor = UIColor.orangeColor()

        menuController!.setupMenuView(menuView!)

        view.addSubview(menuView!)
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

