

public struct Logger {

    let enabled: Bool
    let prefix: String

    public init(prefix: String = "", enabled: Bool) {
        self.enabled = enabled
        self.prefix = prefix
    }

    public func callAsFunction(_ message: @autoclosure () -> String) {
        guard enabled else { return }
        print("\(prefix) \(message())" )
    }

}

