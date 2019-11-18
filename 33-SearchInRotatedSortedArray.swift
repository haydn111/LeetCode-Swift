// Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.

// (i.e., [0,1,2,4,5,6,7] might become [4,5,6,7,0,1,2]).

// You are given a target value to search. If found in the array return its index, otherwise return -1.

// You may assume no duplicate exists in the array.

// Your algorithm's runtime complexity must be in the order of O(log n).

// Example 1:

// Input: nums = [4,5,6,7,0,1,2], target = 0
// Output: 4

// Example 2:

// Input: nums = [4,5,6,7,0,1,2], target = 3
// Output: -1

func search(_ nums: [Int], _ target: Int) -> Int {
    if nums.count == 0 { return -1 }
    
    // find the pivot
    var l = 0, h = nums.count - 1
    while l < h {
        var mid = (l + h) / 2
        if nums[mid] == target { return mid }
        if nums[mid] > nums[h] { l = mid + 1 }
        else { h = mid }
    }
    
    // at this point l = h = smallest # = real head
    var realHead = l
    if target <= nums.last! {
        l = realHead
        h = nums.count - 1
    } else {
        l = 0
        h = realHead - 1
    }
    
    while l < h {
        var mid = (l + h) / 2
        if target == nums[mid] { return mid }
        else if target < nums[mid] { h = mid - 1 }
        else { l = mid + 1 }
    }
    
    return nums[l] == target ? l : -1
}
