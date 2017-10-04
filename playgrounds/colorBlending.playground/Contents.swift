//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport


extension UIColor {
	// https://stackoverflow.com/questions/15757872/manually-color-fading-from-one-uicolor-to-another
	func transition(to toColor:UIColor, progress:CGFloat) -> UIColor {

		var percentage = progress < 0 ?  0 : progress
		percentage = percentage > 1 ?  1 : percentage

		var fRed:CGFloat = 0
		var fBlue:CGFloat = 0
		var fGreen:CGFloat = 0
		var fAlpha:CGFloat = 0

		var tRed:CGFloat = 0
		var tBlue:CGFloat = 0
		var tGreen:CGFloat = 0
		var tAlpha:CGFloat = 0

		self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha)
		toColor.getRed(&tRed, green: &tGreen, blue: &tBlue, alpha: &tAlpha)

		let red:CGFloat = (percentage * (tRed - fRed)) + fRed;
		let green:CGFloat = (percentage * (tGreen - fGreen)) + fGreen;
		let blue:CGFloat = (percentage * (tBlue - fBlue)) + fBlue;
		let alpha:CGFloat = (percentage * (tAlpha - fAlpha)) + fAlpha;

		return UIColor(red: red, green: green, blue: blue, alpha: alpha)
	}
}

let liveView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 600))
liveView.backgroundColor = .orange
PlaygroundPage.current.liveView = liveView

// MARK:- Gradients
let alphaViews = (0 ..< 8).map { _ in return UIView() }
let blendViews = (0 ..< 8).map { _ in return UIView() }

let gradientHeight = 40

alphaViews.enumerated().forEach {
	let (index, view) = $0
	view.frame = CGRect(
		x: 50,
		y: gradientHeight * index + gradientHeight,
		width: 100,
		height: gradientHeight + 2
	)
	view.layer.borderWidth = 2
	view.layer.borderColor = UIColor.white.cgColor
	let alpha = CGFloat(index) * 0.2 - 0.2
	view.backgroundColor = UIColor.black.withAlphaComponent(alpha)
	liveView.addSubview(view)
}

blendViews.enumerated().forEach {
	let (index, view) = $0
	view.frame = CGRect(
		x: 150,
		y: gradientHeight * index + gradientHeight,
		width: 100,
		height: gradientHeight + 2
	)
	view.layer.borderWidth = 2
	view.layer.borderColor = UIColor.white.cgColor
	let alpha = CGFloat(index) * 0.2 - 0.2
	view.backgroundColor = UIColor.orange.transition(to: .black, progress: alpha)
	liveView.addSubview(view)
}


// MARK:- Overlayed
let backAlpha = UIView(frame: CGRect(x: 50, y: 400, width: 100, height: 100))
backAlpha.backgroundColor = UIColor.white.withAlphaComponent(0.6)
liveView.addSubview(backAlpha)

let backBlend = UIView(frame: CGRect(x: 150, y: 400, width: 100, height: 100))
backBlend.backgroundColor = UIColor.white.transition(to: .orange, progress: 0.4)
liveView.addSubview(backBlend)

let middleAlpha = UIView(frame: CGRect(x: 70, y: 420, width: 60, height: 100))
middleAlpha.backgroundColor = UIColor.white.withAlphaComponent(0.8)
liveView.addSubview(middleAlpha)

let middleBlend = UIView(frame: CGRect(x: 170, y: 420, width: 60, height: 100))
middleBlend.backgroundColor = UIColor.white.transition(to: .orange, progress: 0.2)
liveView.addSubview(middleBlend)

let topAlpha = UIView(frame: CGRect(x: 90, y: 440, width: 20, height: 100))
topAlpha.backgroundColor = UIColor.white.withAlphaComponent(0.8)
liveView.addSubview(topAlpha)

let topBlend = UIView(frame: CGRect(x: 190, y: 440, width: 20, height: 100))
topBlend.backgroundColor = UIColor.white.transition(to: .orange, progress: 0.2)
liveView.addSubview(topBlend)


print("finis coronat opus~")

