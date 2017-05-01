
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

let liveView = CollectionViewController(
    collectionViewLayout: UICollectionViewFlowLayout()
)

PlaygroundPage.current.liveView = liveView

