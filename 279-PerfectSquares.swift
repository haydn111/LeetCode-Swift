// Given a positive integer n, find the least number of perfect square numbers (for example, 1, 4, 9, 16, ...) which sum to n.

// Example 1:

// Input: n = 12
// Output: 3 
// Explanation: 12 = 4 + 4 + 4.
// Example 2:

// Input: n = 13
// Output: 2
// Explanation: 13 = 4 + 9.

var dp = [0, 1]    // dp[i] = least # of perfect squares for i
func numSquares(_ n: Int) -> Int {
    if n <= 0 { return 0 }
    var i = dp.count - 1
    while i <= n {
        dp.append(Int.max)
        var j = 1
        while j * j <= i {
            dp[i] = min(dp[i], 1 + dp[i - j * j])
            j += 1
        }
        i += 1
    }
    return dp[n]
}    