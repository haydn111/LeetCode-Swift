// Given a circular array (the next element of the last element is the first element of the array), print the Next Greater Number for every element. The Next Greater Number of a number x is the first greater number to its traversing-order next in the array, which means you could search circularly to find its next greater number. If it doesn't exist, output -1 for this number.

// Example 1:
// Input: [1,2,1]
// Output: [2,-1,2]
// Explanation: The first 1's next greater number is 2; 
// The number 2 can't find next greater number; 
// The second 1's next greater number needs to search circularly, which is also 2.
// Note: The length of given array won't exceed 10000.


// Use the stack to store the index of elements seen so far. When traverse from end of array, for each #, first pop from stack until stack top > current #. Stack top is the next greater # of current #. If stack is empty then next greater # is -1. Push current # into stack before moving backwards to next #.
// Need to repeat this process twice as the array is circular.
func nextGreaterElements(_ nums: [Int]) -> [Int] {
    if nums.count == 0 { return [] }
    var stack = [Int](), result = [Int](repeating: -1, count: nums.count)
    var i = nums.count - 1, round = 0
    while round <= 1 {
        while let top = stack.last, nums[top] <= nums[i] { 
            stack.removeLast()
        }
        if stack.count > 0 {
            result[i] = nums[stack.last!]
        }
        stack.append(i)
        i -= 1
        if i < 0 {
            i = nums.count - 1
            round += 1
        }
    }
    return result
}