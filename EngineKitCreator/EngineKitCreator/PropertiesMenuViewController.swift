

import UIKit
import EngineKit


func setItemPositionX(item: Item, newValue: CGFloat) {
    item.position = Position(x: newValue, y: item.position.y, z: item.position.z)
}
func setItemPositionY(item: Item, newValue: CGFloat) {
    item.position = Position(x: item.position.x, y: newValue, z: item.position.z)
}
func setItemPositionZ(item: Item, newValue: CGFloat) {
    item.position = Position(x: item.position.x, y: item.position.y, z: newValue)
}

func setItemScaleX(item: Item, newValue: CGFloat) {
    item.scale = Vector(x: newValue, y: item.scale.y, z: item.scale.z)
}
func setItemScaleY(item: Item, newValue: CGFloat) {
    item.scale = Vector(x: item.scale.x, y: newValue, z: item.scale.z)
}
func setItemScaleZ(item: Item, newValue: CGFloat) {
    item.scale = Vector(x: item.scale.x, y: item.scale.y, z: newValue)
}

class PropertiesMenuViewController: UIViewController, MenuController, UITextFieldDelegate {

    var propertyActions: [UITextField: ((Item, CGFloat) -> Void)]?

    var item: Item

    @IBOutlet weak var positionXTextField: UITextField!
    @IBOutlet weak var positionYTextField: UITextField!
    @IBOutlet weak var positionZTextField: UITextField!

    @IBOutlet weak var scaleXTextField: UITextField!
    @IBOutlet weak var scaleYTextField: UITextField!
    @IBOutlet weak var scaleZTextField: UITextField!

    init(item: Item) {
        self.item = item
        super.init(nibName: "PropertiesMenuViewController", bundle: NSBundle.mainBundle())
    }

    required init?(coder aDecoder: NSCoder) {
        self.item = Item()
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        propertyActions = [positionXTextField : setItemPositionX,
            positionYTextField : setItemPositionY,
            positionZTextField : setItemPositionZ,
            scaleXTextField : setItemScaleX,
            scaleYTextField : setItemScaleY,
            scaleZTextField : setItemScaleZ]
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(false)
        return true
    }

    func textFieldDidEndEditing(textField: UITextField) {
        let string = textField.text

        let number = NSNumber(string: string)

        textField.text = number.stringValue

        let setProperty = propertyActions?[textField]
        setProperty!(item, CGFloat(number.doubleValue))
    }

    func setupMenuView(menuView: MenuView) {
        menuView.backgroundColor = UIColor.yellowColor()

        self.view.frame = CGRectMake(0, 0, menuView.frame.size.width, menuView.frame.size.height)
        
        menuView.addSubview(self.view)
    }
}
