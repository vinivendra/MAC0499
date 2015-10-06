

import EngineKit


private let id = "id"


class ItemsMenuViewController: UIViewController,
                               UITableViewDataSource,
                               UITableViewDelegate,
                               MenuController {

    @IBOutlet weak var tableView: UITableView!

    var nodes: NSArray?

    var manager: MenuManager?

    // MARK: UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nodes!.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(id, forIndexPath: indexPath);

        let node = nodes?[indexPath.row] as! SCNNode

        let item = node.item

        cell.textLabel?.text = item.templateName

        if let editorManager = SceneManager.currentSceneManager() as? EditorSceneManager {
            let selectedItem = editorManager.selectedItem

            if (item == selectedItem) {
                tableView .selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
            }
        }

        return cell
    }

    // MARK: UITableViewDelegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let editor = SceneManager.currentSceneManager() as? EditorSceneManager {
            let node = nodes?[indexPath.row] as! SCNNode
            if (editor.selectedItem == node.item) {
                editor.selectedItem = nil
            }
            else {
                editor.selectedItem = node.item
            }
        }
        manager?.dismissMenu()
    }

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: id)

        nodes = SceneManager.currentSceneManager().scene.rootNode.childNodes
    }

    // MARK: MenuController

    func setupMenuView(menuView: MenuView) {
        menuView.backgroundColor = UIColor.yellowColor()

        self.view.frame = CGRectMake(0, 0, menuView.frame.size.width,
                                           menuView.frame.size.height)

        menuView.addSubview(self.view)
    }

}
