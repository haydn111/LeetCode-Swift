// Given a non-empty string s, you may delete at most one character. Judge whether you can make it a palindrome.

// Example 1:
// Input: "aba"
// Output: True
// Example 2:
// Input: "abca"
// Output: True
// Explanation: You could delete the character 'c'.
// Note: The string will only contain lowercase characters a-z. The maximum length of the string is 50000.

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (range: CountableClosedRange<Int>) -> Substring {
        let start = range.first!
        let end = range.last!
        return self[index(startIndex, offsetBy: start)...index(startIndex, offsetBy: end)]
    }
}

class Solution {
    func validPalindrome(_ s: String) -> Bool {
        var i = 0, j = s.count - 1
        while i < j {
            if s[i] != s[j] {
                if s[i + 1] == s[j] || s[i] == s[j - 1] {
                    return isPalindrome(s, i+1, j) || isPalindrome(s, i, j-1)
                } else {
                    return false
                }
            }
            i += 1
            j -= 1
        }
        return true
    }
    
    func isPalindrome(_ s: String, _ i: Int, _ j: Int) -> Bool {
        if j - i + 1 == 1 { return true }
        for k in i...(i + j) / 2 {
            if s[k] != s[i + j - k] { return false }
        }
        return true
    }
}