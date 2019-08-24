// Write a program to find the nth super ugly number.

// Super ugly numbers are positive numbers whose all prime factors are in the given prime list primes of size k.

// Example:

// Input: n = 12, primes = [2,7,13,19]
// Output: 32 
// Explanation: [1,2,4,7,8,13,14,16,19,26,28,32] is the sequence of the first 12 
//              super ugly numbers given primes = [2,7,13,19] of size 4.

// Note:
// 1 is a super ugly number for any given primes.
// The given numbers in primes are in ascending order.
// 0 < k ≤ 100, 0 < n ≤ 106, 0 < primes[i] < 1000.
// The nth super ugly number is guaranteed to fit in a 32-bit signed integer.


// The next ugly number is prime[i] multiply some exising ugly number. 
// dp solution. At each round figure out the next smallest ugly number among primes[i] * ugly[idx[i]]. Then update the idx array
// idx[i] records the index of ugly # such that prime[i] * ugly[idx[i]] > ugly.last > any of current ugly #s. idx help remove duplicate multiplications by getting ready to generate the next ugly # for each prime #.
func nthSuperUglyNumber(_ n: Int, _ primes: [Int]) -> Int {
    var ugly = [1], idx = [Int](repeating: 0, count: primes.count)
    for i in 1..<n {
        var minUgly = Int.max
        for j in 0..<primes.count {
            minUgly = min(minUgly, primes[j] * ugly[idx[j]])
        }
        ugly.append(minUgly)
        for j in 0..<primes.count {
            if primes[j] * ugly[idx[j]] <= ugly[i] { idx[j] += 1 }
        }
    }
    return ugly[n - 1]
}
