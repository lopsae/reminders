//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport


class DragAndDropView: UIView {

    private let touchesView: TouchDebugView
    private let documentView, trashView: UIImageView

    private var dragOffset: CGPoint?
    private var documentOrigin: CGPoint!

    override init(frame: CGRect) {
        touchesView = TouchDebugView()
        documentView = UIImageView()
        trashView = UIImageView()

        super.init(frame: frame)
        backgroundColor = UIColor.orange

        let iconSide: CGFloat = 100
        let documentCenter = CGPoint(x: bounds.width / 2, y: bounds.height / 4)
        let trashCenter = CGPoint(x: bounds.width / 2, y: bounds.height * 3 / 4)

        documentView.frame = CGRect(center: documentCenter, side: iconSide)
        documentView.contentMode = .scaleAspectFit
        documentView.image = UIImage(named: "file.png")
        documentOrigin = documentView.frame.origin

        trashView.frame = CGRect(center: trashCenter, side: iconSide)
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

        let touchLocation = touches.first!.location(in: self)
        if (documentView.frame.contains(touchLocation)) {
            dragOffset = documentView.frame.origin - touchLocation
        }

        super.touchesBegan(touches, with: event)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesView.touchPoints = touches.map({ $0.location(in: self) })

        if let dragOffset = dragOffset {
            let touchLocation = touches.first!.location(in: self)
            documentView.frame.origin = touchLocation + dragOffset
        }

        super.touchesMoved(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesView.touchPoints = []
        dragOffset = nil

        UIView.animate(withDuration: 0.5) {
            [weak weakSelf = self] in
            weakSelf?.documentView.frame.origin = weakSelf!.documentOrigin
        }

        super.touchesEnded(touches, with: event)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesView.touchPoints = []
        dragOffset = nil
        super.touchesCancelled(touches, with: event)
    }

}

let liveView = DragAndDropView(frame: CGRect(width: 300, height: 500))

PlaygroundPage.current.liveView = liveView
