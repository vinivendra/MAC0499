

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
                _templates = Item.templates().allValues as? [Item]
            }
            return _templates
        }
        set {
            _templates = newValue
        }
    }

    var shouldShowPlusCell: Bool?

    // MARK: - UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
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
        cell = collectionView.dequeueReusableCellWithReuseIdentifier(id,
            forIndexPath: indexPath) as! ObjectsCell

        cell.backgroundColor = UIColor.redColor()

        if let templates = templates
            where indexPath.row < templates.count {
                let string = templates[indexPath.row].name
                cell.label.text = string
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

                template.create()

                manager?.dismissMenu()
        }
        else {
            manager?.dismissMenuAndRespond()
        }
    }

    // MARK: - MenuController

    func setupMenuView(menuView: MenuView) {
        menuView.backgroundColor = UIColor.yellowColor()

        let size = menuView.frame.size
        let frame = CGRectMake(0, 0, size.width, size.height)
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
    }
    
}


