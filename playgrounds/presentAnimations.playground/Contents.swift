/*:
 Preview of different present animations available with
 `modalTransitionStyle`.

 Written in Swift 4
*/
print("⭕️ PresentAnimations playground")

import UIKit
import PlaygroundSupport


class Presented: UIViewController {
  private typealias `Self` = Presented


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

  let closurer: Closurer

  init(closure: @escaping () -> Void) {
    closurer = Closurer(closure: closure)
    super.init(target: closurer, action: #selector(Closurer.performClosure))
  }

}


class Closurer: NSObject {
  let closure: () -> Void

  init(closure: @escaping () -> Void) {
    self.closure = closure
    super.init()
  }

  @objc func performClosure() {
    closure()
  }

}


let root = Presented(title: "✴️ Root", background: .orange)
let presented = Presented(title: "⚛️ Presented", background: .purple)
presented.modalTransitionStyle = .partialCurl


let navigator = UINavigationController(rootViewController: root)

root.view.addGestureRecognizer(Tap {
  navigator.present(presented, animated: true)
})

presented.view.addGestureRecognizer(Tap {
  navigator.dismiss(animated: true)
})


PlaygroundPage.current.liveView = navigator

print("👑 finis coronat opus~")

