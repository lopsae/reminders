

public extension Optional {

    var orNil: String {
        switch self {
        case .none: return "nil"
        case .some(let wrapped):
            return String(describing: wrapped)
        }
    }

}

