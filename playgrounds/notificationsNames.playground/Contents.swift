//: in Swift 4


import Foundation


enum SomeNotif: String {
  case one = "one"
  case two = "two"
}


extension SomeNotif: NotificationEmitter {}


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


NotificationCenter.default.addObserver(forName: Notification.Name("normalNotif"), object: nil, queue: nil) { _ in
  print("normal closure notif received")
}
NotificationCenter.default.post(Notification(name: Notification.Name("normalNotif")))


SomeNotif.one.addObserver { _ in
  print("emitter one notif received!")
}

SomeNotif.one.post()
SomeNotif.two.post()


print("finis coronat opus~")

