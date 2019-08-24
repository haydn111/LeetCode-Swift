// Given a set of distinct positive integers, find the largest subset such that every pair (Si, Sj) of elements in this subset satisfies: Si % Sj = 0 or Sj % Si = 0.

// If there are multiple solutions, return any subset is fine.

// Example 1:

// nums: [1,2,3]

// Result: [1,2] (of course, [1,3] will also be ok)
// Example 2:

// nums: [1,2,4,8]

// Result: [1,2,4,8]


/*
1. Sort
2. Find the length of longest subset end at nums[i]: 
    for every nums[j] in i-1...0 that can be divided by nums[i], dp[i] = max(dp[i], dp[j]+1)
3. Record the largest dp[i] of it.
4. Do a loop from the largest element to nums[0], add every element belongs to the longest subset. Each divisible i causing dp[i] to increase is in the longest subset
*/

// O(n^2) dp solution
func largestDivisibleSubset(_ nums: [Int]) -> [Int] {
    if nums.count == 0 { return [] }
    var dp = Array(repeating: 1, count: nums.count), sortedNums = nums.sorted()
    var result = [Int](), maxLength = 1, maxIndex = 0
    for i in 1 ..< sortedNums.count {
        for j in stride(from: i - 1, through: 0, by: -1) {
            if sortedNums[i] % sortedNums[j] == 0 {
                dp[i] = max(dp[i], dp[j] + 1)
            }
        }
        if dp[i] > maxLength {
            maxLength = dp[i]; maxIndex = i
        }
    }

    // find the longest subset: each divisible i causing dp[i] to increase is in the longest subset
    for i in stride(from: maxIndex, through: 0, by: -1) {
        if sortedNums[maxIndex] % sortedNums[i] == 0 && dp[i] == maxLength {
            result.append(sortedNums[i])
            maxLength -= 1
        }
    }

    return result.reversed()
}


// O(n^3) dfs solution
var sortedNums = [Int](), result = [Int]()
func largestDivisibleSubset(_ nums: [Int]) -> [Int] {
    sortedNums = nums.sorted()
    for i in 0 ..< sortedNums.count {
        findSubset(i, [sortedNums[i]])
    }
    return result
}

func findSubset(_ startIndex: Int, _ subset: [Int]) {    // startIndex is the dividend
    if subset.count > result.count { result = subset }
    for i in startIndex + 1 ..< sortedNums.count {
        if sortedNums[i] % subset.last! == 0 { 
            findSubset(i, subset + [sortedNums[i]])
        }
    }
}
