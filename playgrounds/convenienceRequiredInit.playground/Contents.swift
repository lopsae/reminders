
// Class defines some required initializers
class SomeRequired {
	let text: String

	init() {
		text = "nothing"
	}

	required init(one: String) {
		text = one
	}

	required init(two: String) {
		text = two
	}

}

// A class that defines no new inits automatically inherits all parent inits
class NoOverrides: SomeRequired {}

NoOverrides()
NoOverrides(one: "one")
NoOverrides(two: "two")


class MakeConvenience: SomeRequired {

	// Adding any additional inits breaks the automatic init inheritance
	// Which means that all required inits must be provided again
	init(convenient: String) {
		super.init()
	}

	required init(one: String) {
		super.init(one: one)
	}

	// Required inits can be marked as `convenience`, which can be used to later
	// override all designated inits, instead of all required
	convenience required init(two: String) {
		self.init(convenient: two)
	}

}

// All new and required initializers are available
MakeConvenience(convenient: "conv")
MakeConvenience(one: "one")
MakeConvenience(two: "two")


class ExtendedConvenience: MakeConvenience {

	init (extra: String) {
		super.init(convenient: extra)
	}

	// By overriding and providing again all designated init, all convenience
	// inits are inherited
	override init(convenient: String) {
		super.init(convenient: convenient)
	}

	required init(one: String) {
		super.init(one: one)
	}

}

ExtendedConvenience(extra: "extra")
ExtendedConvenience(convenient: "conv")
ExtendedConvenience(one: "one")
// init(two:) is available, even if it was not provided again
ExtendedConvenience(two: "two")


print("finis coronat opus~")

