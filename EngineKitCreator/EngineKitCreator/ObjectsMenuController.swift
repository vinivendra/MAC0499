

import UIKit


let id = "cellID"


protocol MenuController {
    func setupMenuView(menuView: MenuView)
}


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
        return 2
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        cell = collectionView.dequeueReusableCellWithReuseIdentifier(id,
            forIndexPath: indexPath)

        cell.backgroundColor = UIColor.redColor()

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

        collectionView?.registerClass(UICollectionViewCell.self,
            forCellWithReuseIdentifier: id)
        
        menuView.addSubview(collectionView!)
    }
    
}

