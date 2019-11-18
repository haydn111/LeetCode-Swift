// Given an integer array with all positive numbers and no duplicates, find the number of possible combinations that add up to a positive integer target.

// Example:

// nums = [1, 2, 3]
// target = 4

// The possible combination ways are:
// (1, 1, 1, 1)
// (1, 1, 2)
// (1, 2, 1)
// (1, 3)
// (2, 1, 1)
// (2, 2)
// (3, 1)

// Note that different sequences are counted as different combinations.

// Therefore the output is 7.
// Follow up:
// What if negative numbers are allowed in the given array?
// How does it change the problem?
// What limitation we need to add to the question to allow negative numbers?

// DP solution
func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
    if target == 0 || nums.count == 0 { return 0 }
    var dp = Array(repeating: 0, count: target + 1)
    for i in 1...target {
        for num in nums { 
            if i >= num {
                if num == i { dp[i] += 1 }
                else { dp[i] += dp[i - num] }
            }
        }
    }
    return dp[target]
}

// DFS solution. can only handle very small number
var solution = [[Int]]()
func dfs(_ seq: [Int], _ nums: [Int], _ target: Int) {
    if target <= 0 { return }
    if nums.contains(target) { solution.append(seq + [target]) }
    for num in nums {
        if target >= num {
            dfs(seq + [num], nums, target - num)
        }
    }
}

func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
    dfs([], nums, target)
    return solution.count
}
