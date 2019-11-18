// Given an array with n objects colored red, white or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white and blue.

// Here, we will use the integers 0, 1, and 2 to represent the color red, white, and blue respectively.

// Note: You are not suppose to use the library's sort function for this problem.

// Example:

// Input: [2,0,2,1,1,0]
// Output: [0,0,1,1,2,2]
// Follow up:

// A rather straight forward solution is a two-pass algorithm using counting sort.
// First, iterate the array counting number of 0's, 1's, and 2's, then overwrite array with total number of 0's, then 1's and followed by 2's.
// Could you come up with a one-pass algorithm using only constant space?

func sortColors(_ nums: inout [Int]) {
    var r = 0, w = 0, b = 0
    var curr = 0
    while curr < nums.count {
        if nums[curr] == 0 {
            nums[b] = 2; b += 1
            nums[w] = 1; w += 1
            nums[r] = 0; r += 1
        } else if nums[curr] == 1 {
            nums[b] = 2; b += 1
            nums[w] = 1; w += 1
        } else {    // 2
            nums[b] = 2; b += 1
        }
        curr += 1
    }
}

// O(n^2) since remove(at:) and insert both takes O(n)
func sortColors(_ nums: inout [Int]) {
    var r = 0, w = 0, b = 0
    var curr = 0
    while curr < nums.count {
        let num = nums.remove(at: curr)
        switch num {
            case 0: 
                nums.insert(num, at: r)
                r += 1; w += 1; b += 1
            case 1: 
                nums.insert(num, at: w)
                w += 1; b += 1
            case 2:
                nums.insert(num, at: b)
                b += 1
            default: break
        }
        curr += 1
    }
}