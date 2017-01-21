import UIKit

public extension CGRect {
    init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(
            x: center.x - (size.width / 2),
            y: center.y - (size.height / 2)
        )
        self = CGRect(origin: origin, size:size)
    }
}
