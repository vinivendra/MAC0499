

import EngineKit


private let triggersID = "triggers"
private let triggersSecondID = "triggers"
private let triggersThirdID = "triggers"
private let actionsID = "actions"

class TriggerActionViewController: UIViewController,
    UITableViewDataSource,
    UITableViewDelegate,
MenuController {

    @IBOutlet weak var triggersTableView: UITableView!
    @IBOutlet weak var triggersSecondTableView: UITableView!
    @IBOutlet weak var triggersThirdTableView: UITableView!
    @IBOutlet weak var actionsTableView: UITableView!

    var manager: MenuManager?

    let triggers = [
        "Swipe", "Tap", "Pan", "Pinch", "Rotate", "Long Press"
    ]
    var triggersSecond: [String]?
    var triggersThird: [String]?
    var actions: [String]?

    var selectedTrigger: Int?
    var selectedSecondTrigger: Int?
    var selectedThirdTrigger: Int?

    var triggerActionManager: TriggerActionManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        triggersTableView.delegate = self
        triggersTableView.dataSource = self

        triggersSecondTableView.delegate = self
        triggersSecondTableView.dataSource = self

        triggersThirdTableView.delegate = self
        triggersThirdTableView.dataSource = self

        actionsTableView.delegate = self
        actionsTableView.dataSource = self
        actionsTableView.allowsMultipleSelection = true

        triggersTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: triggersID)
        triggersSecondTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: triggersSecondID)
        triggersThirdTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: triggersThirdID)
        actionsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: actionsID)
    }

    // MARK: Table View Data Source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func indexOfTouch(touch: Int, inArray array: [String]?) -> Int {
        for var i = 0; i < array?.count; i++ {
            let int = Int((array?[i])!)
            if (touch == int) {
                return i
            }
        }

        return NSNotFound
    }

    func indexOfActionNamed(name: String) -> Int {
        let gesture = Gestures.gestureForString(triggers[selectedTrigger!].lowercaseString)
        let state = Gestures.stateForString(triggersSecond?[selectedSecondTrigger!].lowercaseString, gesture:gesture)
        let touches = Int((triggersThird?[selectedThirdTrigger!])!)!
        let array = triggerActionManager!.actionsForGesture(gesture, state: state, touches: touches)

        for var i = 0; i < array?.count; i++ {
            if let action = array?[i] as? PlaceholderAction {
                let string = action.description

                if (string == name) {
                    return i;
                }
            }
        }

        return NSNotFound
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == triggersTableView) {
            return triggers.count
        }
        else if (tableView == triggersSecondTableView) {
            if (selectedTrigger != nil) {
                let trigger = triggers[selectedTrigger!].lowercaseString
                let gesture = Gestures.gestureForString(trigger)
                let gesturesDictionary: NSDictionary
                gesturesDictionary = Gestures.possibleStatesForGesture(gesture)

                if let strings = gesturesDictionary.allKeys as? [String] {
                    triggersSecond = strings

                    let state = Gestures.defaultStateForGesture(gesture)
                    let stateName = Gestures.stringForState(state, gesture: gesture)

                    var index = triggersSecond?.indexOf(stateName)
                    if (index == nil) {
                        index = triggersSecond?.indexOf("recognized")
                    }
                    selectedSecondTrigger = index

                    return (triggersSecond?.count)!
                }
            }
        }
        else if (tableView == triggersThirdTableView) {
            if (selectedTrigger != nil) {
                let trigger = triggers[selectedTrigger!].lowercaseString
                let gesture = Gestures.gestureForString(trigger)
                let touches: NSArray
                touches = Gestures.possibleTouchesForGesture(gesture)

                if let numbers = touches as? [Int] {
                    var strings = [String]()
                    for number in numbers {
                        if (Bool(number)) {
                            strings.append(String(number))
                        }
                    }

                    triggersThird = strings

                    selectedThirdTrigger = Gestures.defaultNumberOfTouchesForGesture(gesture)
                    selectedThirdTrigger = indexOfTouch(selectedThirdTrigger!, inArray: triggersThird)

                    return (triggersThird?.count)!
                }
            }
        }
        else {
            if (selectedTrigger != nil) {
                let array = TriggerActionManager.registeredActions()

                let strings = array.map({ (object: AnyObject) -> AnyObject! in
                    if let function = object as? JSValue {
                        return function.functionName
                    }
                    return ""
                })

                actions = (strings as? [NSString]) as? [String]
                return strings.count

            }
        }

        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if (tableView == triggersTableView) {
            let cell = tableView.dequeueReusableCellWithIdentifier(triggersID, forIndexPath: indexPath)

            cell.textLabel?.text = triggers[indexPath.row]

            return cell
        }
        else if (tableView == triggersSecondTableView) {
            let cell = tableView.dequeueReusableCellWithIdentifier(triggersSecondID, forIndexPath: indexPath)

            cell.textLabel?.text = triggersSecond?[indexPath.row].capitalizedString

            if (indexPath.row == selectedSecondTrigger) {
                tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)
            }
            else {
                tableView.deselectRowAtIndexPath(indexPath, animated: false)
            }

            return cell
        }
        else if (tableView == triggersThirdTableView) {
            let cell = tableView.dequeueReusableCellWithIdentifier(triggersThirdID, forIndexPath: indexPath)

            cell.textLabel?.text = triggersThird?[indexPath.row]

            if (indexPath.row == selectedThirdTrigger) {
                tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)
            }
            else {
                tableView.deselectRowAtIndexPath(indexPath, animated: false)
            }

            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier(actionsID, forIndexPath: indexPath)

            let name = actions?[indexPath.row]
            cell.textLabel?.text = name

            if (indexOfActionNamed(name!) != NSNotFound) {
                tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)
            }
            else {
                tableView.deselectRowAtIndexPath(indexPath, animated: false)
            }

            return cell
        }
    }

    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if (tableView == actionsTableView) {
            let index = self.indexOfActionNamed((actions?[indexPath.row])!)
            if (index != NSNotFound) {
                let gesture = Gestures.gestureForString(triggers[selectedTrigger!].lowercaseString)
                let state = Gestures.stateForString(triggersSecond?[selectedSecondTrigger!].lowercaseString, gesture:gesture)
                let touches = Int((triggersThird?[selectedThirdTrigger!])!)!
                let array = triggerActionManager!.actionsForGesture(gesture, state: state, touches: touches)

                array?.removeObjectAtIndex(index)

                actionsTableView.reloadData()
            }
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (tableView == triggersTableView) {
            selectedTrigger = indexPath.row

            triggersSecondTableView.reloadData()
            triggersThirdTableView.reloadData()
            actionsTableView.reloadData()
        }
        else if (tableView == triggersSecondTableView) {
            selectedSecondTrigger = indexPath.row
            triggersThirdTableView.reloadData()
            actionsTableView.reloadData()
        }
        else if (tableView == triggersThirdTableView) {
            selectedThirdTrigger = indexPath.row
            actionsTableView.reloadData()
        }
        else {
            print(tableView.cellForRowAtIndexPath(indexPath)?.selected)

            let index = self.indexOfActionNamed((actions?[indexPath.row])!)
            if (index == NSNotFound) {
                let gesture = Gestures.gestureForString(triggers[selectedTrigger!].lowercaseString)
                let state = Gestures.stateForString(triggersSecond?[selectedSecondTrigger!].lowercaseString, gesture:gesture)
                let touches = Int32((triggersThird?[selectedThirdTrigger!])!)!

                let action = PlaceholderAction(target: nil, methodName: actions?[indexPath.row]);

                let trigger = triggerActionManager?.triggerForGesture(gesture, state: state, touches: touches)
                triggerActionManager?.addMethodAction(action, forTrigger: trigger)
                actionsTableView.reloadData()
            }
        }
    }
    
    // MARK: Menu Controller
    func setupMenuView(menuView: MenuView) {
        menuView.backgroundColor = UIColor.yellowColor()
        
        self.view.frame = CGRectMake(0, 0, menuView.frame.size.width,
            menuView.frame.size.height)
        
        menuView.addSubview(self.view)
    }
    
}
