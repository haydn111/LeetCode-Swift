// Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.

// Note: For the purpose of this problem, we define empty string as valid palindrome.

// Example 1:

// Input: "A man, a plan, a canal: Panama"
// Output: true
// Example 2:

// Input: "race a car"
// Output: false

extension Character {
    var ascii: UInt32? {
        return String(self).unicodeScalars.filter { $0.isASCII }.first?.value
    }
    
    func isAlphanumeric() -> Bool {
        // guard let ascii = self.ascii else { return false }
        // return (ascii >= 65 && ascii <= 90) || (ascii >= 97 && ascii <= 122) || (ascii >= 48 && ascii <= 57)
        return (self >= "A" && self <= "Z") || (self >= "a" && self <= "z") || (self >= "0" && self <= "9")
    }
}

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

class Solution {    
    func isPalindrome(_ s: String) -> Bool {
        var string = s.lowercased()
        var l = 0, r = string.count - 1
        while l < r {
            while l < r && !string[l].isAlphanumeric() { l += 1 }
            while l < r && !string[r].isAlphanumeric() { r -= 1 }
            if l >= r { break }
            if string[l] != string[r] { return false }
            l += 1
            r -= 1
        }
        return true
    }
}