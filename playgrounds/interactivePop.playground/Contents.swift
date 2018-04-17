//: in Swift 4
print("⭕️ InteractivePop playground")

import UIKit
import PlaygroundSupport


class Navigator: UINavigationController {

}


class Presented: UIViewController {

  init(title: String, background: UIColor) {
    super.init(nibName: nil, bundle: nil)
    self.title = title
    view.backgroundColor = background
  }


  required init?(coder: NSCoder) {
    fatalError("\(#function) not supported")
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


let root = Presented(title: "Root", background: .orange)
let presented = Presented(title: "Presented", background: .red)
let navigator = Navigator(rootViewController: root)

let tap = Tap {
  navigator.pushViewController(presented, animated: true)
}
root.view.addGestureRecognizer(tap)


PlaygroundPage.current.liveView = navigator

print("👑 finis coronat opus~")

