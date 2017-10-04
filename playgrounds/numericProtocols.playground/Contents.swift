

extension Array where Element: FloatingPoint {

	func sum() -> Element {
		return reduce(0, +)
	}

}

let floatings = [2.0, 3.0, 4.0]
type(of: floatings)
floatings.sum()


extension Array where Element: SignedInteger {

	func or() -> Element {
		return reduce(0, |)
	}

}

let integers = [1, 2, 4]
type(of: integers)
integers.or()


print("finis coronat opus~")

