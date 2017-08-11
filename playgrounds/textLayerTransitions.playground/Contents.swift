//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport


let liveView = UIView(frame: CGRect(
	x: 0,
	y: 0,
	width: 400,
	height: 400
))
liveView.backgroundColor = .orange

let label = UILabel(frame: CGRect(
	x: 50,
	y: 50,
	width: 300, height: 100
))

label.text = "touch to transition text"
liveView.addSubview(label)

var touchCount = 0

class SelTarget {

	@objc
	func action() {
		let names = ["ciam", "icam", "satanas", "ayende", "maic", "madre"]
		touchCount += 1
		touchCount %= names.endIndex

		if touchCount % 2 == 0 {
			let transition = CATransition()
			transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
			transition.type = kCATransitionFade
			transition.duration = 1.0
			// Even with different names, a new transition will replace the previous
			label.layer.add(transition, forKey: names[touchCount])
		}

		if touchCount % 2 == 0 {
			label.text = names[touchCount]
		} else {
			let nameString = NSMutableAttributedString()
			nameString.append(
				NSAttributedString(
					string: names[touchCount],
					attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 20)!,
					             NSForegroundColorAttributeName: UIColor.purple
					]
				)
			)
			label.attributedText = nameString
		}

		print("changed to: \(names[touchCount])")
	}

}

let target = SelTarget()
let gesture = UITapGestureRecognizer(target: target, action: #selector(SelTarget.action))
liveView.addGestureRecognizer(gesture)


PlaygroundPage.current.liveView = liveView
print("in finem~")

