import UIKit

func quickSort(_ array: [Int]) -> [Int] {
    var result = array
    let start = result.startIndex
    let end = result.index(before: result.endIndex)
    quickSort(&result, start: start, end: end)
    return result
}

func quickSort(_ array: inout [Int], start: [Int].Index, end: [Int].Index) {
    print("quicksort \(start) to \(end)")
    print("q: \(array)")
    guard start < end else { return }

    let pivotIndex = lomutoPartition(&array, start: start, end: end)
    quickSort(&array, start: start, end: pivotIndex - 1)
    quickSort(&array, start: pivotIndex + 1, end: end)
}

func lomutoPartition(_ array: inout [Int], start: [Int].Index, end: [Int].Index) -> [Int].Index {
    var pivotValue = array[end]
    print("Partitioning: \(start) to \(end) pivotValue:\(pivotValue)")

    var indexForSmaller = start

    for index in start..<end {
        if array[index] <= pivotValue {
            array.swapAt(index, indexForSmaller)
            indexForSmaller += 1
        }
    }

    array.swapAt(indexForSmaller, end)
    print("partitioned pivot:\(indexForSmaller)")
    print("p: \(array)")
    return indexForSmaller
}

func isSorted(_ array: [Int]) -> Bool {
    for index in array.indices.dropLast() {
        if array[index] > array[index + 1] {
            return false
        }
    }
    return true
}



//var array: [Int] = [70, 81, 68, 21, 81, 95, 13, 83, 10, 96, 75, 18, 61, 96, 10, 31, 68, 58, 11, 14]
//var array: [Int] = [70, 81, 68, 21, 81, 95, 13, 83]
var array: [Int] = [5, 8, 9, 4, 7]

let sorted = quickSort(array)
print(sorted)
print("Is sorted: \(isSorted(sorted) ? "✅" : "⛔️")")



