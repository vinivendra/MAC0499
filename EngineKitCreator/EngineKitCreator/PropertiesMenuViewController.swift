// TODO: Make the color of the object not be red when it's selected.

import UIKit
import EngineKit


func toRadians(degrees: CGFloat) -> Float {
    return Float(degrees) / 180.0 * Float(M_PI);
}

func toDegrees(radians: Float) -> Float {
    return radians / Float(M_PI) * 180.0;
}


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

func setItemRotationX(item: Item, newValue: CGFloat) {
    let angles = item.node.eulerAngles
    let value = toRadians(newValue)
    item.node.eulerAngles = SCNVector3Make(value, angles.y, angles.z)
}
func setItemRotationY(item: Item, newValue: CGFloat) {
    let angles = item.node.eulerAngles
    let value = toRadians(newValue)
    item.node.eulerAngles = SCNVector3Make(angles.x, value, angles.z)
}
func setItemRotationZ(item: Item, newValue: CGFloat) {
    let angles = item.node.eulerAngles
    let value = toRadians(newValue)
    item.node.eulerAngles = SCNVector3Make(angles.x, angles.y, value)
}

class PropertiesMenuViewController: UIViewController, MenuController, UITextFieldDelegate {

    var propertyActions: [UITextField: ((Item, CGFloat) -> Void)]?

    var item: Item

    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var colorNameTextField: UITextField!

    @IBOutlet weak var positionXTextField: UITextField!
    @IBOutlet weak var positionYTextField: UITextField!
    @IBOutlet weak var positionZTextField: UITextField!

    @IBOutlet weak var scaleXTextField: UITextField!
    @IBOutlet weak var scaleYTextField: UITextField!
    @IBOutlet weak var scaleZTextField: UITextField!

    @IBOutlet weak var rotationXTextField: UITextField!
    @IBOutlet weak var rotationYTextField: UITextField!
    @IBOutlet weak var rotationZTextField: UITextField!

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
            scaleZTextField : setItemScaleZ,
            rotationXTextField : setItemRotationX,
            rotationYTextField : setItemRotationY,
            rotationZTextField : setItemRotationZ]

        updateTextFieldTexts()
    }

    func updateTextFieldTexts() {
        nameTextField.text = item.name

        if let shape = item as? Shape,
            color = shape.color as? UIColor
            where color.name != nil {
                colorNameTextField.text = color.name!.capitalizedString
        }
        else {
            colorNameTextField.text = "Custom color"
        }

        let position = item.position as! Position
        positionXTextField.text = String(position.x)
        positionYTextField.text = String(position.y)
        positionZTextField.text = String(position.z)

        let scale = item.scale as! Vector
        scaleXTextField.text = String(scale.x)
        scaleYTextField.text = String(scale.y)
        scaleZTextField.text = String(scale.z)

        let rotation = item.node.eulerAngles
        rotationXTextField.text = String(toDegrees(rotation.x))
        rotationYTextField.text = String(toDegrees(rotation.y))
        rotationZTextField.text = String(toDegrees(rotation.z))
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(false)
        return true
    }

    func textFieldDidEndEditing(textField: UITextField) {
        let string = textField.text

        if (textField == nameTextField) {
            if (string != nil && string!.valid) {
                item.name = string
            }
        }
        else if (textField == colorNameTextField) {
            if (string != nil && string!.valid) {
                if let shape = item as? Shape {
                    shape.color = string
                }
            }
        }
        else {
            let number = NSNumber(string: string)

            let setProperty = propertyActions?[textField]
            setProperty!(item, CGFloat(number.doubleValue))
        }
        updateTextFieldTexts()
    }

    func setupMenuView(menuView: MenuView) {
        menuView.backgroundColor = UIColor.yellowColor()

        self.view.frame = CGRectMake(0, 0, menuView.frame.size.width, menuView.frame.size.height)
        
        menuView.addSubview(self.view)
    }
}
