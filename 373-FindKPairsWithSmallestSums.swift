// You are given two integer arrays nums1 and nums2 sorted in ascending order and an integer k.

// Define a pair (u,v) which consists of one element from the first array and one element from the second array.

// Find the k pairs (u1,v1),(u2,v2) ...(uk,vk) with the smallest sums.

// Example 1:
// Given nums1 = [1,7,11], nums2 = [2,4,6],  k = 3

// Return: [1,2],[1,4],[1,6]

// The first 3 pairs are returned from the sequence:
// [1,2],[1,4],[1,6],[7,2],[7,4],[11,2],[7,6],[11,4],[11,6]

// Example 2:
// Given nums1 = [1,1,2], nums2 = [1,2,3],  k = 2

// Return: [1,1],[1,1]

// The first 2 pairs are returned from the sequence:
// [1,1],[1,1],[1,2],[2,1],[1,2],[2,2],[1,3],[1,3],[2,3]

// Example 3:
// Given nums1 = [1,2], nums2 = [3],  k = 3 

// Return: [1,3],[2,3]

// All possible pairs are returned from the sequence:
// [1,3],[2,3]


// Use a min heap to maintain maintain K possible smallest pairs. first insert (n1[0], n2[0]), (n1[1], n2[0]), ... into heap. Then everytime remove the smallest sum pair from the heap and insert the pair of same number in nums1 but next number in nums2 into the heap. E.g. after (n1[0], n2[0]) is removed, insert (n1[0], n2[1]) into heap.
class Solution {
    func kSmallestPairs(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [[Int]] {
        if nums1.count == 0 || nums2.count == 0 { return [[Int]]() }
        let heap = MinHeap()
        // init: (put nums1[i], nums2[0]) into heap
        for i in 0 ..< min(nums1.count, k) {
            heap.insert(HeapNode(nums1[i], i, nums2[0], 0))
        }

        var result = [[Int]](), i = 0
        while i < k && heap.count > 0 {
            let node = heap.removeMin()!
            result.append([node.n1, node.n2])
            if node.index2 + 1 < nums2.count {
                heap.insert(HeapNode(node.n1, node.index1, nums2[node.index2 + 1], node.index2 + 1))
            }
            i += 1
        }
        return result
    }
}

class HeapNode {
    var n1: Int     // num in num1
    var index1: Int // index in num1
    var n2: Int     // num in num2
    var index2: Int // index in num2
    var val: Int {
        return n1 + n2
    }
    init(_ n1: Int, _ i1: Int, _ n2: Int, _ i2: Int) {
        self.n1 = n1; self.n2 = n2
        self.index1 = i1; self.index2 = i2
    }
}

class MinHeap {
    var nums = [HeapNode]()
    var count: Int {
        return nums.count
    }
    
    func insert(_ n: HeapNode) {
        nums.append(n)
        // shift up
        var i = nums.count - 1
        while let parent = parent(of: i), nums[parent].val > n.val {
            nums.swapAt(i, parent)
            i = parent
        }
    }
    
    func removeMin() -> HeapNode? {
        if nums.count == 0 { return nil }
        nums.swapAt(0, nums.count - 1)
        let min = nums.removeLast()
        // shift down
        var i = 0
        var left = leftChild(of: i)
        var right = rightChild(of: i)
        while (left != nil && nums[i].val > nums[left!].val) || 
                (right != nil && nums[i].val > nums[right!].val) {
            var min = minChild(left, right)!
            nums.swapAt(i, min) 
            i = min
            left = leftChild(of: i)
            right = rightChild(of: i)
        }
        return min
    }
    
    private func parent(of i: Int) -> Int? {
        return (i - 1) / 2 >= 0 ? (i - 1) / 2 : nil
    }
    
    private func leftChild(of i: Int) -> Int? {
        return 2 * i + 1 < nums.count ? 2 * i + 1 : nil
    }
    
    private func rightChild(of i: Int) -> Int? {
        return 2 * i + 2 < nums.count ? 2 * i + 2 : nil
    }  
    
    private func minChild(_ i1: Int?, _ i2: Int?) -> Int? {
        if i1 == nil { return i2 }
        if i2 == nil { return i1 }
        return nums[i1!].val < nums[i2!].val ? i1! : i2!
    }
}
