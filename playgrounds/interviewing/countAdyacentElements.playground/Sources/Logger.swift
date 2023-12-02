

public struct Logger {

    let enabled: Bool

    public init(enabled: Bool) {
        self.enabled = enabled
    }

    public func callAsFunction(_ message: @autoclosure () -> String) {
        guard enabled else { return }
        print(message())
    }

}

