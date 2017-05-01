
import UIKit
import PlaygroundSupport


class CollectionViewController: UICollectionViewController {

    private let reuseIdentifier = "playgroundCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .orange
        collectionView?.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: reuseIdentifier
        )
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 10
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        )
        cell.backgroundColor = .white
        return cell
    }

}


extension CollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 100, height: 100)
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

