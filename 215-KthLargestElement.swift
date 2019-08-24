// Find the kth largest element in an unsorted array. Note that it is the kth largest element in the sorted order, not the kth distinct element.

// Example 1:

// Input: [3,2,1,5,6,4] and k = 2
// Output: 5

// Example 2:

// Input: [3,2,3,1,2,4,5,5,6] and k = 4
// Output: 4

// Note: 
// You may assume k is always valid, 1 ≤ k ≤ array's length.

func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    var array = nums
    return quickSelect(&array, low: 0, high: array.count - 1, k: k - 1)
}

// O(n)
func quickSelect(_ array: inout [Int], low: Int, high: Int, k: Int) -> Int {
    let pivotIndex = partition(&array, low: low, high: high)
    if k == pivotIndex { return array[pivotIndex] }
    else if k < pivotIndex { return quickSelect(&array, low: low, high: pivotIndex - 1, k: k) }
    else { return quickSelect(&array, low: pivotIndex + 1, high: high, k: k) }
}

func partition(_ array: inout [Int], low: Int, high: Int) -> Int {
    let pivot = array[high]
    var pivotIndex = low
    for i in low..<high {
        if array[i] > pivot {
            array.swapAt(pivotIndex, i)
            pivotIndex += 1
        }
    }
    array.swapAt(pivotIndex, high)
    return pivotIndex
}
