// Given an unsorted array nums, reorder it in-place such that nums[0] <= nums[1] >= nums[2] <= nums[3]....

// For example, given nums = [3, 5, 2, 1, 6, 4], one possible answer is [1, 6, 2, 5, 3, 4].

// 思路: 遍历一遍数组, 如果是奇数位置并且其值比下一个大,则交换其值, 如果是偶数位置并且其值比下一个小, 则交换其值. 时间复杂度是O(N)

func wiggleSort(_ array: [Int]) -> [Int] {
    var i = 0, nums = array
    while i < array.count - 1 {
        if (i % 2 == 1 && nums[i] > nums[i + 1]) ||
            (i % 2 == 0 && nums[i] < nums[i + 1]) {
                nums.swapAt(i, i + 1)
        }
        i += 1
    }
    return nums
}