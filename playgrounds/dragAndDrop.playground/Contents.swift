//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

class TouchView: UIView {
    private var touchPoints: [CGPoint] = []

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchPoints = []
        for touch in touches {
            touchPoints.append(touch.location(in: self))
        }
        setNeedsDisplay()
        super.touchesBegan(touches, with: event)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchPoints = []
        for touch in touches {
            touchPoints.append(touch.location(in: self))
        }
        setNeedsDisplay()
        super.touchesMoved(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchPoints = []
        setNeedsDisplay()
        super.touchesEnded(touches, with: event)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchPoints = []
        setNeedsDisplay()
        super.touchesCancelled(touches, with: event)
    }

    override func draw(_ rect: CGRect) {

        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()

        for point in touchPoints {
            context.move(to: point)

            let pointRect = CGRect(
                x: point.x - 10,
                y: point.y - 10,
                width: 20,
                height: 20)

            context.setFillColor(UIColor.gray.cgColor)
            context.fillEllipse(in: pointRect)
        }

        context.restoreGState()
    }
}

let view = TouchView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
view.backgroundColor = UIColor.orange

PlaygroundPage.current.liveView = view
