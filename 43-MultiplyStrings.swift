// Given two non-negative integers num1 and num2 represented as strings, return the product of num1 and num2, also represented as a string.

// Example 1:

// Input: num1 = "2", num2 = "3"
// Output: "6"
// Example 2:

// Input: num1 = "123", num2 = "456"
// Output: "56088"

// Note:

// The length of both num1 and num2 is < 110.
// Both num1 and num2 contain only digits 0-9.
// Both num1 and num2 do not contain any leading zero, except the number 0 itself.
// You must not use any built-in BigInteger library or convert the inputs to integer directly.

// n = number, d = digit, c = carry from last multiplicaiton
func multToSingleDigit(_ n: String, _ d: Character, _ c: String) -> String {    
    if n == "0" || d == "0" { return c }
    // parent carry is everything except last digit in last multiplicaiton!
    var num = n, result = "", carry = 0, d2 = Int(String(d))!, parentCarry = c  
    while num.count > 0 {
        let d1 = Int(String(num.removeLast()))!
        var partial = d1 * d2 + carry
        if parentCarry.count > 0 { partial += Int(String(parentCarry.removeLast()))! }
        result = String(partial % 10) + result
        carry = partial / 10
    }
    if carry > 0 { result = String(carry) + result }
    return result
}

func multiply(_ num1: String, _ num2: String) -> String {
    if num1 == "0" || num2 == "0" { return "0" }
    var carry = "", n2 = num2, result = ""
    while n2.count > 0 {
        let d = n2.removeLast()
        var partialResult = multToSingleDigit(num1, d, carry)
        if partialResult.count == 0 { partialResult = "0" }
        result = String(partialResult.removeLast()) + result
        carry = partialResult
    }
    if carry.count > 0 { result = carry + result }
    return result
}

print(multiply("5", "601"))