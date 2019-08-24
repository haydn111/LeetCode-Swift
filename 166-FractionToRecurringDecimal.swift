// Given two integers representing the numerator and denominator of a fraction, return the fraction in string format.

// If the fractional part is repeating, enclose the repeating part in parentheses.

// Example 1:

// Input: numerator = 1, denominator = 2
// Output: "0.5"

// Example 2:

// Input: numerator = 2, denominator = 1
// Output: "2"

// Example 3:

// Input: numerator = 2, denominator = 3
// Output: "0.(6)"

// Use a map the store the remainder and the postion. If we see the same remainder again, means there is a loop. So insert left parenthes to prev same remainder's location and append right parenthes. 
// Pay attention to the sign as the sign of remainder is not always the same with final result.
func fractionToDecimal(_ numerator: Int, _ denominator: Int) -> String {
    if numerator == 0 { return "0" }
    if denominator == 0 { return String(Int.max) }
    
    var result = String(abs(numerator / denominator)), remainder = abs(numerator % denominator)
    var dict = [Int: Int]()  // remainder: position
    let sign = (numerator > 0 && denominator < 0) || (numerator < 0 && denominator > 0) ? "-" : ""
    if remainder != 0 { result.append(".") }
    while remainder != 0 {
        if let prevRmdPos = dict[remainder] {
            result.insert("(", at: result.index(result.startIndex, offsetBy: prevRmdPos))
            result.append(")")
            return sign + result
        } else {
            dict[remainder] = result.count
        }
        result += String(remainder * 10 / abs(denominator))
        remainder = remainder * 10 % abs(denominator)
    }
    return sign + result
}