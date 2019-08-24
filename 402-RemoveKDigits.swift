// Given a non-negative integer num represented as a string, remove k digits from the number so that the new number is the smallest possible.

// Note:
// The length of num is less than 10002 and will be ≥ k.
// The given num does not contain any leading zero.
// Example 1:

// Input: num = "1432219", k = 3
// Output: "1219"
// Explanation: Remove the three digits 4, 3, and 2 to form the new number 1219 which is the smallest.
// Example 2:

// Input: num = "10200", k = 1
// Output: "200"
// Explanation: Remove the leading 1 and the number is 200. Note that the output must not contain leading zeroes.
// Example 3:

// Input: num = "10", k = 2
// Output: "0"
// Explanation: Remove all the digits from the number and it is left with nothing which is 0.


// First think about remove one digit: Remove first peak digit will give smallest number. Peak means first num[i] > num[i+1]
// To remove K times, use a stack to store the digits. Once we found stack top is a peak digit, keep pop the stack until stack top is not a peak, or we already removed k times. E.g. 123450, k = 4 -> 10
// Finally if k removal is not reached, remove from top of stack (end of num)
func removeKdigits(_ num: String, _ k: Int) -> String {
    if k >= num.count { return "0" }
    var stack = [Character](), i = 0, myK = k
    for i in 0 ..< num.count - 1 {
        stack.append(num[i])
        var next = num[i + 1]
        while myK > 0 && stack.count > 0 && Int(String(stack.last!))! > Int(String(next))! {
            stack.removeLast(); myK -= 1;
        } 
    }
    stack.append(num.last!)
    while myK > 0 { stack.removeLast(); myK -= 1 }
    while stack.first == "0" && stack.count > 1 { stack.removeFirst() }
    return String(stack)
}
