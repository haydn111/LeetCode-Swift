// Given an unsorted array of integers, find the length of the longest consecutive elements sequence.

// Your algorithm should run in O(n) complexity.

// Example:

// Input: [100, 4, 200, 1, 3, 2]
// Output: 4
// Explanation: The longest consecutive elements sequence is [1, 2, 3, 4]. Therefore its length is 4.

// Maintain two ends of sequence. time: O(n), space: O(n)
func longestConsecutive(_ nums: [Int]) -> Int {
    var dict = [Int: Int]()
    var maxLength = 0
    for num in nums {
        if dict[num] == nil {
            var left = dict[num - 1] ?? 0, right = dict[num + 1] ?? 0
            var seq = left + 1 + right  // build current sequence by bridging its left and right neighbor sequences
            // Important! Update the left and right ends of the sequence
            dict[num - left] = seq    
            dict[num + right] = seq
            dict[num] = seq // prevent dups in nums
            maxLength = max(maxLength, seq)
        }
    }
    return maxLength
}

// !!! Do not use this solution since it's inefficient under certain case. !!!
func longestConsecutive(_ nums: [Int]) -> Int {
    var maxLength = 0
    var leftBound = Int.max, rightBound = Int.min
    var mySet = Set<Int>()
    for num in nums {
        mySet.insert(num)
        leftBound = min(leftBound, num)
        rightBound = max(rightBound, num)
    }

    var length = 0
    // this loop could take far more than O(n) time when numbers are separated greatly apart from each other.
    // e.g. [2147483646,-2147483647,0,2,2147483644,-2147483645,2147483645]
    for num in leftBound...rightBound { 
        if mySet.contains(num) { 
            length += 1 
            maxLength = max(maxLength, length)
        } else {
            length = 0
        }
    }
    return maxLength
}