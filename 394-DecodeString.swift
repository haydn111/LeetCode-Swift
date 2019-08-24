// Given an encoded string, return it's decoded string.

// The encoding rule is: k[encoded_string], where the encoded_string inside the square brackets is being repeated exactly k times. Note that k is guaranteed to be a positive integer.

// You may assume that the input string is always valid; No extra white spaces, square brackets are well-formed, etc.

// Furthermore, you may assume that the original data does not contain any digits and that digits are only for those repeat numbers, k. For example, there won't be input like 3a or 2[4].

// Examples:

// s = "3[a]2[bc]", return "aaabcbc".
// s = "3[a2[c]]", return "accaccacc".
// s = "2[abc]3[cd]ef", return "abcabccdcdcdef".

class Solution {
    func decodeString(_ s: String) -> String {
        return decodeString(s, from: 0, to: s.count - 1)
    }
    
    var decoded = [String: String]()
    func decodeString(_ s: String, from: Int, to: Int) -> String {
        if s.count == 0 { return s }
        var slice = String(s[from...to])
        if let prevResult = decoded[slice] { return prevResult }
        var result = "", i = from
        while i <= to {
            if s[i] >= "0" && s[i] <= "9" {
                var openBracket = i + 1
                while s[openBracket] != "[" { openBracket += 1 }
                var closeBracket = findMatchClosingBracket(in: s, from: openBracket, upTo: to)
                var repeatCount = Int(String(s[i..<openBracket]))!
                result += String(repeating: decodeString(s, from: openBracket + 1, to: closeBracket - 1), count: repeatCount)
                i = closeBracket + 1
            } else {    // s[i] should be simple letters
                result.append(s[i])
                i += 1
            }
        }
        decoded[slice] = result
        return result
    }
    
    // from is the index of open bracket. return index of close bracket
    func findMatchClosingBracket(in s: String, from: Int, upTo: Int) -> Int { 
        var count = 1, j = from + 1
        while j <= upTo && count != 0 { 
            if s[j] == "[" { count += 1 }
            else if s[j] == "]" { count -= 1 }
            j += 1
        }
        return j - 1
    }
}

extension String {
    subscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript(range: CountableClosedRange<Int>) -> Substring {
        return self[index(startIndex, offsetBy: range.lowerBound)...index(startIndex, offsetBy: range.upperBound)]
    }
    
    subscript(range: Range<Int>) -> Substring {
        return self[index(startIndex, offsetBy: range.lowerBound)...index(startIndex, offsetBy: range.upperBound - 1)]
    }

}