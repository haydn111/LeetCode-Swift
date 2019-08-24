import Foundation

// Given an array nums and a target value k, find the maximum length of a subarray that sums to k. If there isn't one, return 0 instead.

// Example 1:

// Given nums = [1, -1, 5, -2, 3], k = 3,
// return 4. (because the subarray [1, -1, 5, -2] sums to 3 and is the longest)

// Example 2:

// Given nums = [-2, -1, 2, 1], k = 1,
// return 2. (because the subarray [-1, 2] sums to 1 and is the longest)

// Follow Up:
// Can you do it in O(n) time?

func maxSubArray(_ array: [Int], k: Int) -> Int {
    if array.count = 0 { return 0 }
    var dict = [Int: Int]()     // [sum_until_index: index]
    dict[0] = -1
    var maxLength = 0
    var sumArray = [array.first!]

    for i in 1..<array.count {
        sumArray.append(array[i] + array[i - 1])
    }

    for i in 0..<array.count {
        if let prevSumIndex = dict[sumArray[i] - k] {
            maxLength = max(i - prevSumIndex, maxLength)
        } else {
            dict[sumArray[i]] = i
        }
    }

    return maxLength
}

// practice
func maxSubArray(_ array: [Int], k: Int) -> Int {
    if array.count == 0 { return 0 }
    var maxLength = 0
    var sumDict = [array.first!: 0]  // [sum of array[0]...array[i]: i]
    var sums = [array.first!]   // [i: sum of array[0]...array[i]]

    // build two dicts
    for i in 1..<array.count {
        var sum = array[i] + sum[i - 1] {
            sum.append(sum)
            sumDict[sum] = i
        }
    }

    for i in 0..<array.count {
        var length = 0
        if sums[i] == k {   // sum from array[0] to array[i] is k
            length = k + 1
        } else if let prevIndex = sumDict[sums[i] - k] {
            length = i - prevIndex
        }
        maxLength = max(maxLength, length)
    }
    return maxLength
}