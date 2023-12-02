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
        return findStartBoundary(target: target, slice: slice[middleIndex...])
    }
}

//            0  1  2  3  4  5  6  7  8  9  10 11 12 13 14
let sArray = [1, 1, 1, 2, 2, 2, 2, 5, 5, 5, 7, 7, 7, 7, 8]
print("find 0, expected nil: \(findStartBoundary(target: 0, array: sArray).orNil)")
print("find 1, expected 0:   \(findStartBoundary(target: 1, array: sArray).orNil)")
print("find 2, expected 3:   \(findStartBoundary(target: 2, array: sArray).orNil)")
print("find 4, expected nil: \(findStartBoundary(target: 4, array: sArray).orNil)")
print("find 5, expected 7:   \(findStartBoundary(target: 5, array: sArray).orNil)")
print("find 7, expected 10:  \(findStartBoundary(target: 7, array: sArray).orNil)")
print("find 8, expected 14:  \(findStartBoundary(target: 8, array: sArray).orNil)")
print("find 9, expected nil: \(findStartBoundary(target: 9, array: sArray).orNil)")


func findEndBoundary(target: Int, array: [Int]) -> Int? {
    let log = Logger(enabled: false)
    log("▶️ target: \(target) checking: \(array)")
    if (array.isEmpty) {
        log("⚙️ checking empty, returning nil")
        return nil
    }
    if (array.count == 1) {
        log("⚙️ checking single: \(array)")
        if array[0] == target {
            return 0
        } else {
            return nil
        }
    }


    let middleIndex = array.count / 2
    log("⚙️ middleIndex: \(middleIndex), value: \(array[middleIndex])")

    if array[middleIndex] == target {
        if middleIndex == array.endIndex - 1 {
            // Last element is always boundary
            return array.endIndex - 1
        }
        if array[middleIndex + 1] != target {
            // Next element is different, middle is boundary
            return middleIndex
        }

        // Otherwise search at higher half
        let maybeFound = findEndBoundary(target: target, array: Array(array[middleIndex...]))
        if let found = maybeFound {
            // Adjust for array slice position
            return middleIndex + found
        }

    } else if array[middleIndex] > target {
        // middle is larger, search lower half
        return findEndBoundary(target: target, array: Array(array[0..<middleIndex]))

    } else {
        // middle is smaller, search higher half
        let maybeFound = findEndBoundary(target: target, array: Array(array[middleIndex..<array.count]))
        if let found = maybeFound {
            // Adjust for array slice position
            return middleIndex + found
        }
    }

    // Not found
    return nil
}


//            0  1  2  3  4  5  6  7  8  9  10 11 12 13 14
let eArray = [1, 1, 1, 2, 2, 2, 2, 5, 5, 5, 7, 7, 7, 7, 8]
print("array.count: \(eArray.count)")
print("find 0, expected nil: \(findEndBoundary(target: 0, array: eArray).orNil)")
print("find 1, expected 2:   \(findEndBoundary(target: 1, array: eArray).orNil)")
print("find 2, expected 6:   \(findEndBoundary(target: 2, array: eArray).orNil)")
print("find 4, expected nil: \(findEndBoundary(target: 4, array: eArray).orNil)")
print("find 5, expected 9:   \(findEndBoundary(target: 5, array: eArray).orNil)")
print("find 7, expected 13:  \(findEndBoundary(target: 8, array: eArray).orNil)")
print("find 8, expected 14:  \(findEndBoundary(target: 8, array: eArray).orNil)")
print("find 9, expected nil: \(findEndBoundary(target: 9, array: eArray).orNil)")




