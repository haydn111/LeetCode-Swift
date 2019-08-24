// Given two binary strings, return their sum (also a binary string).
// The input strings are both non-empty and contains only characters 1 or 0.

// Example 1:

// Input: a = "11", b = "1"
// Output: "100"

// Example 2:

// Input: a = "1010", b = "1011"
// Output: "10101"

class Solution {    
    func addBinary(_ a: String, _ b: String) -> String {
        var carry = 0
        var result = ""
        var first = a
        var second = b
        
        while (first.count > 0 || second.count > 0 || carry > 0) {
            var firstBit = 0, secondBit = 0
            if first.count > 0 { firstBit = Int(String(first.last!))! }
            if second.count > 0 { secondBit = Int(String(second.last!))! }
            switch firstBit + secondBit + carry {
                case 3:
                    result = "1" + result
                    carry = 1
                case 2: 
                    result = "0" + result
                    carry = 1
                case 1:
                    result = "1" + result
                    carry = 0
                default:
                    result = "0" + result
                    carry = 0
            }
            if first.count > 0 { 
                first.removeLast()
            }
            if second.count > 0 { 
                second.removeLast()
            }
        }
        
        return result
    }
}