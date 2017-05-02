
import UIKit


struct CellItem {
    let reuseIdentifier = "playgroundCell"
    let cellClass = UICollectionViewCell.self

    let size: CGSize

    init(_ width: CGFloat, _ height: CGFloat) {
        size = CGSize(width: width, height: height)
    }
}

