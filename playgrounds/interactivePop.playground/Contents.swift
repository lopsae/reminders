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


let root = Presented(title: "Root", background: .orange)
let presented = Presented(title: "Presented", background: .red)

let navigator = Navigator(rootViewController: root)


PlaygroundPage.current.liveView = navigator

print("👑 finis coronat opus~")

