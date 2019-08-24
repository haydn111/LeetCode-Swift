// Implement next permutation, which rearranges numbers into the lexicographically next greater permutation of numbers.

// If such arrangement is not possible, it must rearrange it as the lowest possible order (ie, sorted in ascending order).

// The replacement must be in-place and use only constant extra memory.

// Here are some examples. Inputs are in the left-hand column and its corresponding outputs are in the right-hand column.

// 1,2,3 → 1,3,2
// 3,2,1 → 1,2,3
// 1,1,5 → 1,5,1


// 1. Find the largest (search backwards) index k such that nums[k] < nums[k + 1]. If no such index exists, the permutation is sorted in descending order, just reverse it to ascending order and we are done. For example, the next permutation of [3, 2, 1] is [1, 2, 3].
// 2. Find the largest (search backwards) index l greater than k such that nums[k] < nums[l].
// 3. Swap the value of nums[k] with that of nums[l].
// 4. Reverse the sequence from nums[k + 1] up to and including the final element nums[nums.size() - 1].
// This algorithm already handles duplicates

func nextPermutation(_ nums: inout [Int]) {
    if nums.count <= 1 { return }
    var k = nums.count - 2
    while k >= 0 && nums[k] >= nums[k + 1] {
        if k == 0 {     // no such k can be found. nums in descending order
            nums = nums.reversed(); return
        }
        k -= 1
    }
    
    var l = nums.count - 1
    while l > k && nums[l] <= nums[k] {
        l -= 1
    }
    nums.swapAt(k, l)
    nums = nums[0...k] + nums[k + 1 ..< nums.count].reversed()
}
