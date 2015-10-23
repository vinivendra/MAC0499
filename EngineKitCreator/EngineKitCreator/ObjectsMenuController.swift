

import UIKit
import EngineKit


private let id = "cellID"


protocol MenuController {
    func setupMenuView(menuView: MenuView)
    var manager: MenuManager? {get set}
}


class ObjectsMenuController: NSObject,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
MenuController {

    var manager :MenuManager?

    var collectionView: UICollectionView?
    var _templates: [Item]?
    var templates: [Item]? {
        get {
            if (_templates == nil) {
                _templates = [Item]()
                let dictionary = Item.templates() as NSDictionary as? [NSString : Item]

                for (_, value) in dictionary! {
                    _templates?.append(value)
                }
            }
            return _templates
        }
        set {
            _templates = newValue
        }
    }

    var shouldShowPlusCell: Bool?

    var isEditing: Bool = false
    var editButton: UIButton?

    func editButtonPressed() {
        isEditing = !isEditing

        collectionView?.reloadData()
    }

    // MARK: - UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        templates = nil

        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let templates = templates {
            if let shouldShowPlusCell = shouldShowPlusCell
                where shouldShowPlusCell{
                    return templates.count + 1
            }
            else {
                return templates.count
            }
        }
        
        return 0;
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: ObjectsCell
        cell = collectionView.dequeueReusableCellWithReuseIdentifier(id, forIndexPath: indexPath) as! ObjectsCell

        cell.backgroundColor = UIColor.redColor()

        if let templates = templates
            where indexPath.row < templates.count {
                let string = templates[indexPath.row].templateName
                cell.label.text = string

                if (isEditing) {
                    cell.backgroundColor = UIColor("cyan")
                }
                else {
                    cell.backgroundColor = UIColor("yellow")
                }
        }
        else {
            cell.label.text = "+";
        }

        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 100)
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let templates = templates
            where indexPath.row < templates.count {
                let template = templates[indexPath.row]

                let item = template.create()

                if (isEditing) {
                    manager?.dismissMenuAndRespond(item)
                }
                else {
                    manager?.dismissMenu(item)
                }
        }
        else {
            manager?.dismissMenuAndRespond(nil)
        }
    }

    // MARK: - MenuController

    func setupMenuView(menuView: MenuView) {
        menuView.backgroundColor = UIColor.yellowColor()

        let size = menuView.frame.size
        let frame = CGRectMake(0, 20, size.width, size.height - 20)
        let layout = UICollectionViewFlowLayout()

        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        collectionView = UICollectionView(frame: frame,
            collectionViewLayout: layout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = UIColor.greenColor()

        collectionView?.registerNib(UINib(nibName: "ObjectsCell", bundle: nil), forCellWithReuseIdentifier: id)
        
        menuView.addSubview(collectionView!)


        editButton = UIButton(type: .System)
        editButton?.frame = CGRectMake(0, 0, size.width, 20)
        editButton?.addTarget(self, action: "editButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        editButton?.setTitle("Edit", forState: .Normal)

        menuView.addSubview(editButton!)
    }
    
}


