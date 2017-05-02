
import UIKit


struct CellItem {
    let reuseIdentifier = "playgroundCell"
    let cellClass = CellView.self

    let size: CGSize

    init(_ width: CGFloat, _ height: CGFloat) {
        size = CGSize(width: width, height: height)
    }
}


class CellView: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.orange.withAlphaComponent(0.8)
    }

    
    convenience required init?(coder: NSCoder) {
        self.init(frame: .zero)
    }
}

