// Given a positive integer, return its corresponding column title as appear in an Excel sheet.

// For example:

//     1 -> A
//     2 -> B
//     3 -> C
//     ...
//     26 -> Z
//     27 -> AA
//     28 -> AB 
//     ...

// Example 1:

// Input: 1
// Output: "A"

// Example 2:

// Input: 28
// Output: "AB"

// Example 3:

// Input: 701
// Output: "ZY"

extension Int {
    var charValue: Character {
        return Character(UnicodeScalar(self)!)
    }
}

class Solution {
    func convertToTitle(_ n: Int) -> String {
        var ascii = [Int]()
        var i = n
        while i - 1 >= 0 {
            ascii.insert((i - 1) % 26, at: 0)
            i = (i - 1) / 26
        }
        return String(ascii.map { (65 + $0).charValue })
    }
}