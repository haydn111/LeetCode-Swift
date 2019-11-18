// Given two strings S and T, return if they are equal when both are typed into empty text editors. # means a backspace character.

// Example 1:

// Input: S = "ab#c", T = "ad#c"
// Output: true
// Explanation: Both S and T become "ac".

// Example 2:

// Input: S = "ab##", T = "c#d#"
// Output: true
// Explanation: Both S and T become "".

// Example 3:

// Input: S = "a##c", T = "#a#c"
// Output: true
// Explanation: Both S and T become "c".

// Example 4:

// Input: S = "a#c", T = "b"
// Output: false
// Explanation: S becomes "c" while T becomes "b".

// Note:
//     1 <= S.length <= 200
//     1 <= T.length <= 200
//     S and T only contain lowercase letters and '#' characters.

// Follow up:

//     Can you solve it in O(N) time and O(1) space?

func backspaceCompare(_ S: String, _ T: String) -> Bool {
    var s = S, t = T
    reduceBackspace(&s)
    reduceBackspace(&t)
    return s == t
}

func reduceBackspace(_ s: inout String) {
    var i = s.startIndex
    while i < s.endIndex {
        if s[i] == "#" {
            s.remove(at: i)
            if i > s.startIndex {
                s.remove(at: s.index(before: i))
                i = s.index(before: i)
            }
        } else {
            i = s.index(after: i)
        }
    }
}