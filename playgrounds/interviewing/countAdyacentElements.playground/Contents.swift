// Given an ordered array of integers, count how many of a target element
// exist in the array.

// For [1, 2, 2, 3, 3, 3, 5, 5, 5, 5, 5]
// Target `3` returns a count of 3


func findStartBoundary<T: Comparable>(target: T, array: [T]) -> [T].Index? {
    return findStartBoundary(target: target, slice: array[...])
}

func findStartBoundary<T: Comparable>(target: T, slice: ArraySlice<T>) -> ArraySlice.Index? {
    let log = Logger(enabled: false)
    log("▶️ target: \(target) slice: \(slice) s/e: \(slice.startIndex)/\(slice.endIndex) c: \(slice.count)" )
    if (slice.isEmpty) {
        log("⚙️ checking empty, returning nil")
        return nil
    }
    if (slice.count == 1) {
        log("⚙️ checking single: \(slice)")
        if slice.first == target {
            return slice.startIndex
        } else {
            return nil
        }
    }


    let middleIndex = slice.startIndex + (slice.count / 2)
    log("⚙️ middleIndex: \(middleIndex), value: \(slice[middleIndex])")

    if slice[middleIndex] == target {
        if middleIndex == slice.startIndex {
            // First element is always boundary
            log("⏹️ first element at: \(middleIndex)")
            return slice.startIndex
        }
        if slice[middleIndex - 1] != target {
            // Previous element is different, middle is boundary
            log("⏹️ boundary element at: \(middleIndex)")
            return middleIndex
        }

        // Otherwise search at lower half
        return findStartBoundary(target: target, slice: slice[..<middleIndex])

    } else if slice[middleIndex] > target {
        // middle is larger, search lower half
        return findStartBoundary(target: target, slice: slice[..<middleIndex])

    } else {
        // middle is smaller, search higher half
        // TODO: Can this be middleIndex+1
        return findStartBoundary(target: target, slice: slice[middleIndex...])
    }
}

let startLog = Logger(prefix: "🍊", enabled: true)
startLog("Start boundaries")
//            0  1  2  3  4  5  6  7  8  9  10 11 12 13 14
let sArray = [1, 1, 1, 2, 2, 2, 2, 5, 5, 5, 7, 7, 7, 7, 8]
startLog("find 0, expected nil: \(findStartBoundary(target: 0, array: sArray).orNil)")
startLog("find 1, expected 0:   \(findStartBoundary(target: 1, array: sArray).orNil)")
startLog("find 2, expected 3:   \(findStartBoundary(target: 2, array: sArray).orNil)")
startLog("find 4, expected nil: \(findStartBoundary(target: 4, array: sArray).orNil)")
startLog("find 5, expected 7:   \(findStartBoundary(target: 5, array: sArray).orNil)")
startLog("find 7, expected 10:  \(findStartBoundary(target: 7, array: sArray).orNil)")
startLog("find 8, expected 14:  \(findStartBoundary(target: 8, array: sArray).orNil)")
startLog("find 9, expected nil: \(findStartBoundary(target: 9, array: sArray).orNil)")



func findEndBoundary<T: Comparable>(target: T, array: [T]) -> [T].Index? {
    return findEndBoundary(target: target, slice: array[...])
}

func findEndBoundary<T: Comparable>(target: T, slice: ArraySlice<T>) -> ArraySlice.Index? {
    let log = Logger(enabled: false)
    log("▶️ target: \(target) slice: \(slice) s/e: \(slice.startIndex)/\(slice.endIndex) c: \(slice.count)" )
    if (slice.isEmpty) {
        log("⚙️ checking empty, returning nil")
        return nil
    }
    if (slice.count == 1) {
        log("⚙️ checking single: \(slice)")
        if slice.first == target {
            return slice.startIndex
        } else {
            return nil
        }
    }


    let middleIndex = slice.startIndex + (slice.count / 2)
    log("⚙️ middleIndex: \(middleIndex), value: \(slice[middleIndex])")

    if slice[middleIndex] == target {
        if middleIndex == slice.endIndex - 1 {
            // Last element is always boundary
            log("⏹️ last element at: \(middleIndex)")
            return slice.endIndex - 1
        }
        if slice[middleIndex + 1] != target {
            // Next element is different, middle is boundary
            log("⏹️ boundary element at: \(middleIndex)")
            return middleIndex
        }

        // Otherwise search at higher half
        return findEndBoundary(target: target, slice: slice[middleIndex...])

    } else if slice[middleIndex] > target {
        // middle is larger, search lower half
        return findEndBoundary(target: target, slice: slice[..<middleIndex])

    } else {
        // middle is smaller, search higher half
        return findEndBoundary(target: target, slice: slice[middleIndex...])
    }
}


let endLog = Logger(prefix: "🍋", enabled: true)
endLog("End boundaries")
//            0  1  2  3  4  5  6  7  8  9  10 11 12 13 14
let eArray = [1, 1, 1, 2, 2, 2, 2, 5, 5, 5, 7, 7, 7, 7, 8]
endLog("find 0, expected nil: \(findEndBoundary(target: 0, array: eArray).orNil)")
endLog("find 1, expected 2:   \(findEndBoundary(target: 1, array: eArray).orNil)")
endLog("find 2, expected 6:   \(findEndBoundary(target: 2, array: eArray).orNil)")
endLog("find 4, expected nil: \(findEndBoundary(target: 4, array: eArray).orNil)")
endLog("find 5, expected 9:   \(findEndBoundary(target: 5, array: eArray).orNil)")
endLog("find 7, expected 13:  \(findEndBoundary(target: 8, array: eArray).orNil)")
endLog("find 8, expected 14:  \(findEndBoundary(target: 8, array: eArray).orNil)")
endLog("find 9, expected nil: \(findEndBoundary(target: 9, array: eArray).orNil)")




