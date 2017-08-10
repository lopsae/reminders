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

label.text = "maic"
liveView.addSubview(label)

class Cosa {

	init() {
		let gesture = UITapGestureRecognizer(target: self, action: #selector(transitionText))
		liveView.addGestureRecognizer(gesture)
	}

	var touchCount = 0

	@objc
	func transitionText() {
		print("tapped")

		let names = ["ciam", "icam", "satanas", "ayende", "maic", "madre"]
		touchCount += 1
		touchCount %= names.endIndex

		if touchCount % 2 == 0 {
			let transition = CATransition()
			transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
			transition.type = kCATransitionFade
			transition.duration = 1.0
			//		liveView.layer.add(transition, forKey: names[touchCount])
			label.layer.add(transition, forKey: names[touchCount])
		}


		// TODO try with attributedText
		//		label.text = names[touchCount]
		let nameString = NSMutableAttributedString()
		nameString.append(
			NSAttributedString(
				string: names[touchCount],
				attributes: [NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 20)!,
				             NSForegroundColorAttributeName: UIColor.purple
				]
			)
		)
		if touchCount % 2 == 0 {
			label.text = names[touchCount]
		} else {
			label.attributedText = nameString
		}
		print("changed to: \(names[touchCount])")

	}
}


let cosa = Cosa()





PlaygroundPage.current.liveView = liveView
print("in finem~")

