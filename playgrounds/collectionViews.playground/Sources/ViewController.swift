
import UIKit


public class CollectionViewController: UICollectionViewController {

    internal var sections: [[CellItem]] = []
    internal var backgroundView: UIView = UIView()

    override public func viewDidLoad() {
        super.viewDidLoad()

        // Sections model
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

        // Cell registration
        for singleSection in sections {
            for singleCell in singleSection {
                collectionView?.register(
                    singleCell.cellClass,
                    forCellWithReuseIdentifier: singleCell.reuseIdentifier
                )
            }
        }

        // Background image
        backgroundView.backgroundColor = UIColor(
            patternImage: UIImage(named: "hextile.png")!
        )
        collectionView?.backgroundColor = .clear
        view.insertSubview(backgroundView, at: 0)
    }

    override public func viewWillAppear(_ animated: Bool) {
        backgroundView.frame = CGRect(
            origin: .zero,
            size: view.frame.size
        )
    }

    override public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    override public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection sectionIndex: Int
        ) -> Int {
        return sections[sectionIndex].count
    }

    override public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let cellItem = sections[indexPath.section][indexPath.row]

        let cellView = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellItem.reuseIdentifier,
            for: indexPath
        )
        cellView.backgroundColor = .orange
        return cellView
    }

    override public func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
        ) {
        //        print("Will display: \(indexPath)")
    }

    override public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        print("scroll offset: \(scrollView.contentOffset.y)")
    }

}


extension CollectionViewController: UICollectionViewDelegateFlowLayout {

    public func collectionView(
        _ collectionView: UICollectionView,
        layout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
        let cellItem = sections[indexPath.section][indexPath.row]
        return cellItem.size
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout: UICollectionViewLayout,
        insetForSectionAt sectionIndex: Int
        ) -> UIEdgeInsets {
        let baseInset: CGFloat = 10
        if sectionIndex <= sections.endIndex - 2 {
            return UIEdgeInsets(
                top: baseInset,
                left: baseInset,
                bottom: 0,
                right: baseInset
            )
        } else {
            // Last section has full insets to give space to the bottom edge
            return UIEdgeInsets(
                top: baseInset,
                left: baseInset,
                bottom: baseInset,
                right: baseInset
            )
        }
    }
    
}

