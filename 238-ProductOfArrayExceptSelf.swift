// Given an array nums of n integers where n > 1,  return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].

// Example:

// Input:  [1,2,3,4]
// Output: [24,12,8,6]
// Note: Please solve it without division and in O(n).

// Follow up:
// Could you solve it with constant space complexity? (The output array does not count as extra space for the purpose of space complexity analysis.)

// O(n) space
func productExceptSelf(_ nums: [Int]) -> [Int] {
    var fromLeft = [nums.first!], fromRight = [nums.last!]
    for i in 1..<nums.count {
        fromLeft.append(nums[i] * fromLeft.last!)
        fromRight.insert(nums[nums.count - i - 1] * fromRight.first!, at: 0)
    }
    var result = [Int]()
    for i in 0..<nums.count {
        var res = 1
        if i > 0 { res *= fromLeft[i - 1] }
        if i < nums.count - 1 { res *= fromRight[i + 1] }
        result.append(res)
    }
    return result
}

// O(1) space
func productExceptSelf(_ nums: [Int]) -> [Int] {
    var res = [nums.first!]
    for i in 1..<nums.count {
        res.append(nums[i] * res.last!)
    }
    var fromRight = 1
    for i in stride(from: nums.count - 1, through: 0, by: -1) {
        if i > 0 {
            res[i] = res[i - 1] * fromRight
        } else { res[i] = fromRight }
        fromRight *= nums[i]
    }
    return res        
}
