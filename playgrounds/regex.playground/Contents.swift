import Foundation
import RegexBuilder

// Example: 2025-07-19T18:48:14-0600, or 2025-07-19T18:48:14Z


func timezone(from isoDateString: String) -> TimeZone? {
    let timezoneRegex = Regex {
        ChoiceOf {
            "Z"  // Zulu time (UTC)
            Regex {
                Capture {
                    ChoiceOf { "+"; "-" }
                }
                Capture {
                    Repeat(count: 2) { .digit }
                } transform: { Int($0)! }
                Optionally { ":" }
                Capture {
                    Repeat(count: 2) { .digit }
                } transform: { Int($0)! }
            }
        }

        // End of string or whitespace
        Anchor.endOfSubjectBeforeNewline
    }

    guard let match = isoDateString.firstMatch(of: timezoneRegex) else {
        return nil
    }

    if match.0 == "Z" {
        return .gmt
    }

    guard let sign = match.1,
          let hours = match.2,
          let minutes = match.3
    else {
        return nil
    }

    var totalMinutes = hours * 60 + minutes
    if sign == "-" {
        totalMinutes = -totalMinutes
    }
    
    return TimeZone(secondsFromGMT: totalMinutes * 60)
}


let isoDateString = "2025-07-19T18:48:14-0600"
let isoDateStringColon = "2025-07-19T18:48:14+06:00"
let isoDateStringZero = "2025-07-19T18:48:14Z"
timezone(from: isoDateString)
timezone(from: isoDateStringColon)
timezone(from: isoDateStringZero)



