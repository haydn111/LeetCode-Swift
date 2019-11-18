// Implement pow(x, n), which calculates x raised to the power n.

func myPow(_ x: Double, _ n: Int) -> Double {
    if n == 0 { return 1 }
    if n < 0 { return 1.0 / myPow(x, -n) }
    let sqrt = myPow(x, n / 2)
    if n % 2 == 0 {
        return sqrt * sqrt
    } else {
        return x * sqrt * sqrt
    }
}