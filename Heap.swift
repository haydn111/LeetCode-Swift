import Foundation

class MinHeap<HeapNode: Comparable> {
    var nums = [HeapNode]()
    var count: Int {
        return nums.count
    }
    
    func insert(_ n: HeapNode) {
        nums.append(n)
        // shift up
        var i = nums.count - 1
        while let parent = parent(of: i), nums[parent] > n {
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
        while (left != nil && nums[i] > nums[left!]) ||
              (right != nil && nums[i] > nums[right!]) {
            let min = minChild(left, right)!
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
        guard let i1 = i1 else { return i2 }
        guard let i2 = i2 else { return i1 }
        return nums[i1] < nums[i2] ? i1 : i2
    }
}

let array = [99, 82, 81, 25, 33, 14, 10]
let myHeap = MinHeap(with: array)
print(myHeap.nums)
print(myHeap.removeMin() ?? -1)
print(myHeap.nums)
