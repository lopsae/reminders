
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
            CellItem(100, 200),
            CellItem(100, 100),
            CellItem(100, 200),
            CellItem(100, 100),
            CellItem(100, 200),
            CellItem(100, 100),
            CellItem(100, 200)
        ])

        sections.append([
            CellItem(100, 100),
            CellItem(100, 200),
            CellItem(100, 100),
            CellItem(100, 200),
            CellItem(100, 100),
            CellItem(100, 200),
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

    func collectionView(
        _ collectionView: UICollectionView,
        layout: UICollectionViewLayout,
        insetForSectionAt sectionIndex: Int
    ) -> UIEdgeInsets {
        let baseInset: CGFloat = 10
        if sectionIndex <= sections.endIndex - 2 {
            return UIEdgeInsets(top: baseInset, left: baseInset, bottom: 0, right: baseInset)
        } else {
            // Last section has full insets to give space to the bottom edge
            return UIEdgeInsets(top: baseInset, left: baseInset, bottom: baseInset, right: baseInset)
        }
    }

}


let layout = UICollectionViewFlowLayout()
layout.minimumInteritemSpacing = 10
layout.minimumLineSpacing = 10

let liveView = CollectionViewController(
    collectionViewLayout: layout
)

// Default size for controllers: 375 x 668
PlaygroundPage.current.liveView = liveView

