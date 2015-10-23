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

func setItemColorR(item: Item, newValue: CGFloat) {
    if let shape = item as? Shape,
        color = shape.color as? UIColor {
            var components = [CGFloat](count: 4, repeatedValue: 0.0)
            color.getRed(&components[0], green:&components[1], blue:&components[2], alpha:&components[3])
            shape.color = UIColor(red: newValue, green: components[1], blue: components[2], alpha: components[3]);
    }
}
func setItemColorG(item: Item, newValue: CGFloat) {
    if let shape = item as? Shape,
        color = shape.color as? UIColor {
            var components = [CGFloat](count: 4, repeatedValue: 0.0)
            color.getRed(&components[0], green:&components[1], blue:&components[2], alpha:&components[3])
            shape.color = UIColor(red: components[0], green: newValue, blue: components[2], alpha: components[3]);
    }
}
func setItemColorB(item: Item, newValue: CGFloat) {
    if let shape = item as? Shape,
        color = shape.color as? UIColor {
            var components = [CGFloat](count: 4, repeatedValue: 0.0)
            color.getRed(&components[0], green:&components[1], blue:&components[2], alpha:&components[3])
            shape.color = UIColor(red: components[0], green: components[1], blue: newValue, alpha: components[3]);
    }
}

class PropertiesMenuViewController: UIViewController, MenuController, UITextFieldDelegate {

    var propertyActions: [UITextField: ((Item, CGFloat) -> Void)]?

    var manager :MenuManager?

    var item: Item


    @IBOutlet weak var otherLabel1: UILabel!
    @IBOutlet weak var otherLabel2: UILabel!
    @IBOutlet weak var otherLabel3: UILabel!
    @IBOutlet weak var otherLabel4: UILabel!
    @IBOutlet weak var otherLabel5: UILabel!

    @IBOutlet weak var otherTextField1: UITextField!
    @IBOutlet weak var otherTextField2: UITextField!
    @IBOutlet weak var otherTextField3: UITextField!
    @IBOutlet weak var otherTextField4: UITextField!
    @IBOutlet weak var otherTextField5: UITextField!

    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var colorNameTextField: UITextField!

    @IBOutlet weak var physicsTypeTextField: UITextField!

    @IBOutlet weak var colorRTextField: UITextField!
    @IBOutlet weak var colorGTextField: UITextField!
    @IBOutlet weak var colorBTextField: UITextField!

    @IBOutlet weak var positionXTextField: UITextField!
    @IBOutlet weak var positionYTextField: UITextField!
    @IBOutlet weak var positionZTextField: UITextField!

    @IBOutlet weak var scaleXTextField: UITextField!
    @IBOutlet weak var scaleYTextField: UITextField!
    @IBOutlet weak var scaleZTextField: UITextField!

    @IBOutlet weak var rotationXTextField: UITextField!
    @IBOutlet weak var rotationYTextField: UITextField!
    @IBOutlet weak var rotationZTextField: UITextField!

    var otherLabels : [UILabel]?
    var otherTextFields : [UITextField]?

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
            rotationZTextField : setItemRotationZ,
            colorRTextField : setItemColorR,
            colorGTextField : setItemColorG,
            colorBTextField : setItemColorB]

        otherLabels = [otherLabel1, otherLabel2, otherLabel3, otherLabel4, otherLabel5]
        otherTextFields = [otherTextField1, otherTextField2, otherTextField3, otherTextField4, otherTextField5]

        updateTextFieldTexts()
    }

    func updateTextFieldTexts() {
        nameTextField.text = item.templateName

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

        if let shape = item as? Shape {
            if let color = shape.color as? UIColor {
                var components = [CGFloat](count: 4, repeatedValue: 0.0)
                color.getRed(&components[0], green:&components[1], blue:&components[2], alpha:&components[3])
                colorRTextField.text = String(components[0])
                colorGTextField.text = String(components[1])
                colorBTextField.text = String(components[2])
            }

            let string = shape.stringForPhysicsBody()
            physicsTypeTextField.text = string

            var i = 0
            for propertyName in shape.numericProperties() {
                let textField = otherTextFields?[i]

                if let value = shape.valueForKey(propertyName) as? NSNumber {
                    textField?.text = String(value)
                }

                i++
            }
        }
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(false)
        return true
    }

    func textFieldDidEndEditing(textField: UITextField) {
        if let string = textField.text
            where string.valid {

            if (textField == nameTextField) {
                item.templateName = string
            }
            else if (textField == colorNameTextField) {
                if let shape = item as? Shape {
                    shape.color = string
                }
            }
            else if (textField == physicsTypeTextField) {
                if let shape = item as? Shape {
                    shape.physics = string
                }
            }
            else if (otherTextFields!.contains(textField)) {
                if let shape = item as? Shape {
                    let index = otherTextFields?.indexOf(textField)
                    let properties = shape.numericProperties()
                    let propertyName = properties[index!]
                    let number = NSNumber(string: string)
                    shape.setValue(number, forKey: propertyName)
                }
            }
            else {
                let number = NSNumber(string: string)

                let setProperty = propertyActions?[textField]
                setProperty!(item, CGFloat(number.doubleValue))
            }
        }

        updateTextFieldTexts()
    }

    func setupMenuView(menuView: MenuView) {
        menuView.backgroundColor = UIColor.yellowColor()

        self.view.frame = CGRectMake(0, 0, menuView.frame.size.width, menuView.frame.size.height)

        var i = 0

        if let shape = item as? Shape {
            for propertyName in shape.numericProperties() {

                let label = otherLabels?[i]
                label?.text = propertyName
                label?.hidden = false

                i++
            }
        }

        for (; i < otherLabels?.count; i++) {
            let label = otherLabels?[i]
            label?.text = ""
            label?.hidden = true
            let textField = otherTextFields?[i]
            textField?.text = ""
            textField?.hidden = true
        }

        menuView.addSubview(self.view)
    }
}
