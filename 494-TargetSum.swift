// You are given a list of non-negative integers, a1, a2, ..., an, and a target, S. Now you have 2 symbols + and -. For each integer, you should choose one from + and - as its new symbol.

// Find out how many ways to assign symbols to make sum of integers equal to target S.

// Example 1:
// Input: nums is [1, 1, 1, 1, 1], S is 3. 
// Output: 5
// Explanation: 

// -1+1+1+1+1 = 3
// +1-1+1+1+1 = 3
// +1+1-1+1+1 = 3
// +1+1+1-1+1 = 3
// +1+1+1+1-1 = 3

// There are 5 ways to assign symbols to make the sum of nums be target 3.

// Note:
// The length of the given array is positive and will not exceed 20.
// The sum of elements in the given array will not exceed 1000.
// Your output answer is guaranteed to be fitted in a 32-bit integer.

// DFS (brute force)
// Time: O(2^n), Space: O(n)

class DFSSolution {
    var solution = [String]()
    var numsGiven = [Int]()
    var targetResult = 0

    func dfs(expr: String, position: Int, prevResult: Int, result: Int) {
        if position == numsGiven.count {
            if result == targetResult { solution.append(expr) }
            return
        }

        let currNum = Int(numsGiven[position])
        let currString = String(currNum)
        
        dfs(expr: expr + "+" + currString, position: position + 1, prevResult: currNum, result: result + currNum)
        dfs(expr: expr + "-" + currString, position: position + 1, prevResult: -currNum, result: result - currNum)
    }

    func findTargetSumWays(_ nums: [Int], _ S: Int) -> Int {
        if nums.count == 0 { return 0 }
        numsGiven = nums
        targetResult = S
        dfs(expr: "", position: 0, prevResult: 0, result: 0)
        return solution.count
    }

    // Shorter dfs
    func findTargetSumWays2(_ nums: [Int], _ S: Int) -> Int {
        var possibleSums = [0]
        for n in nums {
            possibleSums = possibleSums.flatMap { [$0 + n, $0 - n] }
        }
        return possibleSums.filter { $0 == S }.count
    }
}

// DP
// Sum of the sequence must between -sum(a) and sum(a) 
// => There are total S = 2 * sum(a) + 1 possible sums. 
// => Time: O(n * S)

// The original problem statement is equivalent to:
// Find a subset of nums that need to be positive, and the rest of them negative, such that the sum is equal to target

// Let P be the positive subset and N be the negative subset
// For example:
// Given nums = [1, 2, 3, 4, 5] and target = 3 then one possible solution is +1-2+3-4+5 = 3
// Here positive subset is P = [1, 3, 5] and negative subset is N = [2, 4]

// Then let's see how this can be converted to a subset sum problem:

//                   sum(P) - sum(N) = target
// sum(P) + sum(N) + sum(P) - sum(N) = target + sum(P) + sum(N)
//                        2 * sum(P) = target + sum(nums)
// So the original problem has been converted to a subset sum problem as follows:
// Find a subset P of nums such that sum(P) = (target + sum(nums)) / 2

// Note that the above formula has proved that target + sum(nums) must be even
// We can use that fact to quickly identify inputs that do not have a solution
// For detailed explanation on how to solve subset sum problem, you may refer to Partition Equal Subset Sum

class DPSolution {
    func findTargetSumWays(_ nums: [Int], _ S: Int) -> Int {
        var sum = nums.reduce(0, +)
        if sum < S || (S + sum) % 2 == 1 { return 0 }
        return subsetSum(nums, (S + sum) / 2)
    }

    func subsetSum(_ nums: [Int], _ sum: Int) -> Int {
        var dp = Array(repeating: 0, count: sum + 1)    // dp[i] = for target sum i, # of ways 
        dp[0] = 1
        for n in nums {
            if sum >= n {
                for i in stride(from: sum, to: n - 1, by: -1) {
                    dp[i] += dp[i - n]  // use n = dp[i - n], not use n = dp[i]
                }
            }
        }
        return dp[sum]
    }
}