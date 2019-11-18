// Given an array which consists of non-negative integers and an integer m, you can split the array into m non-empty continuous subarrays. Write an algorithm to minimize the largest sum among these m subarrays.

// Note:
// If n is the length of array, assume the following constraints are satisfied:

//     1 ≤ n ≤ 1000
//     1 ≤ m ≤ min(50, n)

// Examples:

// Input:
// nums = [7,2,5,10,8]
// m = 2

// Output:
// 18

// Explanation:
// There are four ways to split nums into two subarrays.
// The best way is to split it into [7,2,5] and [10,8],
// where the largest sum among the two subarrays is only 18.

// DP with O(mn^2) time complexity
func splitArray(_ nums: [Int], _ m: Int) -> Int {
    // Calculate pre sum        
    var sum = 0
    let preSum = nums.map { i -> Int in
        sum += i
        return sum
    }
            
    // Answer of sub problems
    // dp[i][j] = min of the largest sum when dividing nums[0...j] into i groups
    // 0 <= j < nums.count, 1 <= i <= m
    var dp = [[Int]](repeating: [Int](repeating: Int.max, count: nums.count),
                        count: m + 1)
    
    // Divide into 1 group is just the preSum itself
    dp[1] = preSum
    
    for i in 1...m {
        for j in 0..<nums.count {
            // Solve for first k numbers in nums[0...j]
            for k in 0..<j {
                dp[i][j] = min(dp[i][j], 
                                max(dp[i - 1][k],    // 1st part: solution for nums[0...k] in i - 1 groups
                                    preSum[j] - preSum[k]))  // 2nd part: sum of nums[k + 1...j]
            }
        }
    }
    
    return dp[m][nums.count - 1]
}
