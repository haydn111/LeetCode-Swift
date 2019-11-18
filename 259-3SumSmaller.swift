// Given an array of n integers nums and a target, find the number of index triplets i, j, k with 0 <= i < j < k < n that satisfy the condition nums[i] + nums[j] + nums[k] < target.

// For example, given nums = [-2, 0, 1, 3], and target = 2.

// Return 2. Because there are two triplets which sums are less than 2:

// [-2, 0, 1]
// [-2, 0, 3]

// Follow up:
// Could you solve it in O(n^2) runtime?

// 思路:首先对数组进行排序. 然后同样是先确定一位, 然后双指针一个在最左边, 一个在最右边. 如果三个数的和小于target, 也就是nums[i]+nums[left]+nums[right] < target, 那么nums[i]+nums[left]+在区间[left+1, right-1]之间的所有数一定<target, 因为这个区间的数都小于nums[right], 所以一次可以得到几个组合方式, 也就是right-left个答案. 然后再让left++, 继续做即可. 注意到这个之后就可以很容易得到答案. 时间复杂度O(N^2).
// E.g. in [-2, 0, 1, 3], if [-2, 0, 3] < target then  [-2, 0, 1] also < target

func threeSumSmaller(_ nums: [Int], _ target: Int) -> Int {
    var sorted = nums.sorted()
    var i = 0, count = 0
    while i < nums.count - 2 {
        var j = i + 1, k = nums.count - 1
        while j < k {
            if nums[i] + nums[j] + nums[k] < target {
                count += k - j
                j += 1
            } else {
                k -= 1
            }
        }
        i += 1
    }
    return count
}