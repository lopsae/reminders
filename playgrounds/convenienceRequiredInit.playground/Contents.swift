

class SomeRequired {
	let text: String

	required init() {
		text = "nothing"
	}

	required init(stringo: String) {
		text = stringo
	}

	required init(matango: String) {
		text = matango
	}

}


class MakeConvenience: SomeRequired {

	convenience required init() {
		preconditionFailure()
	}

	required init(stringo: String) {
		super.init(matango: stringo)
	}

	convenience required init(matango: String) {
		self.init(convenient: matango)
	}

	init(convenient: String) {
		super.init()
	}

}


class ExtendedConvenience: MakeConvenience {

	override init(convenient: String) {
		super.init(convenient: convenient)
	}

	required init(stringo: String) {
		super.init(stringo: stringo)
	}

}


print("finis coronat opus~")

