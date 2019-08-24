// Given an array of integers and an integer k, you need to find the total number of continuous subarrays whose sum equals to k.

// Example 1:
// Input:nums = [1,1,1], k = 2
// Output: 2
// Note:
// The length of the array is in range [1, 20,000].
// The range of numbers in the array is [-1000, 1000] and the range of the integer k is [-1e7, 1e7].


// Use a hash map to record eailer cumulative_sums and their count. Every time we see a sum, if map[sum - k] also exist, then there are map[sum - k] new subarrays that sums to k. 
// Notice our map need has map[0] = 1 for any first m items sums to k. 
func subarraySum(_ nums: [Int], _ k: Int) -> Int {
    var dict = [Int: Int]() // [cumulative_sum: #_of_occurance]
    dict[0] = 1 // there's always 1 way to get sum 0 which is not select anything
    var sum = 0, count = 0
    for num in nums {
        sum += num
        if let prevSumCount = dict[sum - k] {
            count += prevSumCount
        }
        if dict[sum] == nil { dict[sum] = 0 }
        dict[sum]! += 1
    }
    return count
}