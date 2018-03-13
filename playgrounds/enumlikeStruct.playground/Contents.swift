//: enumlikeStruct
print("⭕️ enumlikeStruct")

// Struct that can be used as key of a dictionary
// for Swift 4


struct Enumlike {

  let value: StaticString

  private init() { fatalError() }

  static let one: Enumlike = "one"
  static let two: Enumlike = "two"
  static let maic: Enumlike = "maic"

}


extension Enumlike: ExpressibleByStringLiteral {
  init(stringLiteral: StaticString) {
    value = stringLiteral
  }
}


extension Enumlike: Hashable, Equatable {
  var hashValue: Int {
    return value.description.hashValue
  }

  static func == (lhs: Enumlike, rhs: Enumlike) -> Bool {
    return lhs.value.description == rhs.value.description
  }
}



let dict: [Enumlike: Any] = [
  .one: "first",
  .maic: "dance"
]


print("👑 finis coronat opus~")

