// Given a string and a string dictionary, find the longest string in the dictionary that can be formed by deleting some characters of the given string. If there are more than one possible results, return the longest word with the smallest lexicographical order. If there is no possible result, return the empty string.

// Example 1:
// Input:
// s = "abpcplea", d = ["ale","apple","monkey","plea"]

// Output: 
// "apple"
// Example 2:
// Input:
// s = "abpcplea", d = ["a","b","c"]

// Output: 
// "a"
// Note:
// All the strings in the input will only contain lower-case letters.
// The size of the dictionary won't exceed 1,000.
// The length of all the strings in the input won't exceed 1,000.

// Go thru the dictionary and find the longest word w such that w is a subsequence of s
func findLongestWord(_ s: String, _ d: [String]) -> String {
    var longest = ""
    for word in d {
        if isSubsequence(word, of: s) {
            if word.count > longest.count { longest = word }
        }
    }
    return longest
}

func isSubsequence(_ s: String, of ss: String) -> Bool {
    var i = s.startIndex, j = ss.startIndex
    while i < s.endIndex && j < ss.endIndex {
        while j < ss.endIndex && s[i] != ss[j] {
            j = ss.index(after: j)
        }
        if j != ss.endIndex && s[i] == ss[j] { i = s.index(after: i) }
    }
    
    return i == s.endIndex
}
