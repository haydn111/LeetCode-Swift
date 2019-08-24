// Implement int sqrt(int x).

// Compute and return the square root of x, where x is guaranteed to be a non-negative integer.

// Since the return type is an integer, the decimal digits are truncated and only the integer part of the result is returned.

// Hint: binary search to find the last number for which (m * m <= x) is true.

func mySqrt(_ x: Int) -> Int {
    var low = 1, high = x
    while low != high {
        var mid = (low + high) / 2
        if mid * mid <= x && (mid + 1) * (mid + 1) > x { return mid }
        else if mid * mid > x { high = mid - 1 }
        else { low = mid + 1 }
    }
    return low
}