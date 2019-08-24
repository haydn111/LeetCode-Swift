// Given two integers dividend and divisor, divide two integers without using multiplication, division and mod operator.

// Return the quotient after dividing dividend by divisor.

// The integer division should truncate toward zero.

// Example 1:

// Input: dividend = 10, divisor = 3
// Output: 3

// Example 2:

// Input: dividend = 7, divisor = -3
// Output: -2
// Note:

// Both dividend and divisor will be 32-bit signed integers.
// The divisor will never be 0.
// Assume we are dealing with an environment which could only store integers within the 32-bit signed integer range: [−231,  231 − 1]. For the purpose of this problem, assume that your function returns 231 − 1 when the division result overflows.

func divide(_ dividend: Int, _ divisor: Int) -> Int {
    if divisor == 0 { return Int.max }
    if dividend == 0 { return 0 }
    
    let negativeResult = (dividend > 0 && divisor < 0) || (dividend < 0 && divisor > 0)
    var result = binaryDivide(Int64(abs(dividend)), Int64(abs(divisor)))
    result = negativeResult ? -result : result
    if result > Int32.max { result = Int64(Int32.max) }
    else if result < Int32.min { result = Int64(Int32.min) }
    return Int(result)
}

func binaryDivide(_ d1: Int64, _ d2: Int64) -> Int64 {
    if d1 < d2 { return 0 }
    
    var sum = d2, count = Int64(1)
    while sum + sum <= d1 {
        sum += sum
        count += count
    }
    
    return count + binaryDivide(d1 - sum, d2)        
}
