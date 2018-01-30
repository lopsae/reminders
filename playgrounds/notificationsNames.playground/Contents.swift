//: in Swift 4


import Foundation


enum TestEmitter: String {
  case one = "one"
  case two = "two"
  case normal = "normal"
}


extension TestEmitter: NotificationEmitter {}


protocol NotificationEmitter {
  func addObserver(closure: @escaping (Notification) -> Void)
  func post()
}


extension NotificationEmitter where Self: RawRepresentable, Self.RawValue == String {

  var name: Notification.Name {
    return Notification.Name(rawValue: self.rawValue)
  }

  func addObserver(closure: @escaping (Notification) -> Void) {
    print("adding observer to \(name.rawValue)")
    NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil, using: closure)
  }

  func post() {
    print("posting notif to \(name.rawValue)")
    NotificationCenter.default.post(Notification(name: name))
  }

}



print("⭕️ Checking anonymous closure notifications")
let anonymousToken = NotificationCenter.default.addObserver(forName: TestEmitter.normal.name, object: nil, queue: nil) { _ in
  print("anonymous closure notif received")
}
TestEmitter.normal.post()
NotificationCenter.default.removeObserver(anonymousToken)
TestEmitter.normal.post()



print("⭕️ Checking notifications with object and after deinit")
class NormalObserver {
  init() {
    NotificationCenter.default.addObserver(self, selector: #selector(onNotification), name: TestEmitter.normal.name, object: nil)
    NotificationCenter.default.addObserver(forName: TestEmitter.normal.name, object: nil, queue: nil) { _ in
      print("NormalObserver closure notif received")
    }
  }

  deinit {
    print("NormalObserver deinitialized")
  }

  @objc func onNotification(_ notification: Notification) {
    print("NormalObserver selector notif received")
  }
}

var maybeNormal: NormalObserver? = NormalObserver()
TestEmitter.normal.post()
maybeNormal = nil
TestEmitter.normal.post()



print("⭕️ Checking notifications through NotificationEmitter interfaces")



TestEmitter.one.addObserver { _ in
  print("emitter one notif received!")
}

TestEmitter.one.post()
TestEmitter.two.post()


print("👑 finis coronat opus~")

