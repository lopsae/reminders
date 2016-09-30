// for Swift3

indirect enum Node<Element> {
    case list(element: Element, next: Node)
    case tail

    init() {
        self = .tail
    }

    init(element: Element) {
        self = .list(element: element, next: .tail)
    }

    /// Push an element to the tail of the list.
    mutating func push(_ tailElement: Element) {
        switch self {
        case .tail:
            self = .list(element: tailElement, next: .tail)
        case .list(let selfElement, var selfNext):
            selfNext.push(tailElement)
            self = .list(element: selfElement, next: selfNext)
        }
    }

    /// Pop an element from the tail of the list.
    mutating func pop() -> Element {
        switch self {
        case .tail:
            // Nothing to pop
            preconditionFailure()
        case .list(let selfElement, var selfNext):
            var tailElement: Element?
            switch selfNext {
            case .tail:
                //  Already at last node
                tailElement = selfElement
                self = .tail
            case .list:
                tailElement = selfNext.pop()
                // Redo self since selfNext changed after the pop
                self = .list(element: selfElement, next: selfNext)
            }
            return tailElement!
        }
    }

    /// Removes and return the first element of the list.
    mutating func shift() -> Element {
        switch self {
        case .tail:
            // Nothing to shift
            preconditionFailure()
        case .list(let selfElement, let selfNext):
            self = selfNext
            return selfElement
        }
    }

    /// Inserts an element as the head of the list.
//    mutating func unshift(_ element: Element) {
//
//    }

}


extension Node: CustomStringConvertible {
    var description: String {
        get {
            var contents:String

            switch self {
            case .tail:
                contents = ""
            case .list(let selfElement, let selfNext):
                switch selfNext {
                case .tail:
                    contents = "\(selfElement)"
                case .list:
                    contents = "\(selfElement), \(selfNext)"
                }
            }

            return "[\(contents)]"
        }
    }
}


//var emptyList = Node<String>()

var list = Node(element: "1st")
//var list = Node.list(element: "first", next: .tail)
list.push("2nd")
list.push("3rd")
list.push("4th")

list.pop()
list.pop()
list.shift()
list.push("2.5th")

