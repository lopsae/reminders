//: How optionals used to compare with `>` and `<`


// Comparison operators with optionals were removed from the Swift Standard Libary.
func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
	switch (lhs, rhs) {
	case let (l?, r?):
		return l < r
	case (nil, _?):
		return true
	default:
		return false
	}
}

// Comparison operators with optionals were removed from the Swift Standard Libary.
func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
	switch (lhs, rhs) {
	case let (l?, r?):
		return l > r
	default:
		return rhs < lhs
	}
}


let maybeTwo: Int? = 2
let nothing: Int? = nil
let maybeFour: Int? = 4

// Compare against optionals are only possible with the above operators

// Against not nills comparisons work as expected
1 < maybeTwo // true
3 < maybeTwo // false

maybeFour < 6 // true
maybeFour < 3 // false

5 > maybeFour // true
3 > maybeFour // false

maybeTwo > 1 // true
maybeTwo > 3 // false


// Non nil compared against nil is always greater than
1 > nothing // true
1 < nothing // false
nothing < 3 // true
nothing > 3 // false


nothing < maybeTwo // true
nothing > maybeTwo // false
maybeTwo > nothing // true
maybeTwo < nothing // false

// nil against nil is always false
nothing < nothing // false
nothing > nothing // false

