//: in Swift 4
print("⭕️ TupleGrouper playground")


struct TupleGrouper<Tuple> {

  let tuple: Tuple
  let list: [Any]


  private init(tuple: Tuple, list: [Any]) {
    self.tuple = tuple
    self.list = list
  }


  static func group(registration: (Register) -> Tuple) -> TupleGrouper {
    let registerer = Register()
    let tuple = registration(registerer)
    return TupleGrouper(tuple: tuple, list: registerer.things)
  }


  class Register {

    var things: [Any] = []

    func register<T>(_ thing: T) -> T {
      things.append(thing)
      return thing
    }

    static func < <T> (rhs: Register, lhs: T) -> T {
      return rhs.register(lhs)
    }

  }




}


let group = TupleGrouper.group {(
  first:  $0 < 3,
  second: $0 < 3.5,
  third:  $0 < "string"
)}


group.tuple.first
group.tuple.second

group.list


print("👑 finis coronat opus~")

