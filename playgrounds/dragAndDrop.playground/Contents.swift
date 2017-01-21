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

            context.setFillColor(UIColor.red.withAlphaComponent(0.2).cgColor)
            context.fill(pointRect)
//            context.fillEllipse(in: pointRect)
        }

        context.restoreGState()
    }


}

class TouchView: UIView {
    private var touchesView: TouchDebugView!
    private var touchPoints: [CGPoint] = []

    override init(frame: CGRect) {
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

        touchesView = TouchDebugView()
        touchesView.frame = bounds

        addSubview(documentView)
        addSubview(trashView)
        addSubview(touchesView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateTouchPoints(touches)
        touchesView.touchPoints = touches.map({ $0.location(in: self) })

        super.touchesBegan(touches, with: event)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateTouchPoints(touches)
        touchesView.touchPoints = touches.map({ $0.location(in: self) })

        super.touchesMoved(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateTouchPoints([])
        touchesView.touchPoints = []

        super.touchesEnded(touches, with: event)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateTouchPoints([])
        touchesView.touchPoints = []

        super.touchesCancelled(touches, with: event)
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        drawTouches(with: context)
    }

    private func updateTouchPoints(_ touches: Set<UITouch>) {
        touchPoints = []
        for touch in touches {
            touchPoints.append(touch.location(in: self))
        }
        setNeedsDisplay()
    }

    private func drawTouches(with context: CGContext) {
        context.saveGState()

        for point in touchPoints {
            context.move(to: point)

            let ellipseDiameter: CGFloat = 44
            let pointRect = CGRect(
                x: point.x - ellipseDiameter / 2,
                y: point.y - ellipseDiameter / 2,
                width: ellipseDiameter,
                height: ellipseDiameter)

            context.setFillColor(UIColor.gray.withAlphaComponent(0.2).cgColor)
            context.fillEllipse(in: pointRect)
        }
        
        context.restoreGState()
    }
}

let view = TouchView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))

PlaygroundPage.current.liveView = view
