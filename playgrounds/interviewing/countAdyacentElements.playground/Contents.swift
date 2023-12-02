// Given an ordered array of integers, count how many of a target element
// exist in the array.

// For [1, 2, 2, 3, 3, 3, 5, 5, 5, 5, 5]
// Target `3` returns a count of 3


func findStartBoundary(target: Int, array: [Int]) -> Int? {
//    print("▶️ checking: \(array)")
    if (array.isEmpty) {
//        print("⚙️ checking empty, returning nil")
        return nil
    }
    if (array.count == 1) {
//        print("⚙️ checking single: \(array)")
        if array[0] == target {
            return 0
        } else {
            return nil
        }
    }


    let middleIndex = array.count / 2
//    print("⚙️ middleIndex: \(middleIndex), value: \(array[middleIndex])")

    if array[middleIndex] == target {
        if middleIndex == 0 {
            // First element is always boundary
            return 0
        }
        if array[middleIndex - 1] != target {
            // Previous element is different, middle is boundary
            return middleIndex
        }

        // Otherwise earch at lower half
        return findStartBoundary(target: target, array: Array(array[0..<middleIndex]))

    } else if array[middleIndex] > target {
        // middle is larger, search lower half
        return findStartBoundary(target: target, array: Array(array[0..<middleIndex]))

    } else {
        // middle is smaller, search higher half
        let maybeFound = findStartBoundary(target: target, array: Array(array[middleIndex..<array.count]))
        if let found = maybeFound {
            // Adjust for array slice position
            return middleIndex + found
        }
    }

    return nil
}

//           0  1  2  3  4  5  6  7  8  9  10 11 12 13 14
let array = [1, 1, 1, 2, 2, 2, 2, 5, 5, 5, 7, 7, 7, 7, 8]
print("array.count: \(array.count)")
print("find 0, expected nil: \(findStartBoundary(target: 0, array: array).orNil)")
print("find 1, expected 0:   \(findStartBoundary(target: 1, array: array).orNil)")
print("find 2, expected 3:   \(findStartBoundary(target: 2, array: array).orNil)")
print("find 4, expected nil: \(findStartBoundary(target: 4, array: array).orNil)")
print("find 5, expected 7:   \(findStartBoundary(target: 5, array: array).orNil)")
print("find 7, expected 10:  \(findStartBoundary(target: 8, array: array).orNil)")
print("find 8, expected 14:  \(findStartBoundary(target: 8, array: array).orNil)")
print("find 9, expected nil: \(findStartBoundary(target: 9, array: array).orNil)")


//func foundEndBoundary(target: Int, array: [Int]) -> Int? {
//    if (array.isEmpty) {
//        return nil
//    }
//    if (array.count == 1) {
//        if array[0] == target {
//            return 0
//        } else {
//            return nil
//        }
//    }
//
//    let middleIndex = array.count / 2
//    // print("middle: \(middleIndex)")
//
//    if array[middleIndex] == target {
//        if middleIndex == array.count -1 {
//            return array.count -1
//        }
//        if array[middleIndex - 1] != target {
//            return middleIndex
//        }
//        // search at lower half
//        // print("searching: \(Array(array[0..<middleIndex]))")
//        return foundStartBoundary(target: target, array: Array(array[middleIndex..<array.count]))
//    } else if array[middleIndex] > target {
//        // print("searching: \(Array(array[0..<middleIndex]))")
//        return foundStartBoundary(target: target, array: Array(array[0..<middleIndex]))
//
//    } else {
//        // print("searching: \(Array(array[middleIndex..<array.count]))")
//        let maybeFound = foundStartBoundary(target: target, array: Array(array[middleIndex..<array.count]))
//        if let found = maybeFound {
//            return middleIndex + found
//        }
//    }
//
//    return nil
//}


//let array = [1, 1, 1, 2, 2, 2, 2, 5, 5, 5, 8, 8, 8, 8, 10, 10]
//print("count: \(array.count)")
//print("found 2: \(foundStartBoundary(target: 2, array: array))")
//print("found 4: \(foundStartBoundary(target: 4, array: array))")
//print("found 5: \(foundStartBoundary(target: 5, array: array))")
//print("found 8: \(foundStartBoundary(target: 8, array: array))")



