import UIKit


public class TouchDebugView: UIView {

    public var touchPoints: [CGPoint] = [] {
        didSet {
            self.setNeedsDisplay()
        }
    }


    public init() {
        super.init(frame: CGRect.zero)
        isUserInteractionEnabled = false
        isOpaque = false
    }


    convenience required public init?(coder aDecoder: NSCoder) {
        self.init()
    }


    override public func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()

        for point in touchPoints {
            context.move(to: point)

            let ellipseDiameter: CGFloat = 44
            let pointRect = CGRect(
                center: point,
                side: ellipseDiameter
            )

            context.setFillColor(UIColor.black.withAlphaComponent(0.3).cgColor)
            context.fillEllipse(in: pointRect)
        }
        
        context.restoreGState()
    }
}
