// Given two words word1 and word2, find the minimum number of steps required to make word1 and word2 the same, where in each step you can delete one character in either string.

// Example 1:
// Input: "sea", "eat"
// Output: 2
// Explanation: You need one step to make "sea" to "ea" and another step to make "eat" to "ea".
// Note:
// The length of given words won't exceed 500.
// Characters in given words can only be lower-case letters.

func minDistance(_ word1: String, _ word2: String) -> Int {
    let lcs = longestCommonSubsequence(word1, word2)
    return (word1.count - lcs) + (word2.count - lcs)
}

// dp[i][j] = length of longest common subsequence for first i chars in word1 and first j chars in word2
// At some i, j, if two chars are equal then dp[i][j] = 1 + dp[i - 1][j - 1]. Otherwise dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
// do not use dp[i][j] = lcs of word1[0...i] and word2[0...j] because then you need to fill dp[0][0], dp[0][1] and dp[1][0] for initial condition.
func longestCommonSubsequence(_ word1: String, _ word2: String) -> Int {
    if word1.count == 0 || word2.count == 0 { return 0 }
    var dp = Array(repeating: [Int](repeating: 0, count: word2.count + 1), count: word1.count + 1)
    for i in 1...word1.count {
        for j in 1...word2.count {
            if word1[i - 1] == word2[j - 1] {
                dp[i][j] = 1 + dp[i - 1][j - 1]
            } else {
                dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
            }
        }
    }
    return dp[word1.count][word2.count]
}
