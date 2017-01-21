//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport


class TouchView: UIView {

    private let touchesView: TouchDebugView


    override init(frame: CGRect) {
        touchesView = TouchDebugView()

        super.init(frame: frame)
        backgroundColor = UIColor.orange

        let iconSide: CGFloat = 100
        let documentCenter = CGPoint(x: bounds.width / 2, y: bounds.height / 4)
        let trashCenter = CGPoint(x: bounds.width / 2, y: bounds.height * 3 / 4)

        let documentView = UIImageView(frame: CGRect(center: documentCenter, side: iconSide))
        documentView.contentMode = .scaleAspectFit
        documentView.image = UIImage(named: "file.png")

        let trashView = UIImageView(frame: CGRect(center: trashCenter, side: iconSide))
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

let view = TouchView(frame: CGRect(width: 300, height: 500))

PlaygroundPage.current.liveView = view
