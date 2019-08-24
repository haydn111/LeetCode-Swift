// Return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.

// Example 1:

// Input: haystack = "hello", needle = "ll"
// Output: 2

// Example 2:

// Input: haystack = "aaaaa", needle = "bba"
// Output: -1
// Clarification:

// What should we return when needle is an empty string? This is a great question to ask during an interview.

// For the purpose of this problem, we will return 0 when needle is an empty string. This is consistent to C's strstr() and Java's indexOf().

extension String {
    subscript(range: CountableClosedRange<Int>) -> Substring {
        return self[index(startIndex, offsetBy: range.lowerBound)...index(startIndex, offsetBy: range.upperBound)]
    }
}

class Solution {
    func strStr(_ haystack: String, _ needle: String) -> Int {
        if needle.count == 0 { return 0 }
        if needle.count < haystack.count { return -1 }
        var l = 0, r = l + needle.count - 1 // sliding window
        while r < haystack.count {
            if String(haystack[l...r]) == needle { return l }
            l += 1; r += 1
        }
        return -1
    }
}