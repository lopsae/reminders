//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

extension CGRect {
    init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(
            x: center.x - (size.width / 2),
            y: center.y - (size.height / 2)
        )
        self = CGRect(origin: origin, size:size)
    }
}


class TouchDebugView: UIView {

    init() {
        super.init(frame: CGRect.zero)
        isUserInteractionEnabled = false
        isOpaque = false
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }

    public var touchPoints: [CGPoint] = [] {
        didSet {
            self.setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()

        for point in touchPoints {
            context.move(to: point)

            let ellipseDiameter: CGFloat = 30
            let pointRect = CGRect(
                x: point.x - ellipseDiameter / 2,
                y: point.y - ellipseDiameter / 2,
                width: ellipseDiameter,
                height: ellipseDiameter)

            context.setFillColor(UIColor.white.withAlphaComponent(0.3).cgColor)
            context.fillEllipse(in: pointRect)
        }

        context.restoreGState()
    }
}


class TouchView: UIView {
    private let touchesView: TouchDebugView

    override init(frame: CGRect) {
        touchesView = TouchDebugView()

        super.init(frame: frame)
        backgroundColor = UIColor.orange

        let iconSize = CGSize(width: 100, height: 100)
        let documentCenter = CGPoint(x: bounds.width / 2, y: bounds.height / 4)
        let trashCenter = CGPoint(x: bounds.width / 2, y: bounds.height * 3 / 4)

        let documentView = UIImageView(frame: CGRect(center: documentCenter, size: iconSize))
        documentView.contentMode = .scaleAspectFit
        documentView.image = UIImage(named: "file.png")

        let trashView = UIImageView(frame: CGRect(center: trashCenter, size: iconSize))
        trashView.contentMode = .scaleAspectFit
        trashView.image = UIImage(named: "delete.png")

        touchesView.frame = bounds

        addSubview(documentView)
        addSubview(trashView)
        addSubview(touchesView)
    }
    
    convenience required init?(coder: NSCoder) {
        self.init(frame: CGRect.zero)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesView.touchPoints = touches.map({ $0.location(in: self) })

        super.touchesBegan(touches, with: event)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesView.touchPoints = touches.map({ $0.location(in: self) })

        super.touchesMoved(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesView.touchPoints = []

        super.touchesEnded(touches, with: event)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesView.touchPoints = []

        super.touchesCancelled(touches, with: event)
    }

}

let view = TouchView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))

PlaygroundPage.current.liveView = view
