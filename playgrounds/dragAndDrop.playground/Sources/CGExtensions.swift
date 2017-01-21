import UIKit

public extension CGRect {

    init(center: CGPoint, size: CGSize) {
        self = CGRect(
            x: center.x - (size.width / 2),
            y: center.y - (size.height / 2),
            width: size.width,
            height: size.height
        )
    }

    init(center: CGPoint, side: CGFloat) {
        self = CGRect(
            x: center.x - (side / 2),
            y: center.y - (side / 2),
            width: side,
            height: side
        )
    }

    init (width: CGFloat, height: CGFloat) {
        self = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: height
        )
    }
}
