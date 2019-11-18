// There is a box protected by a password. The password is a sequence of n digits where each digit can be one of the first k digits 0, 1, ..., k-1.
// While entering a password, the last n digits entered will automatically be matched against the correct password.=
// For example, assuming the correct password is "345", if you type "012345", the box will open because the correct password matches the suffix of the entered password.
// Return any password of minimum length that is guaranteed to open the box at some point of entering it.

// Example 1:

// Input: n = 1, k = 2
// Output: "01"
// Note: "10" will be accepted too.

// Example 2:

// Input: n = 2, k = 2
// Output: "00110"
// Note: "01100", "10011", "11001" will be accepted too.

// Note:

//     n will be in the range [1, 4].
//     k will be in the range [1, 10].
//     k^n will be at most 4096.


// This is a brute force DFS graph search problem.

// Proven that optimal sequence exists such that the next password in the sequence
// can reuse the n-1 digits in previous password. We can build a graph with k^n possible
// passwords and try to find a path that visits all nodes while only use 1 new digit at
// a time.

// Time: O(k^(k^n)) worst, O(k^n) if no backtracking, Space: O(k^n), 
// Length of result sequence: k^n + (n - 1)
func crackSafe(_ n: Int, _ k: Int) -> String {
    // All possibilities of n digit password from 0 to k - 1
    let maxPossibleCount = Int(pow(Double(k), Double(n)))

    var solution = String(repeating: "0", count: n)
    var visited: Set = [ String(repeating: "0", count: n) ]

    return dfs(&solution, n, k, maxPossibleCount, &visited) ? solution : ""
}

// Return true when has a solution. Return false if stuck, then do backtracking
func dfs(_ solution: inout String, _ n: Int, _ k: Int, _ maxPossibleCount: Int, _ visited: inout Set<String>) -> Bool {
    
    // If we have brute forced all possible passwords
    if visited.count == maxPossibleCount {
        return true
    }
    
    // Calculate current password in the chain by resuing the last n-1 digit in last password
    let prefix = solution.suffix(n - 1)
    for i in 0..<k {
        let password = "\(prefix)\(i)"
        if !visited.contains(password) {
            // add the digit back to solution
            solution += String(i)   
            visited.insert(password)
            
            if dfs(&solution, n, k, maxPossibleCount, &visited) {
                // The rest of this solution works
                return true
            }
            
            // This attempt doesn't give a solution. Revert back.
            solution.removeLast()
            visited.remove(password)
        }
    }
    return false
}