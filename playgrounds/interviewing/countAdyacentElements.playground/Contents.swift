// Given an ordered array of integers, count how many of a target element
// exist in the array.

// For [1, 2, 2, 3, 3, 3, 5, 5, 5, 5, 5]
// Target `3` returns a count of 3


let testLogger = Logger(prefix: "🗄️", enabled: true)
testLogger.test("Match test", expected: 0, test: 0)
testLogger.test("Miss test ", expected: 0, test: 5)


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
startLog.test(expected: nil, test: findStartBoundary(target: 0, array: sArray))
startLog.test(expected: 0,   test: findStartBoundary(target: 1, array: sArray))
startLog.test(expected: 3,   test: findStartBoundary(target: 2, array: sArray))
startLog.test(expected: nil, test: findStartBoundary(target: 4, array: sArray))
startLog.test(expected: 7,   test: findStartBoundary(target: 5, array: sArray))
startLog.test(expected: 10,  test: findStartBoundary(target: 7, array: sArray))
startLog.test(expected: 14,  test: findStartBoundary(target: 8, array: sArray))
startLog.test(expected: nil, test: findStartBoundary(target: 9, array: sArray))
startLog.test("Miss", expected: 0, test: findStartBoundary(target: 9, array: sArray))



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
endLog.test(expected: nil, test: findEndBoundary(target: 0, array: eArray))
endLog.test(expected: 2,   test: findEndBoundary(target: 1, array: eArray))
endLog.test(expected: 6,   test: findEndBoundary(target: 2, array: eArray))
endLog.test(expected: nil, test: findEndBoundary(target: 4, array: eArray))
endLog.test(expected: 9,   test: findEndBoundary(target: 5, array: eArray))
endLog.test(expected: 13,  test: findEndBoundary(target: 7, array: eArray))
endLog.test(expected: 14,  test: findEndBoundary(target: 8, array: eArray))
endLog.test(expected: nil, test: findEndBoundary(target: 9, array: eArray))
endLog.test("Miss", expected: 0, test: findEndBoundary(target: 9, array: sArray))


