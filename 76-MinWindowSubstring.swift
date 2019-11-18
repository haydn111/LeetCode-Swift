// Given a string S and a string T, find the minimum window in S which will contain all the characters in T in complexity O(n).

// Example:

// Input: S = "ADOBECODEBANC", T = "ABC"
// Output: "BANC"
// Note:

// If there is no such window in S that covers all characters in T, return the empty string "".
// If there is such window, you are guaranteed that there will always be only one unique minimum window in S.

/// O(n) solution
func minWindow(_ s: String, _ t: String) -> String {
    if s.count == 0 || t.count == 0 {
        return ""
    }
    
    let s = Array(s)
    let t = Array(t)
    
    var tDict = emptyCharacterDictionary()
    var sWindowDict = emptyCharacterDictionary()
    
    for char in t {
        tDict[char]! += 1
    }
    
    var l = 0, r = -1,
        count = 0,
        minLenth = Int.max,
        resultL = -1, resultR = -1
    
    while r < s.count {
        if count < t.count {    // move right ptr
            r += 1
            guard r < s.count else {
                break
            }
            
            let charAtRInS = s[r]
            sWindowDict[charAtRInS]! += 1

            let numOfThisCharInT = tDict[charAtRInS]!
            let numOfThisCharInWindowOfS = sWindowDict[charAtRInS]!
            if numOfThisCharInT > 0 && numOfThisCharInWindowOfS <= numOfThisCharInT {
                count += 1
            }
        } else {
            if r - l + 1 < minLenth {
                minLenth = r - l + 1
                resultL = l
                resultR = r
            }
            
            // move left ptr
            let charAtLInS = s[l]
            sWindowDict[charAtLInS]! -= 1

            let numOfThisCharInT = tDict[charAtLInS]!
            let numOfThisCharInWindowOfS = sWindowDict[charAtLInS]!
            if numOfThisCharInT > 0 && numOfThisCharInWindowOfS < numOfThisCharInT {
                count -= 1
            }
            
            l += 1
        }
    }
    
    if resultL >= 0 && resultR >= 0 {
        return String(s[resultL...resultR])
    }
    return ""
}

func emptyCharacterDictionary() -> [Character: Int] {
    let asciiCharacters = String(Array(0...127).map {
        Character(Unicode.Scalar($0))
    });
    var dict = [Character: Int]()
    for char in asciiCharacters {
        dict[char] = 0
    }
    return dict
}


/// Optimized O(n) solution
var dictT = [Character: Int]()
var dictS = [Character: Int]()
    
func minWindow(_ s: String, _ t: String) -> String {
    let s = Array(s)
    let t = Array(t)

    for i in 0..<t.count {
        let char = t[i]
        dictT[char] = (dictT[char] ?? 0) + 1
    }
    
    if s.count == 0 { return "" }
    
    var l = findNext(from: -1, s)   // left pointer
    var r = l                       // right pointer
    if isValid(l, s) {
        dictS[s[l]] = 1
    }
    
    var minLength = Int.max             // length of result substring
    var count = isValid(l, s) ? 1 : 0   // count of t chars in current substring of s
    var finalL: Int? = nil, finalR: Int? = nil  // l and r to form solution
    
    while (l <= r && isValid(l, s) && isValid(r, s)) {
        // print(l, r, dictS)
        if count >= t.count {
            // print(s[l...r])
            if r - l + 1 < minLength {
                minLength = r - l + 1
                finalL = l
                finalR = r
            }
            let charL = s[l]
            if (dictS[charL] ?? 1) <= (dictT[charL] ?? 1) { count -= 1 }
            dictS[charL] = (dictS[charL] ?? 1) - 1
            l = findNext(from: l, s)
        } else {
            r = findNext(from: r, s)
            if isValid(r, s) {
                let charR = s[r]
                if (dictS[charR] ?? 0) < (dictT[charR] ?? 1) { count += 1 }
                dictS[charR] = (dictS[charR] ?? 0) + 1
            }
        }
    }
    if finalL != nil && finalR != nil {
        return String(s[finalL!...finalR!])
    } else {
        return ""
    }
}

func findNext(from i: Int, _ s: [Character]) -> Int {
    var index = i + 1
    while index < s.count && !((dictT[s[index]] ?? 0) > 0) { index += 1 }
    return index
}

func isValid(_ i: Int, _ s: [Character]) -> Bool {
    return i >= 0 && i < s.count
}

