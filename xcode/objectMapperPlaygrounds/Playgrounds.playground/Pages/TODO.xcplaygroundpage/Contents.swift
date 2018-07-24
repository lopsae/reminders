

import PlaygroundSupport
import ObjectMapperPlaygrounds

import ObjectMapper

// Dont forget to compile tests to make Pods available


struct TestObject: Mappable {

  var string: String?
  var integer: Int?

  init?(map: Map) {

  }


  mutating func mapping(map: Map) {
    string  <- (map["string"], stringFromNumericTransform)
    integer <- map["integer"]
  }

}


// Transform of String (mapped) from Numeric (json)
let stringFromNumericTransform = TransformOf<String, Any>(
  fromJSON: {
    (jsonValue: Any?) -> String? in
    guard let jsonValue = jsonValue else {
      return nil
    }
    switch jsonValue {
    case let double as Double:
      return String(describing: double)
    case let integer as Int:
      return String(describing: integer)
    case let string as String:
      return string
    default:
      return nil
    }
  },
  toJSON: {
    (string: String?) -> Any? in
    guard let string = string else {
      return nil
    }
    return string
  }
)


var test = TestObject(JSON: [
  "string": 5678,
  "integer": 1234
])

test
test?.string
test?.integer
test?.toJSON()



//============================================================
//============================================================
//============================================================



enum Enumerated: String, Mappable {
  case uno, dos

  init(map: Map) {
    self = .uno
  }

  mutating func mapping(map: Map) {
    let value:String = map.value() ?? ""
    self = Enumerated(rawValue: value) ?? .uno
  }

}

class TestEnumer: Mappable {

  var first: Enumerated = .uno
  var second: Enumerated = .uno
  var third: Enumerated = .uno

  required init?(map: Map) {
  }

  func mapping(map: Map) {
//    first  = try! map.value("first")
    first  <- map["first"]
    second <- map["second"]
    third  <- map["third"]
  }

}


var testEnumer = TestEnumer(JSON: [
  "first": "uno",
  "second": "dos",
  "third": "tres"
])

testEnumer
testEnumer?.first
testEnumer?.second
testEnumer?.third



print("👑 finis coronat opus~")

