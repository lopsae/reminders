//: in Swift 4
print("⭕️ TupleGrouper playground")


struct TupleGrouper<Tuple, Grouper> {

  let tuple: Tuple
  let list: [Grouper]


  private init(tuple: Tuple, list: [Grouper]) {
    self.tuple = tuple
    self.list = list
  }


  static func group(type: Grouper.Type, registration: (inout Register<Grouper>) -> Tuple) -> TupleGrouper {
    var registerer = Register<Grouper>()
    let tuple = registration(&registerer)
    return TupleGrouper(tuple: tuple, list: registerer.things)
  }


  struct Register<Grouper> {

    private(set) var things: [Grouper] = []

    static func < <T> (rhs: inout Register, lhs: T) -> T {
      if let lhs = lhs as? Grouper {
        rhs.things.append(lhs)
      } else {
        assertionFailure("Element cannot be casted to \(Grouper.self)")
      }

      return lhs
    }

  }

}


protocol Printable {
  func print()
}

extension String: Printable {
  func print() { Swift.print("string-print! \(self)") }
}

extension Int: Printable {
  func print() { Swift.print("int-print! \(self)") }
}



let group = TupleGrouper.group(type: Printable.self) {(
  first:  $0 < 3,
  second: $0 < "string"
)}


group.tuple.first
group.tuple.second

group.list.forEach { $0.print() }


print("👑 finis coronat opus~")

