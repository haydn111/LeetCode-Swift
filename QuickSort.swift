func quickSort(_ array: inout [Int], low: Int, high: Int) {
    if low < high {
        let pivot = partition(&array, low: low, high: high)
        quickSort(&array, low: low, high: pivot - 1)
        quickSort(&array, low: pivot + 1, high: high)
    }
}

func partition(_ array: inout [Int], low: Int, high: Int) -> Int {
    let pivot = array[high]
    var pivotIndex = low
    
    for i in low...high {
        if array[i] <= pivot {
            array.swapAt(i, pivotIndex)
            pivotIndex += 1
        }
    }
    return pivotIndex - 1
}

var arr = [9, 8, 7, 6, 5, 4, 1, 2, 5, 10, 5, 15, 20, 7, 3, 2, 8]
quickSort(&arr, low: 0, high: arr.count - 1)
print(arr)
