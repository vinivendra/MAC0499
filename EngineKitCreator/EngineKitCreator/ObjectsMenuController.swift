

import UIKit
import EngineKit


let id = "cellID"


protocol MenuController {
    func setupMenuView(menuView: MenuView)
}


func classFromType<T:NSObject>(type: T.Type) -> AnyObject! {
    return T.valueForKey("self")
}


var itemClasses : [AnyObject!] = [classFromType(Box.self),
    classFromType(Capsule.self),
    classFromType(Cone.self),
    classFromType(Cylinder.self),
    classFromType(Floor.self),
    classFromType(Plane.self),
    classFromType(Pyramid.self),
    classFromType(Sphere.self),
    classFromType(Text.self),
    classFromType(Torus.self),
    classFromType(Tube.self)]


class ObjectsMenuController: NSObject,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
MenuController {

    var collectionView: UICollectionView?

    // MARK: - UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemClasses.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: ObjectsCell
        cell = collectionView.dequeueReusableCellWithReuseIdentifier(id,
            forIndexPath: indexPath) as! ObjectsCell

        cell.backgroundColor = UIColor.redColor()

        let subclass = itemClasses[indexPath.row] as! Item.Type
        let string = NSStringFromClass(subclass)
        cell.label.text = string

        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 100)
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

//        collectionView?.registerClass(UICollectionViewCell.self,
//            forCellWithReuseIdentifier: id)
        collectionView?.registerNib(UINib(nibName: "ObjectsCell", bundle: nil), forCellWithReuseIdentifier: id)

        menuView.addSubview(collectionView!)

        print("it works!")
    }

}


