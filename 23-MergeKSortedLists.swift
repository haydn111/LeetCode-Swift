/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */

class MinHeap {
    private var nums = [ListNode]()
    var count: Int {
        return nums.count
    }
    
    func insert(_ n: ListNode) {
        nums.append(n)
        // shift up
        var i = nums.count - 1
        while let parent = parent(of: i), nums[parent].val > n.val {
            nums.swapAt(i, parent)
            i = parent
        }
    }
    
    func removeMin() -> ListNode? {
        if nums.count == 0 { return nil }
        nums.swapAt(0, nums.count - 1)
        let min = nums.removeLast()
        // shift down
        var i = 0
        var left = leftChild(of: i)
        var right = rightChild(of: i)
        while (left != nil && nums[i].val > nums[left!].val) || 
                (right != nil && nums[i].val > nums[right!].val) {
            if left != nil && nums[i].val > nums[left!].val { 
                nums.swapAt(i, left!) 
                i = left!
            }
            if right != nil && nums[i].val > nums[right!].val { 
                nums.swapAt(i, right!) 
                i = right!
            }
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
}

class Solution {
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var myLists = lists
        var resultList = ListNode(Int.max)  // dummy head
        var curr = resultList
        let heap = MinHeap()
        for l in myLists {
            if let list = l { heap.insert(list) }
        }
        while heap.count > 0 {
            curr.next = heap.removeMin()!
            curr = curr.next!
            if curr.next != nil { heap.insert(curr.next!) }
        }
        return resultList.next
    }
}