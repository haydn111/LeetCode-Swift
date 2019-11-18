// Given an array of integers with possible duplicates, randomly output the index of a given target number. You can assume that the given target number must exist in the array.

// Note:
// The array size can be very large. Solution that uses too much extra space will not pass the judge.

// Example:

// int[] nums = new int[] {1,2,3,3,3};
// Solution solution = new Solution(nums);

// // pick(3) should return either index 2, 3, or 4 randomly. Each index should have equal probability of returning.
// solution.pick(3);

// // pick(1) should return 0. Since in the array only nums[0] is equal to 1.
// solution.pick(1);

class Solution {
    var nums: [Int]
    init(_ nums: [Int]) {
        self.nums = nums
    }

    func pick(_ target: Int) -> Int {
        var count = 0
        var result = 0
        for i in 0..<nums.count {
            if i == target {
                count += 1
                if Int(arc4random_uniform(count)) == 0 { 
                    result = i  // chance of select current element is 1/count
                                // chance of keep old result is also 1/count
                }
            }
        }
        return result
    }
}

