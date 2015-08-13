

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var objectsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

// MARK: - IBActions

    @IBAction func objectsButtonTap(sender: UIView) {

        let menuView = MenuView(fromView: objectsButton, inView: view)
        view.addSubview(menuView)
        objectsButton.backgroundColor = UIColor.greenColor()
    }

}

