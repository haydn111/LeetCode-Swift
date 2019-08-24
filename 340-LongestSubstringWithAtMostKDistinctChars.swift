// Given a string, find the length of the longest substring T that contains at most k distinct characters.
// For example, Given s = “eceba” and k = 2,
// T is "ece" which its length is 3.

func lengthOfLongestSubstringKDistinct(_ s: String, _ k: Int) -> Int {
    if s.count == 0 { return 0 }
    var l = 0, r = 0, maxLen = 0
    var dict = [s.first!: 1], distinctCount = 1
    while r < s.count {
        if distinctCount <= k {
            maxLen = max(maxLen, r - l + 1)
            r += 1
            if r < s.count {
                if dict[s[r]] == nil { dict[s[r]] = 0 }
                if dict[s[r]]! == 0 { distinctCount += 1 }
                dict[s[r]]! += 1
            }
        } else {
            dict[s[l]]! -= 1
            if dict[s[l]]! == 0 { distinctCount -= 1 }
            l += 1
        }
    }
    return maxLen
}