
import Foundation

let french = Locale(identifier: "fr_FR")
french.decimalSeparator

let floating: Float = 2.5

floating.formatted(.number)
floating.formatted(.number.locale(french))
floating.formatted(.number.precision(.fractionLength(3)))

floating.formatted(CustomDecimalSeparatorFormat(separator: "_", fractionLength: 3))
floating.formatted(.customSeparator("_", fractionLength: 0))
floating.formatted(.customSeparator("_", fractionLength: 1))
floating.formatted(.customSeparator("_"))


struct CustomDecimalSeparatorFormat<Input: BinaryFloatingPoint>: FormatStyle {

    let separator: String
    let fractionLength: Int

    init(separator: String, fractionLength: Int = 1) {
        self.separator = separator
        self.fractionLength = fractionLength
    }

    func format(_ value: Input) -> String {
        let stableLocale = Locale(identifier: "en_US_POSIX")
        let interimFormat = FloatingPointFormatStyle<Input>()
            .precision(.fractionLength(fractionLength))
            .locale(stableLocale)
        var output = value.formatted(interimFormat)
        if let decimalSeparator = stableLocale.decimalSeparator {
            let separatorIndex = output.index(output.endIndex, offsetBy: -fractionLength - 1)
            if let afterSeparator = output.index(separatorIndex, offsetBy: decimalSeparator.count, limitedBy: output.endIndex) {
                let separatorRange = separatorIndex ..< afterSeparator
                output = output.replacingOccurrences(of: decimalSeparator, with: separator, range: separatorRange)
            }
        }
        return output
    }

}


extension FormatStyle where Self == CustomDecimalSeparatorFormat<Float> {
    internal static func customSeparator(_ separator: String, fractionLength: Int = 1) -> CustomDecimalSeparatorFormat<Float> {
        CustomDecimalSeparatorFormat(separator: separator, fractionLength: fractionLength)
    }
}

