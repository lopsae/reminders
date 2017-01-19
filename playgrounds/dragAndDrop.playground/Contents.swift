//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

class TouchView: UIView {
    private var touchPoints: [CGPoint] = []

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
view.backgroundColor = UIColor.orange

PlaygroundPage.current.liveView = view
