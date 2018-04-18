//: in Swift 4
print("⭕️ InteractivePop playground")

import UIKit
import PlaygroundSupport


class Navigator: UINavigationController {

}


class Presented: UIViewController {
  private typealias `Self` = Presented

  static var sharedTransitionCoord: UIViewControllerTransitionCoordinator?

  init(title: String, background: UIColor) {
    super.init(nibName: nil, bundle: nil)
    self.title = title
    view.backgroundColor = background
  }


  required init?(coder: NSCoder) {
    fatalError("\(#function) not supported")
  }


  func trackFunction(functionName: String = #function) {
    print("\(title!): \(functionName)")

    if transitionCoordinator != nil {
      if Self.sharedTransitionCoord != nil {
        let sameCoord = Self.sharedTransitionCoord! === transitionCoordinator!
        print("   ✅transitionCoord shared:\(sameCoord ? "✅same" : "❌diff")")
      } else {
        Self.sharedTransitionCoord = transitionCoordinator!
        print("   ✅transitionCoord shared:🚸set")
      }
    } else {
      print("   ⭕️transitionCoord")
    }
  }


  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // `viewWillDisappear` always starts the sequence of disappear/appear functions
    print("▶️========== viewWillDisappear!")
    trackFunction()
  }


  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    trackFunction()
  }


  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    trackFunction()
  }


  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    trackFunction()
    // `viewDidAppear` always ends the sequence of disappear/appear functions
    Self.sharedTransitionCoord = nil
    print("⏹========== viewDidAppear!")
  }

}


class Tap: UITapGestureRecognizer {

  let closure: () -> Void

  init(closure: @escaping () -> Void) {
    self.closure = closure
    super.init(target: self, action: #selector(performClosure))
  }

  @objc func performClosure() {
    closure()
  }

}


let root = Presented(title: "✴️ Root", background: .orange)
let presented = Presented(title: "⚛️ Presented", background: .purple)
let navigator = Navigator(rootViewController: root)

let tap = Tap {
  print("☑️ Pushing view controller")
  navigator.pushViewController(presented, animated: true)
}
root.view.addGestureRecognizer(tap)


PlaygroundPage.current.liveView = navigator

print("👑 finis coronat opus~")

