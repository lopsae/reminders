//: in Swift 4
print("⭕️ TupleGrouper playground")


struct TupleGrouper<Tuple> {

  let tuple: Tuple
  let list: [Printable]


  private init(tuple: Tuple, list: [Printable]) {
    self.tuple = tuple
    self.list = list
  }


  static func group(registration: (inout Register) -> Tuple) -> TupleGrouper {
    var registerer = Register()
    let tuple = registration(&registerer)
    return TupleGrouper(tuple: tuple, list: registerer.things)
  }


  struct Register {

    private(set) var things: [Printable] = []

    static func < <T: Printable> (rhs: inout Register, lhs: T) -> T {
      rhs.things.append(lhs)
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



let group = TupleGrouper.group {(
  first:  $0 < 3,
  second: $0 < "string"
)}


group.tuple.first
group.tuple.second

group.list.forEach { $0.print() }


print("👑 finis coronat opus~")

