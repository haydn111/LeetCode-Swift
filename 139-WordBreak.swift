// Given a non-empty string s and a dictionary wordDict containing a list of non-empty words, determine if s can be segmented into a space-separated sequence of one or more dictionary words.

// Note:

// The same word in the dictionary may be reused multiple times in the segmentation.
// You may assume the dictionary does not contain duplicate words.

// Example 1:

// Input: s = "leetcode", wordDict = ["leet", "code"]
// Output: true
// Explanation: Return true because "leetcode" can be segmented as "leet code".

// Example 2:

// Input: s = "applepenapple", wordDict = ["apple", "pen"]
// Output: true
// Explanation: Return true because "applepenapple" can be segmented as "apple pen apple".
//              Note that you are allowed to reuse a dictionary word.

// Example 3:

// Input: s = "catsandog", wordDict = ["cats", "dog", "sand", "and", "cat"]
// Output: false

class Solution {
    var wordSet = Set<String>()

    // 1. Normal recursion solution: TLE
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        wordSet = Set(wordDict)
        return breakWord(s)
    }

    func breakWord(_ s: String) -> Bool {
        let length = s.count
        if length == 0 {
            return true
        }

        var result = false
        for i in 1 ... length {
            let prefix = s.prefix(i)
            if wordSet.contains(String(prefix)) {
                result = result || breakWord(String(s.suffix(length - i)))
            }
        }
        return result
    }


    // 2. Recursion with memorization: Accepted
    var qualifiedWords = Set<String>()
    var unQualifiedWords = Set<String>()

    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        wordSet = Set(wordDict)
        qualifiedWords = wordSet
        return breakWord(s)
    }

    func breakWord(_ s: String) -> Bool {
        let length = s.count
        if length == 0 {
            return true
        }
        if qualifiedWords.contains(s) {
            return true
        }
        if unQualifiedWords.contains(s) {
            return false
        }
        var result = false
        for i in 1 ... length {
            let prefix = s.prefix(i)
            if wordSet.contains(String(prefix)) {
                result = result || breakWord(String(s.suffix(length - i)))
            }
            if result {
                qualifiedWords.insert(s)
                break
            }
        }
        if !result {
            unQualifiedWords.insert(s)
        }
        return result
    }


    // 3. DP solution
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        wordSet = Set(wordDict)
        return breakWord(s)
    }

    func breakWord(_ s: String) -> Bool {
        let length = s.count
        var dp = Array(repeating: false, count: length)  // dp[i] = s[0...i] is in dict
        
        for i in 0 ..< length {
            for j in stride(from: i, through: 0, by: -1) {
                if wordSet.contains(String(s[j...i])) {
                    if j == 0 || dp[j - 1] {
                        dp[i] = true
                        break
                    }
                }
            }
        }
        return dp[length - 1]
    }
}

extension String {
    subscript (range: CountableClosedRange<Int>) -> Substring {
        return self[index(startIndex, offsetBy: range.lowerBound)...index(startIndex, offsetBy: range.upperBound)]
    }
}
