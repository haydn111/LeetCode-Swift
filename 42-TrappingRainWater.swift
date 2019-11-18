// Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.

// Example:

// Input: [0,1,0,2,1,0,1,3,2,1,2,1]
// Output: 6

// https://leetcode.com/problems/trapping-rain-water/description/

func trap(_ height: [Int]) -> Int {
    if height.count < 3 { return 0 }
    var trappedWater = 0
    var l = 0, r = height.count - 1
    var leftMax = 0, rightMax = 0
    
    while l < r {
        leftMax = max(leftMax, height[l])
        rightMax = max(rightMax, height[r])
        
        if leftMax > rightMax {
            trappedWater += rightMax - height[r]
            r -= 1
        } else {
            trappedWater += leftMax - height[l]
            l += 1
        }
    }
    return trappedWater
}