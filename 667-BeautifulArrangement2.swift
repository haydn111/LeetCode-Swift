
// Given two integers n and k, you need to construct a list which contains n different positive integers ranging from 1 to n and obeys the following requirement: 
// Suppose this list is [a1, a2, a3, ... , an], then the list [|a1 - a2|, |a2 - a3|, |a3 - a4|, ... , |an-1 - an|] has exactly k distinct integers.

// If there are multiple answers, print any of them.

// Example 1:
// Input: n = 3, k = 1
// Output: [1, 2, 3]
// Explanation: The [1, 2, 3] has three different positive integers ranging from 1 to 3, and the [1, 1] has exactly 1 distinct integer: 1.

// Example 2:
// Input: n = 3, k = 2
// Output: [1, 3, 2]
// Explanation: The [1, 3, 2] has three different positive integers ranging from 1 to 3, and the [2, 1] has exactly 2 dist


// When k = n-1, a valid construction is [1, n, 2, n-1, 3, n-2, ....]. One way to see this is, we need to have a difference of n-1, which means we need 1 and n adjacent; then, we need a difference of n-2, etc.
// When k = 1, a valid construction is [1, 2, 3, ..., n]
// Combine the above two construction, first sequence [1, 2, ... , n-1-k] satisfies n1 = n-1-k, k1 = 1. Second sequence [n-k, n, n-k+1, n-1, ... ] satisfies n2 = k+1, k2 = k-1. 
// For second part, start with head = n-k and tail = n. Terminate condition is while head <= tail && result.count < n

func constructArray(_ n: Int, _ k: Int) -> [Int] {
    var result = [Int]()
    // first part n1 = n-1-k, k1 = 1
    for i in 1..<n-k {
        result.append(i)
    }
    
    // second part n2 = k+1, k2 = k-1
    var head = n-k, tail = n
    while head <= tail && result.count < n {
        result.append(head); head += 1
        if result.count < n {
            result.append(tail); tail -= 1
        }
    }
    return result
}
