// In the computer world, use restricted resource you have to generate maximum benefit is what we always want to pursue.

// For now, suppose you are a dominator of m 0s and n 1s respectively. On the other hand, there is an array with strings consisting of only 0s and 1s.

// Now your task is to find the maximum number of strings that you can form with given m 0s and n 1s. Each 0 and 1 can be used at most once.

// Note:
// The given numbers of 0s and 1s will both not exceed 100
// The size of given string array won't exceed 600.

// Example 1:
// Input: Array = {"10", "0001", "111001", "1", "0"}, m = 5, n = 3
// Output: 4

// Explanation: This are totally 4 strings can be formed by the using of 5 0s and 3 1s, which are “10,”0001”,”1”,”0”

// Example 2:
// Input: Array = {"10", "0", "1"}, m = 1, n = 1
// Output: 2

// Explanation: You could form "10", but then you'd have nothing left. Better form "0" and "1".


// O(kl + kmn) dp solution (AC)
func findMaxForm(_ strs: [String], _ m: Int, _ n: Int) -> Int {
    var dp = Array(repeating: [Int](repeating: 0, count n + 1), count m + 1)
    for s in strs {
        let (zeroCount, oneCount) = countChars(s)
        for i in stride(from: m, through: zeroCount, by: -1) {
            for j in stride(from: n, through: oneCount, by: -1) {
                dp[i][j] = max(dp[i][j], 1 + dp[i - zeroCount][j - oneCount])
            }
        }
    }
    return dp[m][n]
}

// O(kl + k^2) dfs solution (TLE)
func findMaxForm(_ strs: [String], _ m: Int, _ n: Int) -> Int {
    var mutableStrs = strs
    return selectStrings(&mutableStrs, 0, 0, m, n)
}

func selectStrings(_ strs: inout [String], _ i: Int, _ count: Int, _ m: Int, _ n: Int) -> Int {
    if i == strs.count || (m == 0 && n == 0) { return count }
    let (zeroCount, oneCount) = countChars(strs[i])
    if zeroCount <= m && oneCount <= n {
        return max(selectStrings(&strs, i + 1, count + 1, m - zeroCount, n - oneCount), 
                    selectStrings(&strs, i + 1, count, m, n))
    } else {
        return selectStrings(&strs, i + 1, count, m, n)
    }
}

var charCountDict = [String: (Int, Int)]()
func countChars(_ s: String) -> (Int, Int) {    // # of 0's, # of 1's
    if charCountDict[s] == nil {  
        var zeroCount = s.filter { $0 == "0" }.count
        charCountDict[s] = (zeroCount, s.count - zeroCount)
    }
    return charCountDict[s]!    
}