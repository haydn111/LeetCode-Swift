import Foundation

class HeapNode {
    var val: Int
    init(_ val: Int) {
        self.val = val
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

var array = [99, 82, 81, 25, 33, 14, 10]
let myHeap = MinHeap(with: array)
print(myHeap.heap)
myHeap.remove(10)
print(myHeap.heap)
