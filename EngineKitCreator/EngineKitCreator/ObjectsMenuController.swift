

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

        UIView.animateWithDuration(0.2, animations: { () -> Void in
            for (var i = 0; i < self.collectionView(self.collectionView!, numberOfItemsInSection: 0) - 1; i++) {
                let indexPath = NSIndexPath(forItem: i, inSection: 0)
                let cell = self.collectionView?.cellForItemAtIndexPath(indexPath) as? ObjectsCell
                if (self.isEditing) {
                    cell?.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
                    cell?.label.textColor = UIColor(white: 0.15, alpha: 1.0)
                    self.editButton?.setTitle("Done", forState: .Normal)
                }
                else {
                    cell?.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
                    cell?.label.textColor = UIColor(white: 0.7, alpha: 1.0)
                    self.editButton?.setTitle("Edit", forState: .Normal)
                }
            }
        }) { (completed) -> Void in
            collectionView?.reloadData()
        }
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

        if let templates = templates
            where indexPath.row < templates.count {
                let string = templates[indexPath.row].templateName
                cell.label.text = string

                if (isEditing) {
                    cell.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
                    cell.label.textColor = UIColor(white: 0.15, alpha: 1.0)
                }
                else {
                    cell.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
                    cell.label.textColor = UIColor(white: 0.7, alpha: 1.0)
                }
                cell.label.font = UIFont.systemFontOfSize(17)
        }
        else {
            cell.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
            cell.label.textColor = UIColor(white: 0.7, alpha: 1.0)
            cell.label.font = UIFont.systemFontOfSize(34)
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
        menuView.backgroundColor = UIColor(white: 0.2, alpha: 1.0)

        let size = menuView.frame.size
        let frame = CGRectMake(20, 40, size.width - 40, size.height - 40)
        let layout = UICollectionViewFlowLayout()

        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20

        collectionView = UICollectionView(frame: frame,
            collectionViewLayout: layout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.backgroundColor = UIColor.clearColor()

        collectionView?.registerNib(UINib(nibName: "ObjectsCell", bundle: nil), forCellWithReuseIdentifier: id)
        
        menuView.addSubview(collectionView!)


        editButton = UIButton(type: .System)
        editButton?.frame = CGRectMake(0, 0, 60, 40)
        editButton?.tintColor = UIColor.whiteColor()
        editButton?.addTarget(self, action: "editButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        editButton?.setTitle("Edit", forState: .Normal)

        menuView.addSubview(editButton!)
    }
    
}


