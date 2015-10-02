

import UIKit
import EngineKit


private let id = "cellID"


protocol MenuController {
    func setupMenuView(menuView: MenuView)
}


var itemClasses : [Item] = [Box.template(),
    Capsule.template(),
    Cone.template(),
    Cylinder.template(),
    Floor.template(),
    Plane.template(),
    Pyramid.template(),
    Sphere.template(),
    Text.template(),
    Torus.template(),
    Tube.template()]


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

        let template = itemClasses[indexPath.row]
        let string = template.name
        cell.label.text = string

        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 100)
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let template = itemClasses[indexPath.row]

        template.create()
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


