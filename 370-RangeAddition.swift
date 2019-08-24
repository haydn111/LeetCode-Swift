// Assume you have an array of length n initialized with all 0's and are given k update operations.

// Each operation is represented as a triplet: [startIndex, endIndex, inc] which increments each element of subarray A[startIndex ... endIndex] (startIndex and endIndex inclusive) with inc.

// Return the modified array after all k operations were executed.

// Example:

// Given:

//     length = 5,
//     updates = [
//         [1,  3,  2],
//         [2,  4,  3],
//         [0,  2, -2]
//     ]

// Output:

//     [-2, 0, 3, 5, 3]
// Explanation:

// Initial state:
// [ 0, 0, 0, 0, 0 ]

// After applying operation [1, 3, 2]:
// [ 0, 2, 2, 2, 0 ]

// After applying operation [2, 4, 3]:
// [ 0, 2, 5, 5, 3 ]

// After applying operation [0, 2, -2]:
// [-2, 0, 3, 5, 3 ]
// Hint:

// Thinking of using advanced data structures? You are thinking it too complicated.
// For each update operation, do you really need to update all elements between i and j?
// Update only the first and end element is sufficient.
// The optimal time complexity is O(k + n) and uses O(1) extra space.


// 只更新开头结尾两个数字就行了，创建一个长度为length+1的数组，在每个range开头坐标位置加上inc，而在结束位置加1的地方加上-inc，那么根据题目中的例子，我们可以得到一个数组，nums = {-2, 2, 3, 2, -2, -3}，然后我们发现对其做累加和就是我们要求的结果result = {-2, 0, 3, 5, 3}
// Idea is convert ranges into sum. Mark the first element to +inc means all #s from this # needs to +inc. And all #s from last+1 does not change
func getModifiedArray(_ length: Int, _ updates: [[Int]]) -> [Int] {
    var nums = [Int](repeating: 0, count: length + 1)   // can further optimize by using result array to store nums
    for update in updates {
        nums[update[0]] += update[2]
        nums[update[1] + 1] -= update[2]
    }
    var sum = 0, result = [Int]()
    for i in 0..<length {
        sum += nums[i]
        result.append(sum)
    }
    return result
}