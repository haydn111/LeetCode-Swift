// Given an input string (s) and a pattern (p), implement regular expression matching with support for '.' and '*'.

// '.' Matches any single character.
// '*' Matches zero or more of the preceding element.
// The matching should cover the entire input string (not partial).

// Note:

// s could be empty and contains only lowercase letters a-z.
// p could be empty and contains only lowercase letters a-z, and characters like . or *.

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

class Solution {
    func isMatch(_ s: String, _ p: String) -> Bool {
        var match = [[Bool]]()      // match[i][j] = first i chars in s and first j chars in p are match
        for i in 0...s.count {
            match.append(Array(repeating: false, count: p.count + 1))
            for j in 0...p.count {
                // empty string matches empty string
                if i == 0 && j == 0 { 
                    match[0][0] = true 
                }
                
                // if s is empty, p has a *, then look at 2nd char before '*' in p
                // Example "aa" matches "a*"
                if i == 0 && j > 1 && p[j - 1] == "*" {
                    match[0][j] = match[0][j - 2]
                }
            }
        }

        if s.count > 0 && p.count > 0 {
            for i in 1...s.count {
                for j in 1...p.count {
                    // if a char in s matches a char in p then look at their previous ones
                    if p[j - 1] == "." || p[j - 1] == s[i - 1] {
                        match[i][j] = match[i - 1][j - 1]   
                    } else if p[j - 1] == "*" {
                        if s[i - 1] == p[j - 2] || p[j - 2] == "." {
                            match[i][j] = match[i][j - 2] || match[i - 1][j]    // abc, abcd* || abcddd..., abcd*
                        } else {
                            match[i][j] = match[i][j - 2]       // abcd, abcde*
                        }
                    }
                }
            }
        }

        return match[s.count][p.count]
    }

    /// Recursion without memorization
    func isMatch_R(_ s: String, _ p: String) -> Bool {
        if p.count == 0 {
            return s.count == 0
        }

        let firstMatch = s.count > 0 && (s.first == p.first ||
                                         p.first == ".")
        if p.count >= 2 && p[1] == "*" {
            return (firstMatch && isMatch_R(String(s.dropFirst()), p)) ||
                   isMatch_R(s, String(p.suffix(p.count - 2)))
        } else {
            return firstMatch && isMatch_R(String(s.dropFirst()), String(p.dropFirst()))
        }
    }
}