// Given a non-empty array containing only positive integers, find if the array can be partitioned into two subsets such that the sum of elements in both subsets is equal.

// Note:
// Each of the array element will not exceed 100.
// The array size will not exceed 200.
// Example 1:

// Input: [1, 5, 11, 5]

// Output: true

// Explanation: The array can be partitioned as [1, 5, 5] and [11].

// Example 2:

// Input: [1, 2, 3, 5]

// Output: false

// Explanation: The array cannot be partitioned into equal sum subsets.

/*
Sum(partition) = Sum(others) 
=> Sum(partition) = Sum(all) / 2

follow up: count the number of ways partition the set
let dp[i][j] = number of partitions in first i elements to get target sum j
*/

func canPartition(_ nums: [Int]) -> Bool {
    var sum = nums.reduce(0, +)
    if sum % 2 == 1 { return false }
    return subsetSum(nums, sum / 2) > 0
}

func subsetSum(_ nums: [Int], _ sum: Int) -> Int {
    var dp = Array(repeating: 0, count: sum + 1)
    dp[0] = 1
    for n in nums {
        if sum >= n {
            for i in stride(from: sum, to: n - 1, by: -1) {
                dp[i] += dp[i - n]
            }
        }
    }
    return dp[sum]
}

