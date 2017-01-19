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

class TouchView: UIView {
    private var touchPoints: [CGPoint] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.orange

        let iconSize = CGSize(width: 100, height: 100)
        let documentCenter = CGPoint(x: bounds.width / 2, y: bounds.height / 4)
        let trashCenter = CGPoint(x: bounds.width / 2, y: bounds.height * 3 / 4)

        let documentView = UIView(frame: CGRect(center: documentCenter, size: iconSize))
        documentView.backgroundColor = UIColor.lightGray

        let trashView = UIView(frame: CGRect(center: trashCenter, size: iconSize))
        trashView.backgroundColor = UIColor.darkGray

        addSubview(documentView)
        addSubview(trashView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateTouchPoints(touches)

        super.touchesBegan(touches, with: event)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateTouchPoints(touches)

        super.touchesMoved(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateTouchPoints([])

        super.touchesEnded(touches, with: event)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateTouchPoints([])

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
