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
        return findStartBoundary(target: target, slice: slice[(middleIndex + 1)...])
    }
}


let startLog = Logger(prefix: "🍊", enabled: true)
startLog("Start boundaries")
//            0  1  2  3  4  5  6  7  8  9  10 11 12 13 14
let sArray = [1, 1, 1, 2, 2, 2, 2, 5, 5, 5, 7, 7, 7, 7, 8]
startLog.test("expected miss", expected: 0, test: findStartBoundary(target: 9, array: sArray))
startLog.test(expected: nil, test: findStartBoundary(target: 0, array: sArray))
startLog.test(expected: 0,   test: findStartBoundary(target: 1, array: sArray))
startLog.test(expected: 3,   test: findStartBoundary(target: 2, array: sArray))
startLog.test(expected: nil, test: findStartBoundary(target: 4, array: sArray))
startLog.test(expected: 7,   test: findStartBoundary(target: 5, array: sArray))
startLog.test(expected: 10,  test: findStartBoundary(target: 7, array: sArray))
startLog.test(expected: 14,  test: findStartBoundary(target: 8, array: sArray))
startLog.test(expected: nil, test: findStartBoundary(target: 9, array: sArray))




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
        return findEndBoundary(target: target, slice: slice[(middleIndex + 1)...])

    } else if slice[middleIndex] > target {
        // middle is larger, search lower half
        return findEndBoundary(target: target, slice: slice[..<middleIndex])

    } else {
        // middle is smaller, search higher half
        return findEndBoundary(target: target, slice: slice[(middleIndex + 1)...])
    }
}


let endLog = Logger(prefix: "🍋", enabled: true)
endLog("End boundaries")
//            0  1  2  3  4  5  6  7  8  9  10 11 12 13 14
let eArray = [1, 1, 1, 2, 2, 2, 2, 5, 5, 5, 7, 7, 7, 7, 8]
endLog.test("expected miss", expected: 0, test: findEndBoundary(target: 9, array: sArray))
endLog.test(expected: nil, test: findEndBoundary(target: 0, array: eArray))
endLog.test(expected: 2,   test: findEndBoundary(target: 1, array: eArray))
endLog.test(expected: 6,   test: findEndBoundary(target: 2, array: eArray))
endLog.test(expected: nil, test: findEndBoundary(target: 4, array: eArray))
endLog.test(expected: 9,   test: findEndBoundary(target: 5, array: eArray))
endLog.test(expected: 13,  test: findEndBoundary(target: 7, array: eArray))
endLog.test(expected: 14,  test: findEndBoundary(target: 8, array: eArray))
endLog.test(expected: nil, test: findEndBoundary(target: 9, array: eArray))



func countAdjacent<T: Comparable>(target: T, array: [T]) -> Int {
    return countAdjacent(target: target, slice: array[...])
}

func countAdjacent<T: Comparable>(target: T, slice: ArraySlice<T>) -> Int {
    let log = Logger(enabled: false)
    log("▶️ target: \(target) slice: \(slice) s/e: \(slice.startIndex)/\(slice.endIndex) c: \(slice.count)" )

    var startBoundary: Int? = nil
    var startSlice = slice
    var endSlice: ArraySlice<T>?

    while startBoundary == nil {
        log("🅰️ startSlice: \(startSlice) s/e: \(startSlice.startIndex)/\(startSlice.endIndex) c: \(startSlice.count)" )
        if (startSlice.isEmpty) {
            log("⏹️ empty startSlice, returning zero")
            return 0
        }
        if (startSlice.count == 1) {
            if startSlice.first == target {
                log("⏹️ start boundary element at: \(startSlice.startIndex)")
                startBoundary = startSlice.startIndex
                endSlice = slice[(startSlice.startIndex+1)...]
                break
            } else {
                log("⏹️ mismatched single element at startSlice, returning zero")
                return 0
            }
        }

        let middleIndex = startSlice.startIndex + (startSlice.count / 2)
        log("⚙️ middleIndex: \(middleIndex), value: \(startSlice[middleIndex])")

        if startSlice[middleIndex] == target {
            if middleIndex == startSlice.startIndex
               || slice[middleIndex - 1] != target
            {
                // First element is always boundary
                log("⏹️ start boundary element at: \(middleIndex)")
                startBoundary = middleIndex
                endSlice = slice[(middleIndex+1)...]
                break
            }

            // Otherwise search at lower half
            log("⚙️ startSlice to lower half")
            startSlice = startSlice[..<middleIndex]
        } else if slice[middleIndex] > target {
            // middle is larger, search lower half
            log("⚙️ startSlice to lower half")
            startSlice = startSlice[..<middleIndex]
        } else {
            // middle is smaller, search higher half
            log("⚙️ startSlice to higher half")
            startSlice = startSlice[(middleIndex+1)...]
        }
    }

    guard var endSlice, let startBoundary
    else {
        log("⏹️ No endslice")
        return 0
    }

    var endBoundary: Int? = nil
    while endBoundary == nil {
        log("🅱️ endSlice: \(endSlice) s/e: \(endSlice.startIndex)/\(endSlice.endIndex) c: \(endSlice.count)" )
        if (endSlice.isEmpty) {
            log("⚙️ empty endSlice")
            endBoundary = endSlice.startIndex
            break
        }
        if (endSlice.count == 1) {
            log("⚙️ single element at endSlice: \(endSlice)")
            if endSlice.first == target {
                endBoundary = endSlice.startIndex + 1
            } else {
                endSlice.startIndex
            }
            break
        }

        let middleIndex = endSlice.startIndex + (endSlice.count / 2)
        log("⚙️ middleIndex: \(middleIndex), value: \(endSlice[middleIndex])")

        if endSlice[middleIndex] == target {
            if middleIndex == endSlice.endIndex - 1
                || endSlice[middleIndex + 1] != target
            {
                // Last element is always boundary
                log("⏹️ end boundary at: \(middleIndex)")
                endBoundary = middleIndex + 1
                break
            }

            // Otherwise search at higher half
            endSlice = endSlice[(middleIndex + 1)...]
        } else if slice[middleIndex] > target {
            // middle is larger, search lower half
            endSlice = endSlice[..<middleIndex]

        } else {
            // middle is smaller, search higher half
            endSlice = endSlice[(middleIndex + 1)...]
        }
    }

    guard let endBoundary else {
        log("⏹️ No endBoundary")
        return 0
    }

    return endBoundary - startBoundary
}


let countLog = Logger(prefix: "🍓", enabled: true)
countLog("Adyacent counts")
//            0  1  2  3  4  5  6  7  8  9  10 11 12 13 14
let cArray = [1, 1, 1, 2, 2, 2, 2, 5, 5, 5, 7, 7, 7, 7, 8]
countLog.test("expected miss", expected: 5, test: countAdjacent(target: 9, array: sArray))
countLog.test(expected: 0, test: countAdjacent(target: 0, array: cArray))
countLog.test(expected: 3, test: countAdjacent(target: 1, array: cArray))
countLog.test(expected: 4, test: countAdjacent(target: 2, array: cArray))
countLog.test(expected: 0, test: countAdjacent(target: 4, array: cArray))
countLog.test(expected: 3,   test: countAdjacent(target: 5, array: cArray))
countLog.test(expected: 4,  test: countAdjacent(target: 7, array: cArray))
countLog.test(expected: 1,  test: countAdjacent(target: 8, array: cArray))
countLog.test(expected: 0, test: countAdjacent(target: 9, array: cArray))



print("👑 finis coronat opus~")


