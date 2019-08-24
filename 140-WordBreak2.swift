// Given a non-empty string s and a dictionary wordDict containing a list of non-empty words, add spaces in s to construct a sentence where each word is a valid dictionary word. Return all such possible sentences.

// Note:

// The same word in the dictionary may be reused multiple times in the segmentation.
// You may assume the dictionary does not contain duplicate words.
// Example 1:

// Input:
// s = "catsanddog"
// wordDict = ["cat", "cats", "and", "sand", "dog"]
// Output:
// [
//   "cats and dog",
//   "cat sand dog"
// ]
// Example 2:

// Input:
// s = "pineapplepenapple"
// wordDict = ["apple", "pen", "applepen", "pine", "pineapple"]
// Output:
// [
//   "pine apple pen apple",
//   "pineapple pen apple",
//   "pine applepen apple"
// ]
// Explanation: Note that you are allowed to reuse a dictionary word.
// Example 3:

// Input:
// s = "catsandog"
// wordDict = ["cats", "dog", "sand", "and", "cat"]
// Output:
// []

extension String {
    subscript (range: CountableClosedRange<Int>) -> Substring {
        return self[index(startIndex, offsetBy: range.lowerBound)...index(startIndex, offsetBy: range.upperBound)]
    }
}

class Solution {
    // DP solution
    func wordBreak(_ s: String, _ wordDict: [String]) -> [String] {
        if !isBreakable(s, wordDict) { return [] }
        
        var dp = Array(repeating: [String](), count: s.count)  // dp[i] = dict representation of s[0...i]
        for i in 0..<s.count {
            for j in stride(from: i, to: -1, by: -1) {
                if wordDict.contains(String(s[j...i])) {
                    if j == 0 {
                        dp[i] += [String(s[0...i])]
                    } else if dp[j - 1].count > 0 {
                        var combinations = dp[j - 1].map { $0 + " " + String(s[j...i]) }
                        dp[i] += combinations
                    }
                }
            }
        }
        return dp[s.count - 1]
    }
    
    // dfs solution
    var dict = [String: [String]]() // use dict to remember the solution found before
    func wordBreak(_ s: String, _ wordDict: [String]) -> [String] {
        if s.count == 0 { return [] }
        if dict[s] != nil { return dict[s]! }
        var solution = [String]()
        for i in 0..<s.count {
            if wordDict.contains(String(s[0...i])) {
                if i < s.count - 1 {
                    let partialSolution = wordBreak(String(s[i + 1...s.count - 1]), wordDict)
                    dict[String(s[i + 1...s.count - 1])] = partialSolution
                    solution += partialSolution.map { s[0...i] + " " + $0 }
                } else {    // dict contains s itself
                    solution += [s]
                }
            }
        }
        dict[s] = solution
        return solution
    }

    // First use Word Break I to check of s is breakable. This avoids Time Limit Exceeded error
    func isBreakable(_ s: String, _ wordDict: [String]) -> Bool {
        var dp = Array(repeating: false, count: s.count)  // dp[i] = s[0...i] is in dict
        
        for i in 0..<s.count {
            for j in stride(from: i, to: -1, by: -1) {
                if wordDict.contains(String(s[j...i])) {
                    if j == 0 || dp[j - 1] {
                        dp[i] = true
                        break
                    }
                }
            }
        }
        return dp[s.count - 1]
    }
}