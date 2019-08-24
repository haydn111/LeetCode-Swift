// Given a string, your task is to count how many palindromic substrings in this string.

// The substrings with different start indexes or end indexes are counted as different substrings even they consist of same characters.

// Example 1:
// Input: "abc"
// Output: 3
// Explanation: Three palindromic strings: "a", "b", "c".
// Example 2:
// Input: "aaa"
// Output: 6
// Explanation: Six palindromic strings: "a", "a", "a", "aa", "aa", "aaa".
// Note:
// The input string length won't exceed 1000.

// Time O(n^2)
extension String {
    subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

class Solution {
    func countSubstrings(_ s: String) -> Int {
        var result = 0
        for i in 0..<s.count {
            result += checkPalindrome(in: s, left: i, right: i) // odd length palindrome
            result += checkPalindrome(in: s, left: i, right: i + 1) // even length palindrome
        }
        return result
    }
    
    func checkPalindrome(in s: String, left: Int, right: Int) -> Int {
        var count = 0
        var l = left, r = right
        while (l >= 0 && r < s.count && s[l] == s[r]) { 
            count += 1 
            l -= 1
            r += 1
        } 
        return count
    }
}