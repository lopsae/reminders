

public struct Logger {

    let enabled: Bool
    let prefix: String

    public init(prefix: String = "", enabled: Bool) {
        self.enabled = enabled
        self.prefix = prefix
    }

    public func callAsFunction(_ message: @autoclosure ()->String) {
        log(closure: message)
    }


    public func log(_ message: @autoclosure ()->String) {
        log(closure: message)
    }


    func log(closure: ()->String) {
        guard enabled else { return }
        if prefix.isEmpty {
            print(closure())
        } else {
            print("\(prefix) \(closure())" )
        }

    }


    public func test<T: Equatable>(
        _ message: @autoclosure ()->String = String(),
        expected: @autoclosure ()->T?,
        test: @autoclosure ()->T?)
    {
        guard enabled else { return }

        let messageValue = message()
        let header = !messageValue.isEmpty
            ? "\(messageValue): "
            : ""

        let testValue = test()
        let expectedValue = expected()

        let testString = testValue.orNil
        let expectedString = expectedValue.orNil

        if testValue == expectedValue {
            log("\(header)✅ match: \(testString)")
        } else {
            log("\(header)⛔️ miss: expected: \(expectedString) test: \(testString)")
        }

    }

}

