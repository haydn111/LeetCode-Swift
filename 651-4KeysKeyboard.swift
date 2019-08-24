// Imagine you have a special keyboard with the following keys:

// Key 1: (A): Print one 'A' on screen.
// Key 2: (Ctrl-A): Select the whole screen.
// Key 3: (Ctrl-C): Copy selection to buffer.
// Key 4: (Ctrl-V): Print buffer on screen appending it after what has already been printed.

// Now, you can only press the keyboard for N times (with the above four keys), find out the maximum numbers of 'A' you can print on screen.

// Example 1:

// Input: N = 3
// Output: 3
// Explanation: 
// We can at most get 3 A's on screen by pressing following key sequence:
// A, A, A

// Example 2:

// Input: N = 7
// Output: 9
// Explanation: 
// We can at most get 9 A's on screen by pressing following key sequence:
// A, A, A, Ctrl A, Ctrl C, Ctrl V, Ctrl V

// Note:
// 1 <= N <= 50
// Answers will be in the range of 32-bit signed integer.

func maxA(_ n: Int) -> Int {
    // dp[i] = max A's after pressing i times.
    var dp = [Int](repeating: 0, count: n + 1)
    for i in 1...n {
        dp[i] = max(dp[i], 1 + dp[i - 1])   // Press a single A
        if i >= 3 {
            for j in 1...i - 2 {    // j is the # of ctrl+v after c+a and c+c
                // Press A for i - 2 - j times. Then press ctrl+a, ctrl+c. Then press ctrl+v for j times.
                dp[i] = max(dp[i], (j + 1) * dp[i - 2 - j]) 
            }
        }
    }
    return dp[n]
}

/*
Optimize: Assume at some time dp[i] = N, consider two sequence of operations
N   a   c   v   v   v   v   v(6N)   v(7N)
N   a   c   v   a   c   v   v(6N)   v(8N)

Easy to see that increasing # of c+v (j) should stop at 5 because pressing c+v for more than 5 times is guarenteed to not produce the max # of A's

=> jMax = min(i - 2, 5) => O(n)
*/