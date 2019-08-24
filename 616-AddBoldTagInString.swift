// Given a string s and a list of strings dict, you need to add a closed pair of bold tag <b> and </b> to wrap the substrings in s that exist in dict. If two such substrings overlap, you need to wrap them together by only one pair of closed bold tag. Also, if two substrings wrapped by bold tags are consecutive, you need to combine them.

// Example 1:

// Input: 
// s = "abcxyz123"
// dict = ["abc","123"]
// Output:
// "<b>abc</b>xyz<b>123</b>"
 
// Example 2:

// Input: 
// s = "aaabbcc"
// dict = ["aaa","aab","bc"]
// Output:
// "<b>aaabbc</b>c"

// Note:

// - The given dict won't contain duplicates, and its length won't exceed 100.
// - All the strings in input have length in range [1, 1000].

// Complexity O(nml), n = s.count, m = dict.count, l = average length of word in dict
func addBoldTag(_ s: String, _ dict: [String]) -> String {
    var str = s, bold = [Bool](repeating: false, count: s.count), i = 0
    while str.count > 0 {
        for dictStr in dict {
            if str.hasPrefix(dictStr) {
                for j in i ..< i + dictStr.count { bold[j] = true }
            }
        }
        str.removeFirst()
        i += 1
    }
    str = ""; i = 0
    while i < s.count {
        if bold[i] {
            str += "<b>"
            while i < s.count && bold[i] {
                str.append(s[i])
                i += 1
            }
            str += "</b>"
        } else {
            str.append(s[i])
            i += 1
        }
    }
    return str
}
