// Given a positive integer n and you can do operations as follow:

// If n is even, replace n with n/2.
// If n is odd, you can replace n with either n + 1 or n - 1.
// What is the minimum number of replacements needed for n to become 1?

// Example 1:

// Input:
// 8

// Output:
// 3

// Explanation:
// 8 -> 4 -> 2 -> 1

// Example 2:

// Input:
// 7

// Output:
// 4

// Explanation:
// 7 -> 8 -> 4 -> 2 -> 1
// or
// 7 -> 6 -> 3 -> 2 -> 1


// Removing bits is the fastest way. So even number is bettern than odd
// If odd, compare # of 1's of n-1 and n+1 in binary form. If n-1 has less 1's, choose n-1. 
// Or when n = 3, always do n - 1
// Otherwise do n + 1, even n-1 and n+1 has same # of 1's. Consider example 1011 - 1 = 1010 and 1011 + 1 = 1100. Second way is better.
// As a result: 
//     If n is even, halve it.
//     If n=3 or n-1 has less 1's than n+1, decrement n.
//     Otherwise, increment n.
func integerReplacement(_ n: Int) -> Int {
    var m = n, count = 0
    while m != 1 {
        if m % 2 == 0 { m /= 2 }
        else if m == 3 { m -= 1 }
        else {
            let oneCntMinus = String(m - 1, radix: 2).filter { $0 == "1" }.count
            let oneCntPlus = String(m + 1, radix: 2).filter { $0 == "1" }.count
            if oneCntMinus < oneCntPlus { m -= 1 }
            else { m += 1 }
        }
        count += 1
    }
    return count
}
