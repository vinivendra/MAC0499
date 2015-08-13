

import UIKit


protocol MenuController {
    func setupMenuView(menuView: MenuView)
}


class ObjectsMenuController: NSObject,
                             UICollectionViewDelegate,
                             UICollectionViewDataSource,
                             MenuController {

    func collectionView(collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath)
                        -> UICollectionViewCell {
        return UICollectionViewCell()
    }

    func setupMenuView(menuView: MenuView) {
        menuView.backgroundColor = UIColor.yellowColor()
    }

}
