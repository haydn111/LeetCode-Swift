
// Given a non-negative integer, you could swap two digits at most once to get the maximum valued number. Return the maximum valued number you could get.

// Example 1:
// Input: 2736
// Output: 7236
// Explanation: Swap the number 2 and the number 7.
// Example 2:
// Input: 9973
// Output: 9973
// Explanation: No swap.
// Note:
// The given number is in the range [0, 10^8]

// 思路：如果有一个低位数字比高位数字要大，那么交换它们肯定能使得当前数变得更大。为了在交换后得到最大的数，不但需要：与可能的最高位交换，也需要：确保你交换到最高位的数要尽量足够大。

// 算法如下:

// 从最低位一直遍历到最高位，存储迄今为止最大的数字。

// 如果当前数字比迄今为止最大的数字小，那么存储swap索引：当前数字的索引和迄今为止最大数字的索引。
// 如果当前数字比迄今为止最大的数字大，那么重置 迄今为止最大的数字。

// 最后，交换之前存储的两个swap索引。重新计算数字。

func maximumSwap(_ num: Int) -> Int {
    var maxFoundSoFar = Int.min
    var indexOfMax = -1
    var swapIndex1 = 0, swapIndex2 = 0
    var digits = [Int]()

    var number = num
    while number > 0 {
        var digit = number % 10
        digits.insert(digit, at: 0)
        if digit > maxFoundSoFar { 
            maxFoundSoFar = digit 
            indexOfMax = digits.count - 1
        } 
        else if digit < maxFoundSoFar {
            swapIndex1 = indexOfMax
            swapIndex2 = digits.count - 1
        }
        number /= 10
    }
    digits.swapAt(swapIndex1, swapIndex2)
    return Int(digits.map{ String($0) }.joined(separator: ""))!
}

print(maximumSwap(9973))
