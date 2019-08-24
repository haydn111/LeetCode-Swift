// Given a 2D binary matrix filled with 0's and 1's, find the largest square containing only 1's and return its area.

// Example:

// Input: 

// 1 0 1 0 0
// 1 0 1 1 1
// 1 1 1 1 1
// 1 0 0 1 0

// Output: 4

func maximalSquare(_ matrix: [[Character]]) -> Int {
    if matrix.count == 0 || matrix[0].count == 0 { return 0 }
    // dp[i][j] = length of square in matrix[0...i][0...j]
    var dp = Array(repeating: Array(repeating: 0, count: matrix[0].count), count: matrix.count)
    var maxLen = 0
    for i in 0..<matrix.count {
        for j in 0..<matrix[0].count {
            if i == 0 || j == 0 {
                dp[i][j] = matrix[i][j] == "1" ? 1: 0
                maxLen = max(maxLen, dp[i][j])
            }
            else if matrix[i][j] == "1" {
                dp[i][j] = 1 + min(min(dp[i][j - 1], dp[i - 1][j]), dp[i - 1][j - 1])
                maxLen = max(maxLen, dp[i][j])
            }
        }
    }
    return maxLen * maxLen
}

print(maximalSquare([["1","0","1","0","0"],["1","0","1","1","1"],["1","1","1","1","1"],["1","0","0","1","0"]]))

