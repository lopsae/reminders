
import UIKit
import PlaygroundSupport


struct CellItem {
    let reuseIdentifier = "playgroundCell"
    let cellClass = UICollectionViewCell.self

    let size: CGSize

    init(_ width: CGFloat, _ height: CGFloat) {
        size = CGSize(width: width, height: height)
    }
}

class CollectionViewController: UICollectionViewController {

    internal var sections: [[CellItem]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .orange

        sections.append([
            CellItem(100, 100),
            CellItem(100, 100),
            CellItem(100, 100),
            CellItem(100, 100),
            CellItem(100, 100),
            CellItem(100, 100),
            CellItem(100, 100)
        ])

        sections.append([
            CellItem(100, 100),
            CellItem(100, 100),
            CellItem(100, 100),
            CellItem(100, 100),
            CellItem(100, 100),
            CellItem(100, 100),
            CellItem(100, 100)
        ])

        // register all cells
        for singleSection in sections {
            for singleCell in singleSection {
                collectionView?.register(
                    singleCell.cellClass,
                    forCellWithReuseIdentifier: singleCell.reuseIdentifier
                )
            }
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection sectionIndex: Int
    ) -> Int {
        return sections[sectionIndex].count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cellItem = sections[indexPath.section][indexPath.row]

        let cellView = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellItem.reuseIdentifier,
            for: indexPath
        )
        cellView.backgroundColor = .white
        return cellView
    }

}


extension CollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellItem = sections[indexPath.section][indexPath.row]
        return cellItem.size
    }

}


let layout = UICollectionViewFlowLayout()
layout.minimumInteritemSpacing = 10
layout.minimumLineSpacing = 10
layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)

let liveView = CollectionViewController(
    collectionViewLayout: layout
)

// Default size for controllers: 375 x 668
PlaygroundPage.current.liveView = liveView

