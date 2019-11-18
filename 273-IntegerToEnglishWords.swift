// Convert a non-negative integer to its english words representation. Given input is guaranteed to be less than 231 - 1.

// Example 1:
// Input: 123
// Output: "One Hundred Twenty Three"

// Example 2:
// Input: 12345
// Output: "Twelve Thousand Three Hundred Forty Five"

// Example 3:
// Input: 1234567
// Output: "One Million Two Hundred Thirty Four Thousand Five Hundred Sixty Seven"

/*
Have arrays for words of below 20, tens and thousands. 

Build a util function turn a three or less digit number into words. Pay attention the last two digits could be below or above twenty.

Result string = prefix + separator + infix + separator + suffix
suffix = correct word in thousands array
infix = words of n % 1000 (last three digits)
prefix = words of n / 1000 (without last three digits)
*/

class Solution {
    let below20 = "Zero One Two Three Four Five Six Seven Eight Nine Ten Eleven Twelve Thirteen Fourteen Fifteen Sixteen Seventeen Eighteen Nineteen".split(separator: " ")
    let tens = "Twenty Thirty Forty Fifty Sixty Seventy Eighty Ninety".split(separator: " ")
    let thousands = ["", "Thousand", "Million", "Billion"]
    
    func numberToWords(_ num: Int) -> String {
        if num == 0 { return "Zero" }
        return nToS(num, 0)
    }

    func nToS(_ n: Int, _ i: Int) -> String {
        let part = n % 1000
        let pre = n / 1000
        let prefixString = pre > 0 ? nToS(pre, i + 1) : ""
        let infixString = smallNToS(part)
        let suffixString = infixString.count > 0 ? thousands[i] : ""
        return prefixString + (separator(between: prefixString, infixString)) + infixString + (separator(between: infixString, suffixString)) + suffixString
    }
    
    func smallNToS(_ n: Int) -> String {    // turn a number < 1000 into string
        var d1 = n / 100, d2 = n % 100 / 10, d3 = n % 10
        var s = ""
        if d1 > 0 { 
            s += below20[d1]
            s += " Hundred" 
        }
        if d2 > 0 { 
            if d2 == 1 {    // 10 to 19
                if s.count > 0 { s += " " }
                s += below20[n % 100] 

            }
            else {      // 20 or above
                if s.count > 0 { s += " " }
                s += tens[d2 - 2] 
            }
        }
        // else if d1 != 0 && d3 != 0 { s += " And" }
        if d2 != 1 && d3 > 0 { 
            if s.count > 0 { s += " " }
            s += below20[d3] 
        }
        return s
    }
    
    func separator(between s1: String, _ s2: String) -> String {
        return s1.count > 0 && s2.count > 0 ? " " : ""
    }
}