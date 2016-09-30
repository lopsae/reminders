

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
//    mutating func shift() -> Element {
//
//    }

    /// Inserts an element as the head of the list.
//    mutating func unshift(_ element: Element) {
//
//    }

}


//extension Node: CustomStringConvertible {
//    var description: String {
//        get {
//            var string: String?
//            var current = self
//
//            whileLoop: while true {
//                switch current {
//                case .list(let listElement, let listNext):
//                    if string == nil {
//                        string = String(listElement)
//                    } else {
//                        string! += ", \(String(listElement))"
//                    }
//                    current = listNext
//
//                case .tail:
//                    string = ""
//                    break whileLoop
//                }
//            }
//
//            return string!
//        }
//    }
//}


//var emptyList = Node<String>()

var list = Node(element: "first")
//var list = Node.list(element: "first", next: .tail)
list.push("second")
list.push("third")

list.pop()
list.pop()

