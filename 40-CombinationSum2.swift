// Given a collection of candidate numbers (candidates) and a target number (target), find all unique combinations in candidates where the candidate numbers sums to target.

// Each number in candidates may only be used once in the combination.

// Note:

// All numbers (including target) will be positive integers.
// The solution set must not contain duplicate combinations.
// Example 1:

// Input: candidates = [10,1,2,7,6,1,5], target = 8,
// A solution set is:
// [
//   [1, 7],
//   [1, 2, 5],
//   [2, 6],
//   [1, 1, 6]
// ]

// Example 2:

// Input: candidates = [2,5,2,1,2], target = 5,
// A solution set is:
// [
//   [1,2,2],
//   [5]
// ]

var results = [[Int]]()
func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
    results = [[Int]]()
    dfs([], candidates.sorted(), target)
    return results
}

func dfs(_ seq: [Int], _ nums: [Int], _ target: Int) {
    if 0 == target {
        results.append(seq)
        return
    }
    var prev = -1, rest = nums
    while rest.count > 0 && target > 0 {
        let curr = rest.removeFirst()
        if curr == prev { continue }
        dfs(seq + [curr], rest, target - curr)
        prev = curr
    }
}
