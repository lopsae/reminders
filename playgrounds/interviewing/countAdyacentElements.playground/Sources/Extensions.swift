

public extension Optional where Wrapped == Int {

    var orNil: String {
        switch self {
        case .none: return "nil"
        case .some(let wrapped):
            return String(describing: wrapped)
        }
    }

}

