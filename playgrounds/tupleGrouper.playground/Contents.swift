//: in Swift 4
print("⭕️ TupleGrouper playground")


struct TupleGrouper<Tuple> {

  let tuple: Tuple
  let list: [Any]

  private init(tuple: Tuple, list: [Any]) {
    self.tuple = tuple
    self.list = list
  }

  static func group(registration: (TupleRegister) -> Tuple) -> TupleGrouper {
    let registerer = TupleRegister()
    let tuple = registration(registerer)
    return TupleGrouper(tuple: tuple, list: registerer.things)
  }

}


class TupleRegister {

  var things: [Any] = []

  func register<T>(_ thing: T) -> T {
    things.append(thing)
    return thing
  }

}


let group = TupleGrouper.group { registerer in
  return (
    first: registerer.register(3),
    second: registerer.register(3.5),
    third: registerer.register("string")
  )
}

group.tuple.first
group.tuple.second

group.list


print("👑 finis coronat opus~")

