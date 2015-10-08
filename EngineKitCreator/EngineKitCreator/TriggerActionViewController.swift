

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

    var selectedTrigger: Int?
    var selectedSecondTrigger: Int?
    var selectedThirdTrigger: Int?

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

        triggersTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: triggersID)
        triggersSecondTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: triggersSecondID)
        triggersThirdTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: triggersThirdID)
        actionsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: actionsID)
    }

    // MARK: Table View Data Source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == triggersTableView) {
            return triggers.count
        }
        else if (tableView == triggersSecondTableView) {
            if (selectedTrigger != nil) {
                let trigger = triggers[selectedTrigger!].lowercaseString
                let gestureName = Gestures.gestureForString(trigger)
                let gesturesDictionary: NSDictionary
                gesturesDictionary = Gestures.possibleStatesForGesture(gestureName)

                if let strings = gesturesDictionary.allKeys as? [String] {
                    triggersSecond = strings
                    return (triggersSecond?.count)!
                }
            }
        }
        else if (tableView == triggersThirdTableView) {
            if (selectedTrigger != nil) {
                let trigger = triggers[selectedTrigger!].lowercaseString
                let gestureName = Gestures.gestureForString(trigger)
                let touches: NSArray
                touches = Gestures.possibleTouchesForGesture(gestureName)

                if let numbers = touches as? [Int] {
                    var strings = [String]()
                    for number in numbers {
                        if (Bool(number)) {
                            strings.append(String(number))
                        }
                    }

                    triggersThird = strings
                    return (triggersThird?.count)!
                }
            }
        }
        else {
            
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

            return cell
        }
        else if (tableView == triggersThirdTableView) {
            let cell = tableView.dequeueReusableCellWithIdentifier(triggersThirdID, forIndexPath: indexPath)

            cell.textLabel?.text = triggersThird?[indexPath.row]

            return cell
        }
        else {
        }

        let cell = tableView.dequeueReusableCellWithIdentifier(triggersID, forIndexPath: indexPath)

        return cell;
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (tableView == triggersTableView) {
            selectedTrigger = indexPath.row

            triggersSecondTableView.reloadData()
            triggersThirdTableView.reloadData()
            actionsTableView.reloadData()
        }
        else if (tableView == triggersSecondTableView) {

        }
        else if (tableView == triggersThirdTableView) {

        }
        else {

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
