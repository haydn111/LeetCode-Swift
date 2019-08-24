// Given a binary array, find the maximum number of consecutive 1s in this array if you can flip at most one 0.

// Example 1:

// Input: [1,0,1,1,0]
// Output: 4
// Explanation: Flip the first zero will get the the maximum number of consecutive 1s.
//     After flipping, the maximum number of consecutive 1s is 4.
 

// Note:

// The input array will only contain 0 and 1.
// The length of input array is a positive integer and will not exceed 10,000
 

// Follow up:
// What if the input numbers come in one by one as an infinite stream? In other words, you can't store all numbers coming from the stream as it's too large to hold in memory. Could you solve it efficiently?

/*
Only traverse the array once. Use oneCount to record consecutive one count. When hit 0, first res = oneCount + prevOneCount. Then still increment oneCount, then update prevOneCount and reset oneCount. Pay attention to order of operations.
*/
func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
    if nums.count == 0 { return 0 }
    var res = 0, oneCount = 0, prevOneCount = 0
    for num in nums {
        if num == 0 {
            res = max(res, prevOneCount + oneCount)
            oneCount += 1
            prevOneCount = oneCount
            oneCount = 0
        } else {
            oneCount += 1
        }
    }
    res = max(res, prevOneCount + oneCount)
    return res
}
